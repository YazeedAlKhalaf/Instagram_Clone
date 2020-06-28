import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/src/app/models/post_model.dart';
import 'package:instagram_clone/src/ui/global/ui_helpers.dart';
import 'package:instagram_clone/src/ui/widgets/dumb_widgets/busy_overlay.dart';
import 'package:instagram_clone/src/ui/widgets/dumb_widgets/custom_button.dart';
import 'package:instagram_clone/src/ui/widgets/smart_widgets/post/post_widget.dart';
import 'package:stacked/stacked.dart';

import './profile_view_model.dart';

class ProfileView extends StatelessWidget {
  final String userId;

  const ProfileView({
    @required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileViewModel>.reactive(
      viewModelBuilder: () => ProfileViewModel(),
      onModelReady: (ProfileViewModel model) async => await model.initialize(
        userId: userId,
      ),
      builder: (
        BuildContext context,
        ProfileViewModel model,
        Widget child,
      ) {
        _displayButton() {
          return model.profileUser.id == model.currentUser.id
              ? CustomButton(
                  width: 200,
                  text: 'Edit Profile',
                  onPressed: () async =>
                      await model.navigateToEditProfileView(),
                )
              : CustomButton(
                  width: blockSizeVertical(context) * 30,
                  text: model.isFollowing ? 'Unfollow' : 'Follow',
                  buttonColor:
                      model.isFollowing ? Colors.grey[200] : Colors.blue,
                  textColor: model.isFollowing ? Colors.black : Colors.white,
                  onPressed: () => model.followOrUnfollow(),
                );
        }

        _buildProfileInfo() {
          return Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 0.0),
                child: Row(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 50.0,
                      backgroundColor: Colors.grey,
                      backgroundImage: model.profileUser.profileImageUrl.isEmpty
                          ? AssetImage(
                              'assets/images/placeholders/user_placeholder.png',
                            )
                          : CachedNetworkImageProvider(
                              model.profileUser.profileImageUrl,
                            ),
                    ),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              StreamBuilder<QuerySnapshot>(
                                  stream:
                                      model.firestoreService.getUserPostsStream(
                                    userId: model.profileUser.id,
                                  ),
                                  builder: (
                                    BuildContext context,
                                    AsyncSnapshot<QuerySnapshot> snapshot,
                                  ) {
                                    return Column(
                                      children: <Widget>[
                                        snapshot.hasData
                                            ? Text(
                                                snapshot.data.documents.length
                                                    .toString(),
                                                style: TextStyle(
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              )
                                            : Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
                                        Text(
                                          'posts',
                                          style: TextStyle(
                                            color: Colors.black54,
                                          ),
                                        ),
                                      ],
                                    );
                                  }),
                              StreamBuilder<QuerySnapshot>(
                                stream: model.firestoreService
                                    .followersNumberStream(userId),
                                builder: (
                                  BuildContext context,
                                  AsyncSnapshot<QuerySnapshot> snapshot,
                                ) {
                                  return Column(
                                    children: <Widget>[
                                      snapshot.hasData
                                          ? Text(
                                              snapshot.data.documents.length
                                                  .toString(),
                                              style: TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            )
                                          : Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                      Text(
                                        'followers',
                                        style: TextStyle(color: Colors.black54),
                                      ),
                                    ],
                                  );
                                },
                              ),
                              StreamBuilder<QuerySnapshot>(
                                stream: model.firestoreService
                                    .followingNumberStream(userId),
                                builder: (
                                  BuildContext context,
                                  AsyncSnapshot<QuerySnapshot> snapshot,
                                ) {
                                  return Column(
                                    children: <Widget>[
                                      snapshot.hasData
                                          ? Text(
                                              snapshot.data.documents.length
                                                  .toString(),
                                              style: TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            )
                                          : Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                      Text(
                                        'following',
                                        style: TextStyle(color: Colors.black54),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ],
                          ),
                          _displayButton(),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      model.profileUser.name,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Container(
                      height: 80.0,
                      child: Text(
                        model.profileUser.bio,
                        style: TextStyle(fontSize: 15.0),
                      ),
                    ),
                    Divider(),
                  ],
                ),
              ),
            ],
          );
        }

        _buildToggleButtons() {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.grid_on),
                iconSize: 30.0,
                color: model.displayPosts == 0
                    ? Theme.of(context).primaryColor
                    : Colors.grey[300],
                onPressed: () => model.setDisplayPosts(0),
              ),
              IconButton(
                icon: Icon(Icons.list),
                iconSize: 30.0,
                color: model.displayPosts == 1
                    ? Theme.of(context).primaryColor
                    : Colors.grey[300],
                onPressed: () => model.setDisplayPosts(1),
              ),
            ],
          );
        }

        _buildTilePost(Post post) {
          return GridTile(
            child: GestureDetector(
              onTap: () => model.navigateToOnePostView(
                post: post,
                author: model.profileUser,
              ),
              child: Image(
                image: CachedNetworkImageProvider(post.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          );
        }

        _buildDisplayPosts() {
          // Grid
          return StreamBuilder<QuerySnapshot>(
            stream: model.firestoreService
                .getUserPostsStream(userId: model.profileUser.id),
            builder: (
              BuildContext context,
              AsyncSnapshot<QuerySnapshot> snapshot,
            ) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (model.displayPosts == 0) {
                List<GridTile> tiles = [];

                snapshot.data.documents.forEach(
                  (post) => tiles.add(
                    _buildTilePost(
                      Post.fromMap(
                        post.data,
                      ),
                    ),
                  ),
                );

                return GridView.count(
                  crossAxisCount: 3,
                  childAspectRatio: 1.0,
                  mainAxisSpacing: 2.0,
                  crossAxisSpacing: 2.0,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: tiles,
                );
              } else {
                // Column
                List<PostWidget> postViews = [];

                snapshot.data.documents.forEach((post) {
                  postViews.add(
                    PostWidget(
                      post: Post.fromMap(post.data),
                      author: model.profileUser,
                    ),
                  );
                });
                return Column(
                  children: postViews,
                );
              }
            },
          );
        }

        return model.profileUser != null
            ? BusyOverlay(
                show: model.isBusy,
                child: Scaffold(
                  appBar: AppBar(
                    centerTitle: true,
                    title: Text(
                      model.profileUser.name,
                    ),
                    actions: <Widget>[
                      model.profileUser.id == model.currentUser.id
                          ? IconButton(
                              icon: Icon(Icons.exit_to_app),
                              onPressed: () async => await model.signout(),
                            )
                          : IconButton(
                              icon: Icon(Icons.more_vert),
                              onPressed: () =>
                                  print('User: ${model.profileUser.name}'),
                            ),
                    ],
                  ),
                  body: ListView(
                    children: <Widget>[
                      _buildProfileInfo(),
                      _buildToggleButtons(),
                      Divider(),
                      _buildDisplayPosts(),
                    ],
                  ),
                ),
              )
            : Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }
}
