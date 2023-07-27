import 'package:firebase_auth/firebase_auth.dart';

class UserProfile {
  final String username;
  final String fullName;
  final String? pronouns;
  final String? profileImage;
  final int? points;

  UserProfile({
    required this.fullName,
    this.profileImage,
    this.pronouns,
    required this.username,
    this.points,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      fullName: json["fullName"],
      username: json["username"],
      profileImage: json["imageUrl"],
      pronouns: json["pronouns"],
      points: 0,
    );
  }

  factory UserProfile.fromAuthUser(User user) {
    return UserProfile(
      fullName: user.displayName!,
      username: user.email!.split('@').first,
      profileImage: user.photoURL,
      pronouns: null,
      points: 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "username": username,
      "fullName": fullName,
      "pronouns": pronouns,
      "imageUrl": profileImage,
      "points": points,
    };
  }
}
