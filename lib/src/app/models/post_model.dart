import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String id;
  final String imageUrl;
  final String caption;
  final int likeCount;
  final String authorId;
  final Timestamp timestamp;

  Post({
    this.id,
    this.imageUrl,
    this.caption,
    this.likeCount,
    this.authorId,
    this.timestamp,
  });

  Map<String, dynamic> toMap({String id}) {
    return {
      'id': id,
      'imageUrl': imageUrl,
      'caption': caption,
      'likeCount': likeCount,
      'authorId': authorId,
      'timestamp': timestamp,
    };
  }

  static Post fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Post(
      id: map['id'],
      imageUrl: map['imageUrl'],
      caption: map['caption'],
      likeCount: map['likeCount'],
      authorId: map['authorId'],
      timestamp: map['timestamp'],
    );
  }

  String toJson() => json.encode(toMap());

  static Post fromJson(String source) => fromMap(json.decode(source));
}
