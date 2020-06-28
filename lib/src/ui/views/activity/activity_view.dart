import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/src/app/models/activity_model.dart';
import 'package:instagram_clone/src/app/models/post_model.dart';
import 'package:instagram_clone/src/app/models/user_model.dart';
import 'package:instagram_clone/src/ui/widgets/dumb_widgets/busy_overlay.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stacked/stacked.dart';

import './activity_view_model.dart';

class ActivityView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ActivityViewModel>.reactive(
      viewModelBuilder: () => ActivityViewModel(),
      onModelReady: (ActivityViewModel model) async => await model.initState(),
      builder: (
        BuildContext context,
        ActivityViewModel model,
        Widget child,
      ) {
        _buildActivity(Activity activity) {
          return FutureBuilder<User>(
            future: model.firestoreService.getUserWithId(activity.fromUserId),
            builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
              if (!snapshot.hasData) {
                return Shimmer.fromColors(
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 20.0,
                      backgroundColor: Colors.grey,
                    ),
                    title: Container(
                      width: 200,
                      height: 25,
                      color: Colors.grey,
                    ),
                    subtitle: Container(
                      width: 150,
                      height: 20,
                      color: Colors.grey,
                    ),
                    trailing: Container(
                      width: 40,
                      height: 40,
                    ),
                  ),
                  baseColor: Colors.grey,
                  highlightColor: Colors.grey[400],
                );
              }
              User user = snapshot.data;
              return ListTile(
                leading: CircleAvatar(
                  radius: 20.0,
                  backgroundColor: Colors.grey,
                  backgroundImage: user.profileImageUrl.isEmpty
                      ? AssetImage('assets/images/user_placeholder.png')
                      : CachedNetworkImageProvider(user.profileImageUrl),
                ),
                title: activity.comment != null
                    ? Text('${user.name} commented: "${activity.comment}"')
                    : Text('${user.name} liked your post'),
                subtitle: Text(
                  DateFormat.yMd().add_jm().format(activity.timestamp.toDate()),
                ),
                trailing: CachedNetworkImage(
                  imageUrl: activity.postImageUrl,
                  height: 40.0,
                  width: 40.0,
                  fit: BoxFit.cover,
                ),
                onTap: () async {
                  Post post = await model.firestoreService.getUserPost(
                    model.currentUser.id,
                    activity.postId,
                  );

                  if (activity.comment != null) {
                    await model.navigateToCommentsView(post: post);
                  }
                },
              );
            },
          );
        }

        return BusyOverlay(
          show: model.isBusy,
          child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                'Activity',
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
            body: RefreshIndicator(
              onRefresh: () async => await model.setupActivities(),
              child: ListView.builder(
                itemCount: model.activities.length ?? 0,
                itemBuilder: (BuildContext context, int index) {
                  Activity activity = model.activities[index];
                  return _buildActivity(activity);
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
