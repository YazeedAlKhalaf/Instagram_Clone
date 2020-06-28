import 'package:animator/animator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/src/app/models/post_model.dart';
import 'package:instagram_clone/src/app/models/user_model.dart';
import 'package:instagram_clone/src/ui/global/ui_helpers.dart';
import 'package:stacked/stacked.dart';

import 'post_widget_model.dart';

class PostWidget extends StatefulWidget {
  final Post post;
  final User author;

  const PostWidget({
    this.post,
    this.author,
  });

  @override
  _PostWidgetState createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PostWidgetModel>.reactive(
      viewModelBuilder: () => PostWidgetModel(),
      onModelReady: (PostWidgetModel model) async => await model.initialize(
        post: widget.post,
        author: widget.author,
      ),
      builder: (
        BuildContext context,
        PostWidgetModel model,
        Widget child,
      ) {
        return Wrap(
          children: <Widget>[
            GestureDetector(
              onTap: () async => await model.navigateToProfileView(),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 10.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        CircleAvatar(
                          radius: 25.0,
                          backgroundColor: Colors.grey,
                          backgroundImage: widget.author.profileImageUrl.isEmpty
                              ? AssetImage(
                                  'assets/images/placeholders/user_placeholder.png',
                                )
                              : CachedNetworkImageProvider(
                                  widget.author.profileImageUrl,
                                ),
                        ),
                        horizontalSpaceSmall(context),
                        Container(
                          width: blockSizeVertical(context) * 20,
                          child: Text(
                            widget.author.name,
                            overflow: TextOverflow.fade,
                            softWrap: false,
                            style: TextStyle(
                              fontSize: blockSizeVertical(context) * 2,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () => print('more'),
                      icon: Icon(
                        Icons.more_vert,
                        size: blockSizeVertical(context) * 3,
                      ),
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              onDoubleTap: () {
                if (!model.isLiking) {
                  model.likePost();
                }
              },
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(widget.post.imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  model.heartAnim
                      ? Animator(
                          duration: Duration(milliseconds: 750),
                          tween: Tween(begin: 0.5, end: 1.4),
                          curve: Curves.elasticOut,
                          builder: (anim) => Transform.scale(
                            scale: anim.value,
                            child: Icon(
                              Icons.favorite,
                              size: 100,
                              color: Colors.red,
                            ),
                          ),
                        )
                      : SizedBox.shrink(),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      IconButton(
                        icon: model.isLiked
                            ? Icon(
                                Icons.favorite,
                                color: Colors.red,
                              )
                            : Icon(Icons.favorite_border),
                        iconSize: 30.0,
                        onPressed: () {
                          if (!model.isLiking) {
                            model.likePost();
                          }
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.comment),
                        iconSize: 30.0,
                        onPressed: () async =>
                            await model.navigateToCommentsView(),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.0),
                    child: StreamBuilder<QuerySnapshot>(
                        stream: model.firestoreService.likesCountStream(
                          currentUserId: model.currentUser.id,
                          post: widget.post,
                        ),
                        builder: (
                          BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot,
                        ) {
                          if (!snapshot.hasData) {
                            return CircleAvatar(
                              radius: 15,
                            );
                          }

                          model.setLikeCount(snapshot.data.documents.length);
                          return Text(
                            '${snapshot.data.documents.length} likes',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        }),
                  ),
                  SizedBox(height: 4.0),
                  Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(
                          left: 12.0,
                          right: 6.0,
                        ),
                        child: Text(
                          widget.author.name,
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          widget.post.caption,
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.0),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
