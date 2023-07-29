import 'package:firebase_auth/firebase_auth.dart';

class UserProfile {
  final String username;
  final String fullName;
  final String? phone;
  final String? profileImage;
  final String? email;
  final int? points;

  UserProfile({
    required this.fullName,
    this.profileImage,
    this.phone,
    required this.username,
    this.email,
    this.points,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      fullName: json["fullName"],
      username: json["username"],
      profileImage: json["imageUrl"],
      phone: json["phone"],
      points: json["points"],
    );
  }

  factory UserProfile.fromAuthUser(User user) {
    return UserProfile(
      fullName: user.displayName!,
      username: user.email!.split('@').first,
      profileImage: user.photoURL,
      phone: user.phoneNumber,
      email: user.email,
      points: 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "username": username,
      "fullName": fullName,
      "phone": phone,
      "imageUrl": profileImage,
      "points": points,
      "email": email,
    };
  }
}
