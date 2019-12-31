import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_instagram_clone/models/comment_model.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/user_data.dart';
import '../models/user_model.dart';
import '../services/database_service.dart';
import '../utilities/constants.dart';

class CommentsScreen extends StatefulWidget {
  final String postId;
  final int likeCount;

  CommentsScreen({
    this.postId,
    this.likeCount,
  });
  @override
  _CommentsScreenState createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  MediaQueryData queryData;

  final TextEditingController _commentController = TextEditingController();
  bool _isCommenting = false;

  FutureBuilder _buildComment(Comment comment) {
    return FutureBuilder(
      future: DatabaseService.getUserWithId((comment.authorId)),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return SizedBox.shrink();
        }
        User author = snapshot.data;
        return ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.grey,
            backgroundImage: author.profileImageUrl.isEmpty
                ? AssetImage('assets/images/user_placeholder.png')
                : CachedNetworkImageProvider(author.profileImageUrl),
          ),
          title: Text(author.name),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(comment.content),
              SizedBox(height: queryData.size.width * 0.02),
              Text(
                DateFormat.yMd().add_jm().format(comment.timestamp.toDate()),
              ),
            ],
          ),
        );
      },
    );
  }

  _buildCommentTextField() {
    final currentUserId = Provider.of<UserData>(context).currentUserId;
    return IconTheme(
      data: IconThemeData(
        color: _isCommenting
            ? Theme.of(context).accentColor
            : Theme.of(context).disabledColor,
      ),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: queryData.size.width * 0.02),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(width: queryData.size.width * 0.025),
            Expanded(
              child: TextField(
                controller: _commentController,
                textCapitalization: TextCapitalization.sentences,
                onChanged: (comment) {
                  setState(() {
                    _isCommenting = comment.length > 0;
                  });
                },
                decoration: InputDecoration.collapsed(
                  hintText: 'Write a comment...',
                ),
              ),
            ),
            Container(
              margin:
                  EdgeInsets.symmetric(horizontal: queryData.size.width * 0.01),
              child: IconButton(
                icon: Icon(Icons.send),
                onPressed: () {
                  if (_isCommenting) {
                    DatabaseService.commentOnPost(
                      currentUserId: currentUserId,
                      postId: widget.postId,
                      comment: _commentController.text,
                    );
                    _commentController.clear();
                    setState(() {
                      _isCommenting = false;
                    });
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    queryData = MediaQuery.of(context);
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
            padding: EdgeInsets.all(queryData.size.width * 0.05),
            child: Text('Likes: ${widget.likeCount.toString()}'),
          ),
          StreamBuilder(
            stream: commentsRef
                .document(widget.postId)
                .collection('postComments')
                .orderBy('timestamp', descending: true)
                .snapshots(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Expanded(
                child: ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (BuildContext context, int index) {
                    Comment comment =
                        Comment.fromDoc(snapshot.data.documents[index]);
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
  }
}
