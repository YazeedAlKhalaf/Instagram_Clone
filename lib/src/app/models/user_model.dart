import 'dart:convert';

class User {
  final String id;
  final String name;
  final String profileImageUrl;
  final String email;
  final String bio;

  User({
    this.id,
    this.name,
    this.profileImageUrl,
    this.email,
    this.bio,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'profileImageUrl': profileImageUrl,
      'email': email,
      'bio': bio ?? '',
    };
  }

  static User fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return User(
      id: map['id'],
      name: map['name'],
      profileImageUrl: map['profileImageUrl'],
      email: map['email'],
      bio: map['bio'],
    );
  }

  String toJson() => json.encode(toMap());

  static User fromJson(String source) => fromMap(json.decode(source));
}
