import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  final String id;
  final String content;
  final String authorId;
  final Timestamp timestamp;

  Comment({
    this.id,
    this.content,
    this.authorId,
    this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'content': content,
      'authorId': authorId,
      'timestamp': timestamp,
    };
  }

  static Comment fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Comment(
      id: map['id'],
      content: map['content'],
      authorId: map['authorId'],
      timestamp: map['timestamp'],
    );
  }

  String toJson() => json.encode(toMap());

  static Comment fromJson(String source) => fromMap(json.decode(source));
}
