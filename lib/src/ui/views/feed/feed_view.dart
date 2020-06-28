import 'package:flutter/material.dart';
import 'package:instagram_clone/src/app/models/post_model.dart';
import 'package:instagram_clone/src/app/models/user_model.dart';
import 'package:instagram_clone/src/ui/theme/theme.dart';
import 'package:instagram_clone/src/ui/widgets/dumb_widgets/busy_overlay.dart';
import 'package:instagram_clone/src/ui/widgets/smart_widgets/post/post_widget.dart';
import 'package:stacked/stacked.dart';

import './feed_view_model.dart';

class FeedView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FeedViewModel>.reactive(
      viewModelBuilder: () => FeedViewModel(),
      onModelReady: (FeedViewModel model) async => await model.initialize(),
      builder: (
        BuildContext context,
        FeedViewModel model,
        Widget child,
      ) {
        return BusyOverlay(
          show: model.isBusy,
          child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                appName,
                style: TextStyle(
                  fontFamily: 'Billabong',
                  fontSize: 35.0,
                ),
              ),
            ),
            body: model.posts.length > 0
                ? RefreshIndicator(
                    onRefresh: () => model.setupFeed(),
                    child: ListView.builder(
                      itemCount: model.posts.length,
                      itemBuilder: (BuildContext context, int index) {
                        Post post = model.posts[index];

                        return FutureBuilder(
                          future: model.firestoreService
                              .getUserWithId(post.authorId),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (!snapshot.hasData) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            User author = snapshot.data;
                            return PostWidget(
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
          ),
        );
      },
    );
  }
}
