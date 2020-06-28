// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';
import 'package:instagram_clone/src/ui/views/startup/startup_view.dart';
import 'package:instagram_clone/src/ui/views/home/home_view.dart';
import 'package:instagram_clone/src/ui/views/login/login_view.dart';
import 'package:instagram_clone/src/ui/views/signup/signup_view.dart';
import 'package:instagram_clone/src/ui/views/feed/feed_view.dart';
import 'package:instagram_clone/src/ui/views/search/search_view.dart';
import 'package:instagram_clone/src/ui/views/activity/activity_view.dart';
import 'package:instagram_clone/src/ui/views/profile/profile_view.dart';
import 'package:instagram_clone/src/ui/views/edit_profile/edit_profile_view.dart';
import 'package:instagram_clone/src/ui/views/create_post/create_post_view.dart';
import 'package:instagram_clone/src/ui/views/one_post/one_post_view.dart';
import 'package:instagram_clone/src/app/models/post_model.dart';
import 'package:instagram_clone/src/app/models/user_model.dart';
import 'package:instagram_clone/src/ui/views/comments/comments_view.dart';

abstract class Routes {
  static const startupViewRoute = '/';
  static const homeViewRoute = '/home-view-route';
  static const loginViewRoute = '/login-view-route';
  static const signupViewRoute = '/signup-view-route';
  static const feedViewRoute = '/feed-view-route';
  static const searchViewRoute = '/search-view-route';
  static const activityViewRoute = '/activity-view-route';
  static const profileViewRoute = '/profile-view-route';
  static const editProfileViewRoute = '/edit-profile-view-route';
  static const createPostViewRoute = '/create-post-view-route';
  static const onePostViewRoute = '/one-post-view-route';
  static const commentsViewRoute = '/comments-view-route';
  static const all = {
    startupViewRoute,
    homeViewRoute,
    loginViewRoute,
    signupViewRoute,
    feedViewRoute,
    searchViewRoute,
    activityViewRoute,
    profileViewRoute,
    editProfileViewRoute,
    createPostViewRoute,
    onePostViewRoute,
    commentsViewRoute,
  };
}

class Router extends RouterBase {
  @override
  Set<String> get allRoutes => Routes.all;

  @Deprecated('call ExtendedNavigator.ofRouter<Router>() directly')
  static ExtendedNavigatorState get navigator =>
      ExtendedNavigator.ofRouter<Router>();

  @override
  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case Routes.startupViewRoute:
        return MaterialPageRoute<dynamic>(
          builder: (context) => StartupView(),
          settings: settings,
        );
      case Routes.homeViewRoute:
        return MaterialPageRoute<dynamic>(
          builder: (context) => HomeView(),
          settings: settings,
        );
      case Routes.loginViewRoute:
        return MaterialPageRoute<dynamic>(
          builder: (context) => LoginView(),
          settings: settings,
        );
      case Routes.signupViewRoute:
        return MaterialPageRoute<dynamic>(
          builder: (context) => SignupView(),
          settings: settings,
        );
      case Routes.feedViewRoute:
        return MaterialPageRoute<dynamic>(
          builder: (context) => FeedView(),
          settings: settings,
        );
      case Routes.searchViewRoute:
        return MaterialPageRoute<dynamic>(
          builder: (context) => SearchView(),
          settings: settings,
        );
      case Routes.activityViewRoute:
        return MaterialPageRoute<dynamic>(
          builder: (context) => ActivityView(),
          settings: settings,
        );
      case Routes.profileViewRoute:
        if (hasInvalidArgs<ProfileViewArguments>(args, isRequired: true)) {
          return misTypedArgsRoute<ProfileViewArguments>(args);
        }
        final typedArgs = args as ProfileViewArguments;
        return MaterialPageRoute<dynamic>(
          builder: (context) => ProfileView(userId: typedArgs.userId),
          settings: settings,
        );
      case Routes.editProfileViewRoute:
        return MaterialPageRoute<dynamic>(
          builder: (context) => EditProfileView(),
          settings: settings,
        );
      case Routes.createPostViewRoute:
        return MaterialPageRoute<dynamic>(
          builder: (context) => CreatePostView(),
          settings: settings,
        );
      case Routes.onePostViewRoute:
        if (hasInvalidArgs<OnePostViewArguments>(args, isRequired: true)) {
          return misTypedArgsRoute<OnePostViewArguments>(args);
        }
        final typedArgs = args as OnePostViewArguments;
        return MaterialPageRoute<dynamic>(
          builder: (context) =>
              OnePostView(post: typedArgs.post, author: typedArgs.author),
          settings: settings,
        );
      case Routes.commentsViewRoute:
        if (hasInvalidArgs<CommentsViewArguments>(args)) {
          return misTypedArgsRoute<CommentsViewArguments>(args);
        }
        final typedArgs =
            args as CommentsViewArguments ?? CommentsViewArguments();
        return MaterialPageRoute<dynamic>(
          builder: (context) => CommentsView(
              post: typedArgs.post, likeCount: typedArgs.likeCount),
          settings: settings,
        );
      default:
        return unknownRoutePage(settings.name);
    }
  }
}

// *************************************************************************
// Arguments holder classes
// **************************************************************************

//ProfileView arguments holder class
class ProfileViewArguments {
  final String userId;
  ProfileViewArguments({@required this.userId});
}

//OnePostView arguments holder class
class OnePostViewArguments {
  final Post post;
  final User author;
  OnePostViewArguments({@required this.post, @required this.author});
}

//CommentsView arguments holder class
class CommentsViewArguments {
  final Post post;
  final int likeCount;
  CommentsViewArguments({this.post, this.likeCount});
}
