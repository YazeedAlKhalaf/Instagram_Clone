import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Activity {
  final String id;
  final String fromUserId;
  final String postId;
  final String postImageUrl;
  final String comment;
  final Timestamp timestamp;

  Activity({
    this.id,
    this.fromUserId,
    this.postId,
    this.postImageUrl,
    this.comment,
    this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fromUserId': fromUserId,
      'postId': postId,
      'postImageUrl': postImageUrl,
      'comment': comment,
      'timestamp': timestamp,
    };
  }

  static Activity fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Activity(
      id: map['id'],
      fromUserId: map['fromUserId'],
      postId: map['postId'],
      postImageUrl: map['postImageUrl'],
      comment: map['comment'],
      timestamp: map['timestamp'],
    );
  }

  String toJson() => json.encode(toMap());

  static Activity fromJson(String source) => fromMap(json.decode(source));
}
