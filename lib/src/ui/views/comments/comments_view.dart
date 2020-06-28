import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/src/app/models/comment_model.dart';
import 'package:instagram_clone/src/app/models/post_model.dart';
import 'package:instagram_clone/src/app/models/user_model.dart';
import 'package:instagram_clone/src/ui/global/ui_helpers.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

import './comments_view_model.dart';

class CommentsView extends StatelessWidget {
  final Post post;
  final int likeCount;

  const CommentsView({
    this.post,
    this.likeCount,
  });

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CommentsViewModel>.reactive(
      viewModelBuilder: () => CommentsViewModel(),
      builder: (
        BuildContext context,
        CommentsViewModel model,
        Widget child,
      ) {
        FutureBuilder _buildComment(Comment comment) {
          return FutureBuilder(
            future: model.firestoreService.getUserWithId((comment.authorId)),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return SizedBox.shrink();
              }
              User author = snapshot.data;
              return ListTile(
                leading: CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.grey,
                  backgroundImage: author.profileImageUrl.isEmpty
                      ? AssetImage('assets/images/user_placeholder.png')
                      : CachedNetworkImageProvider(author.profileImageUrl),
                ),
                title: Text(
                  author.name,
                  style: Theme.of(context).textTheme.headline6,
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      comment.content,
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    SizedBox(height: blockSizeVertical(context)),
                    Text(
                      DateFormat.yMd()
                          .add_jm()
                          .format(comment.timestamp.toDate()),
                    ),
                  ],
                ),
              );
            },
          );
        }

        _buildCommentTextField() {
          return IconTheme(
            data: IconThemeData(
              color: model.isCommenting
                  ? Theme.of(context).accentColor
                  : Theme.of(context).disabledColor,
            ),
            child: Container(
              margin: EdgeInsets.symmetric(
                horizontal: blockSizeVertical(context),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  horizontalSpaceSmall(context),
                  Expanded(
                    child: TextField(
                      controller: model.commentController,
                      textCapitalization: TextCapitalization.sentences,
                      onChanged: (comment) {
                        model.setIsCommenting(comment.length > 0);
                      },
                      decoration: InputDecoration.collapsed(
                        hintText: 'Write a comment...',
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: blockSizeVertical(context),
                    ),
                    child: IconButton(
                      icon: Icon(Icons.send),
                      onPressed: () {
                        if (model.isCommenting) {
                          model.firestoreService.commentOnPost(
                            currentUserId: model.currentUser.id,
                            post: post,
                            comment: model.commentController.text,
                          );
                          model.commentController.clear();
                          model.setIsCommenting(false);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text(
              'Comments',
              style: TextStyle(color: Colors.black),
            ),
            centerTitle: true,
          ),
          body: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(blockSizeVertical(context) * 2.5),
                child: Text(
                  'Likes: ${likeCount.toString()}',
                  style: TextStyle(
                    fontSize: blockSizeVertical(context) * 2.5,
                  ),
                ),
              ),
              StreamBuilder<QuerySnapshot>(
                stream: model.firestoreService.getCommentsOfPostStream(post),
                builder: (
                  BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot,
                ) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (BuildContext context, int index) {
                        Comment comment = Comment.fromMap(
                            snapshot.data.documents[index].data);
                        return _buildComment(comment);
                      },
                    ),
                  );
                },
              ),
              Divider(height: 1.0),
              _buildCommentTextField(),
            ],
          ),
        );
      },
    );
  }
}
