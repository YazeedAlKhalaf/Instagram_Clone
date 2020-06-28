import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:instagram_clone/src/app/generated/router/router.gr.dart';
import 'package:instagram_clone/src/app/models/post_model.dart';
import 'package:instagram_clone/src/app/models/user_model.dart';
import 'package:instagram_clone/src/ui/global/custom_base_view_model.dart';

class ProfileViewModel extends CustomBaseViewModel {
  bool _isFollowing = false;
  int _displayPosts = 0; // 0 - grid, 1 - column
  User _profileUser;
  String _userId;

  bool get isFollowing => _isFollowing;
  int get displayPosts => _displayPosts;
  User get profileUser => _profileUser;
  String get userId => _userId;

  setDisplayPosts(int displayPosts) {
    _displayPosts = displayPosts;
    notifyListeners();
  }

  setProfileUser(User profileUserNewValue) {
    _profileUser = profileUserNewValue;
    notifyListeners();
  }

  initialize({
    @required String userId,
  }) async {
    setBusy(true);
    _getVariables(userId: userId);
    await _setupProfileUser();
    await _setupIsFollowing();
    setBusy(false);
  }

  _getVariables({
    @required String userId,
  }) {
    _userId = userId;
  }

  _setupIsFollowing() async {
    bool isFollowingUser = await firestoreService.isFollowingUser(
      currentUserId: currentUser.id,
      userId: currentUser.id,
    );
    _isFollowing = isFollowingUser;
    notifyListeners();
  }

  _setupProfileUser() async {
    StreamController<DocumentSnapshot> _profileUserStreamController =
        StreamController<DocumentSnapshot>();
    _profileUserStreamController.addStream(
      firestoreService.getUserWithIdStream(userId),
    );
    Stream<DocumentSnapshot> _profileUserStream =
        _profileUserStreamController.stream;
    _profileUserStream.listen((DocumentSnapshot profileUserNewValue) {
      setProfileUser(User.fromMap(profileUserNewValue.data));
    });
  }

  followOrUnfollow() {
    if (_isFollowing) {
      _unfollowUser();
    } else {
      _followUser();
    }
  }

  _unfollowUser() {
    firestoreService.unfollowUser(
      currentUserId: currentUser.id,
      userId: _userId,
    );
    _isFollowing = false;
    // _followerCount--;
    notifyListeners();
  }

  _followUser() {
    firestoreService.followUser(
      currentUserId: currentUser.id,
      userId: _userId,
    );
    _isFollowing = true;
    // _followerCount++;
    notifyListeners();
  }

  Future<void> signout() async {
    await authenticationService.signOut();
    await navigationService.pushNamedAndRemoveUntil(
      Routes.loginViewRoute,
    );
  }

  navigateToOnePostView({
    @required Post post,
    @required User author,
  }) async {
    await navigationService.navigateTo(
      Routes.onePostViewRoute,
      arguments: OnePostViewArguments(
        post: post,
        author: author,
      ),
    );
  }

  navigateToEditProfileView() async {
    await navigationService.navigateTo(
      Routes.editProfileViewRoute,
    );
  }
}
