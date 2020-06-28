import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:instagram_clone/src/app/generated/router/router.gr.dart';
import 'package:instagram_clone/src/app/models/post_model.dart';
import 'package:instagram_clone/src/app/models/user_model.dart';
import 'package:instagram_clone/src/ui/global/custom_base_view_model.dart';

class PostWidgetModel extends CustomBaseViewModel {
  Post _post;
  User _author;

  Post get post => _post;
  User get author => _author;

  int _likeCount = 0;
  bool _isLiking = false;
  bool _isLiked = false;
  bool _heartAnim = false;

  int get likeCount => _likeCount;
  bool get isLiking => _isLiking;
  bool get isLiked => _isLiked;
  bool get heartAnim => _heartAnim;

  setLikeCount(int likeCountNewValue) {
    _likeCount = likeCountNewValue;
  }

  initialize({
    @required Post post,
    @required User author,
  }) async {
    getVariables(
      post: post,
      author: author,
    );
    // await _getLikesCount();
    await _initPostLiked();
  }

  getVariables({
    @required Post post,
    @required User author,
  }) {
    _post = post;
    _author = author;
  }

  _initPostLiked() async {
    bool isLiked = await firestoreService.didLikePost(
      currentUserId: currentUser.id,
      post: _post,
    );
    _isLiked = isLiked;
    notifyListeners();
  }

  likePost() async {
    if (!_isLiking) {
      if (_isLiked) {
        // Unlike post
        _isLiking = true;

        firestoreService.unlikePost(
          currentUserId: currentUser.id,
          post: _post,
        );
        _isLiked = false;
        _likeCount -= 1;
        // await _getLikesCount();

        Timer(
          Duration(milliseconds: 650),
          () {
            _isLiking = false;
            notifyListeners();
          },
        );
      } else {
        // Like post
        _isLiking = true;

        firestoreService.likePost(
          currentUserId: currentUser.id,
          post: _post,
        );
        _heartAnim = true;
        _isLiked = true;
        _likeCount += 1;
        // await _getLikesCount();

        notifyListeners();

        Timer(
          Duration(milliseconds: 750),
          () {
            _heartAnim = false;
            notifyListeners();
          },
        );

        Timer(
          Duration(milliseconds: 650),
          () {
            _isLiking = false;
            notifyListeners();
          },
        );
      }
    } else {
      return;
    }
  }

  navigateToProfileView() async {
    await navigationService.navigateTo(
      Routes.profileViewRoute,
      arguments: ProfileViewArguments(
        userId: post.authorId,
      ),
    );
  }

  navigateToCommentsView() async {
    await navigationService.navigateTo(
      Routes.commentsViewRoute,
      arguments: CommentsViewArguments(
        post: post,
        likeCount: _likeCount,
      ),
    );
  }
}
