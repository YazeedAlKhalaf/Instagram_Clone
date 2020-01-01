import 'package:flutter/material.dart';
import 'package:flutter_instagram_clone/models/post_model.dart';
import 'package:flutter_instagram_clone/models/user_model.dart';
import 'package:flutter_instagram_clone/services/database_service.dart';
import 'package:flutter_instagram_clone/widgets/post_view.dart';

import '../utilities/theme.dart';

class FeedScreen extends StatefulWidget {
  static final String id = 'feed_screen';
  final String currentUserId;

  FeedScreen({this.currentUserId});

  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  MediaQueryData queryData;

  List<Post> _posts = [];

  @override
  void initState() {
    super.initState();
    _setupFeed();
  }

  _setupFeed() async {
    List<Post> posts = await DatabaseService.getFeedPosts(widget.currentUserId);
    setState(() {
      _posts = posts;
    });
  }

  @override
  Widget build(BuildContext context) {
    queryData = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          app_name,
          style: TextStyle(
            fontFamily: 'Billabong',
            fontSize: 35.0,
          ),
        ),
      ),
      body: _posts.length > 0
          ? RefreshIndicator(
              onRefresh: () => _setupFeed(),
              child: ListView.builder(
                itemCount: _posts.length,
                itemBuilder: (BuildContext context, int index) {
                  Post post = _posts[index];
                  return FutureBuilder(
                    future: DatabaseService.getUserWithId(post.authorId),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      User author = snapshot.data;
                      return PostView(
                        currentUserId: widget.currentUserId,
                        post: post,
                        author: author,
                      );
                    },
                  );
                },
              ),
            )
          : Center(
              child: Text('Follow People To See Thier Feed'),
            ),
    );
  }
}
