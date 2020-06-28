import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:instagram_clone/src/app/models/activity_model.dart';
import 'package:instagram_clone/src/app/models/post_model.dart';
import 'package:instagram_clone/src/app/models/user_model.dart';

@lazySingleton
class FirestoreService {
  final CollectionReference _usersCollectionReference =
      Firestore.instance.collection('users');
  final _postsCollectionReference = Firestore.instance.collection('posts');
  final _followersCollectionReference =
      Firestore.instance.collection('followers');
  final followingRef = Firestore.instance.collection('following');
  final feedsRef = Firestore.instance.collection('feeds');
  final likesRef = Firestore.instance.collection('likes');
  final commentsRef = Firestore.instance.collection('comments');
  final activitiesRef = Firestore.instance.collection('activities');

  Future createUser(User user) async {
    try {
      await _usersCollectionReference.document(user.id).setData(
            user.toMap(),
          );
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }
      return e.toString();
    }
  }

  void updateUser(User user) {
    _usersCollectionReference.document(user.id).updateData({
      'name': user.name,
      'profileImageUrl': user.profileImageUrl,
      'bio': user.bio,
    });
  }

  Future<QuerySnapshot> searchUsers(String name) {
    Future<QuerySnapshot> users = _usersCollectionReference
        .where('name', isGreaterThanOrEqualTo: name)
        .getDocuments();
    return users;
  }

  Future<void> createPost(Post post) async {
    DocumentReference newPostDocumentRef = _postsCollectionReference
        .document(post.authorId)
        .collection('userPosts')
        .document();

    await newPostDocumentRef.setData(post.toMap(
      id: newPostDocumentRef.documentID,
    ));
  }

  void followUser({String currentUserId, String userId}) {
    // Add user to current user's following collection
    followingRef
        .document(currentUserId)
        .collection('userFollowing')
        .document(userId)
        .setData({});
    // Add current user to user's followers collection
    _followersCollectionReference
        .document(userId)
        .collection('userFollowers')
        .document(currentUserId)
        .setData({});
  }

  void unfollowUser({String currentUserId, String userId}) {
    // Remove user from current user's following collection
    followingRef
        .document(currentUserId)
        .collection('userFollowing')
        .document(userId)
        .get()
        .then((doc) {
      if (doc.exists) {
        doc.reference.delete();
      }
    });
    // Remove current user from user's followers collection
    _followersCollectionReference
        .document(userId)
        .collection('userFollowers')
        .document(currentUserId)
        .get()
        .then((doc) {
      if (doc.exists) {
        doc.reference.delete();
      }
    });
  }

  Future<bool> isFollowingUser({String currentUserId, String userId}) async {
    DocumentSnapshot followingDoc = await _followersCollectionReference
        .document(userId)
        .collection('userFollowers')
        .document(currentUserId)
        .get();
    return followingDoc.exists;
  }

  Stream<QuerySnapshot> followingNumberStream(String userId) {
    Stream<QuerySnapshot> followingSnapshot =
        followingRef.document(userId).collection('userFollowing').snapshots();
    return followingSnapshot;
  }

  Stream<QuerySnapshot> followersNumberStream(String userId) {
    Stream<QuerySnapshot> followersSnapshot = _followersCollectionReference
        .document(userId)
        .collection('userFollowers')
        .snapshots();
    return followersSnapshot;
  }

  Future<List<Post>> getFeedPosts(String userId) async {
    QuerySnapshot feedSnapshot = await feedsRef
        .document(userId)
        .collection('userFeed')
        .orderBy('timestamp', descending: true)
        .getDocuments();
    List<Post> posts =
        feedSnapshot.documents.map((doc) => Post.fromMap(doc.data)).toList();
    return posts;
  }

  Stream<QuerySnapshot> getFeedPostsStream(String userId) {
    Stream<QuerySnapshot> feedSnapshot = feedsRef
        .document(userId)
        .collection('userFeed')
        .orderBy('timestamp', descending: true)
        .snapshots();
    return feedSnapshot;
  }

  Future<User> getUserWithId(String userId) async {
    DocumentSnapshot userDocSnapshot =
        await _usersCollectionReference.document(userId).get();
    if (userDocSnapshot.exists) {
      return User.fromMap(userDocSnapshot.data);
    }
    return User();
  }

  Stream<DocumentSnapshot> getUserWithIdStream(String userId) {
    Stream<DocumentSnapshot> userDocSnapshot =
        _usersCollectionReference.document(userId).snapshots();
    return userDocSnapshot;
  }

  Stream<QuerySnapshot> likesCountStream({String currentUserId, Post post}) {
    Stream<QuerySnapshot> likesCountStream =
        likesRef.document(post.authorId).collection('postLikes').snapshots();

    return likesCountStream;
  }

  Future<void> likePost({String currentUserId, Post post}) async {
    DocumentReference postRef = _postsCollectionReference
        .document(post.authorId)
        .collection('userPosts')
        .document(post.id);
    postRef.get().then((doc) async {
      int likeCount = doc.data['likeCount'];
      postRef.updateData({'likeCount': likeCount + 1});
      await likesRef
          .document(post.id)
          .collection('postLikes')
          .document(post.id + "_" + currentUserId + "_" + post.authorId)
          .setData(
        {
          "timestamp": Timestamp.now(),
          "LikeOwnerId": currentUserId,
          "PostOwnerId": post.authorId,
          "postId": post.id,
        },
      );
      addActivityItem(currentUserId: currentUserId, post: post, comment: null);
    });
  }

  Future<void> unlikePost({String currentUserId, Post post}) async {
    DocumentReference postRef = _postsCollectionReference
        .document(post.authorId)
        .collection('userPosts')
        .document(post.id);
    postRef.get().then((doc) async {
      int likeCount = doc.data['likeCount'];
      await postRef.updateData({'likeCount': likeCount - 1});
      likesRef
          .document(post.id)
          .collection('postLikes')
          .document(post.id + "_" + currentUserId + "_" + post.authorId)
          .get()
          .then((doc) {
        if (doc.exists) {
          doc.reference.delete();
        }
      });
    });
  }

  Future<bool> didLikePost({String currentUserId, Post post}) async {
    DocumentSnapshot userDoc = await likesRef
        .document(post.id)
        .collection('postLikes')
        .document(post.id + "_" + currentUserId + "_" + post.authorId)
        .get();
    return userDoc.exists;
  }

  Future<void> commentOnPost(
      {String currentUserId, Post post, String comment}) async {
    await commentsRef.document(post.id).collection('postComments').add({
      'content': comment,
      'authorId': currentUserId,
      'timestamp': Timestamp.fromDate(DateTime.now()),
    });
    addActivityItem(
      currentUserId: currentUserId,
      post: post,
      comment: comment,
    );
  }

  Stream<QuerySnapshot> getCommentsOfPostStream(Post post) {
    Stream<QuerySnapshot> commentsOfPost = commentsRef
        .document(post.id)
        .collection('postComments')
        .orderBy('timestamp', descending: true)
        .snapshots();

    return commentsOfPost;
  }

  Future<void> addActivityItem({
    String currentUserId,
    Post post,
    String comment,
  }) async {
    if (currentUserId != post.authorId) {
      await activitiesRef
          .document(post.authorId)
          .collection('userActivities')
          .add({
        'fromUserId': currentUserId,
        'postId': post.id,
        'postImageUrl': post.imageUrl,
        'comment': comment,
        'timestamp': Timestamp.fromDate(DateTime.now()),
      });
    }
  }

  Future<List<Activity>> getActivities(String userId) async {
    QuerySnapshot userActivitiesSnapshot = await activitiesRef
        .document(userId)
        .collection('userActivities')
        .orderBy('timestamp', descending: true)
        .getDocuments();
    List<Activity> activities = <Activity>[];
    userActivitiesSnapshot.documents.forEach((DocumentSnapshot activity) {
      activities.add(
        Activity.fromMap(activity.data),
      );
    });
    return activities;
  }

  Future<Post> getUserPost(String userId, String postId) async {
    DocumentSnapshot postDocSnapshot = await _postsCollectionReference
        .document(userId)
        .collection('userPosts')
        .document(postId)
        .get();
    return Post.fromMap(postDocSnapshot.data);
  }

  Stream<DocumentSnapshot> getUserPostStream({
    @required String userId,
    @required String postId,
  }) {
    Stream<DocumentSnapshot> postStreamDocSnapshot = _postsCollectionReference
        .document(userId)
        .collection('userPosts')
        .document(postId)
        .snapshots();
    return postStreamDocSnapshot;
  }

  Stream<QuerySnapshot> getUserPostsStream({
    @required String userId,
  }) {
    Stream<QuerySnapshot> postStreamQuerySnapshot = _postsCollectionReference
        .document(userId)
        .collection('userPosts')
        .orderBy('timestamp', descending: true)
        .snapshots();
    return postStreamQuerySnapshot;
  }
}
