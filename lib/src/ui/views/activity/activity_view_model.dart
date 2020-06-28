import 'package:flutter/foundation.dart';
import 'package:instagram_clone/src/app/generated/router/router.gr.dart';
import 'package:instagram_clone/src/app/models/activity_model.dart';
import 'package:instagram_clone/src/app/models/post_model.dart';
import 'package:instagram_clone/src/ui/global/custom_base_view_model.dart';

class ActivityViewModel extends CustomBaseViewModel {
  List<Activity> _activities = <Activity>[];

  List<Activity> get activities => _activities;

  setActivities(List<Activity> activitiesNewValue) {
    _activities = activitiesNewValue;
    notifyListeners();
  }

  initState() async {
    setBusy(true);
    await setupActivities();
    setBusy(false);
  }

  setupActivities() async {
    List<Activity> activities =
        await firestoreService.getActivities(currentUser.id);
    setActivities(activities);
  }

  navigateToCommentsView({@required Post post}) async {
    await navigationService.navigateTo(
      Routes.commentsViewRoute,
      arguments: CommentsViewArguments(
        post: post,
        likeCount: post.likeCount,
      ),
    );
  }
}
