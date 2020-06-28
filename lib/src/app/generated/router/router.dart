import 'package:auto_route/auto_route_annotations.dart';
import 'package:instagram_clone/src/ui/views/activity/activity_view.dart';
import 'package:instagram_clone/src/ui/views/comments/comments_view.dart';
import 'package:instagram_clone/src/ui/views/create_post/create_post_view.dart';
import 'package:instagram_clone/src/ui/views/edit_profile/edit_profile_view.dart';
import 'package:instagram_clone/src/ui/views/feed/feed_view.dart';
import 'package:instagram_clone/src/ui/views/login/login_view.dart';
import 'package:instagram_clone/src/ui/views/one_post/one_post_view.dart';
import 'package:instagram_clone/src/ui/views/profile/profile_view.dart';
import 'package:instagram_clone/src/ui/views/search/search_view.dart';
import 'package:instagram_clone/src/ui/views/signup/signup_view.dart';
import 'package:instagram_clone/src/ui/views/startup/startup_view.dart';
import 'package:instagram_clone/src/ui/views/home/home_view.dart';

@MaterialAutoRouter()
class $Router {
  @initial
  StartupView startupViewRoute;

  HomeView homeViewRoute;

  LoginView loginViewRoute;

  SignupView signupViewRoute;

  FeedView feedViewRoute;

  SearchView searchViewRoute;

  ActivityView activityViewRoute;

  ProfileView profileViewRoute;

  EditProfileView editProfileViewRoute;

  CreatePostView createPostViewRoute;

  OnePostView onePostViewRoute;

  CommentsView commentsViewRoute;
}
