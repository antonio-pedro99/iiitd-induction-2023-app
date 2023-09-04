import 'package:firebase_auth/firebase_auth.dart';

class UserProfile {
  final String? rollNumber;
  final String fullName;
  final String? profileImage;
  final String? username;
  final int? points;

  UserProfile({
    required this.fullName,
    this.profileImage,
    this.rollNumber,
    this.username,
    this.points,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      fullName: json["fullName"],
      rollNumber: json["rollNumber"],
      profileImage: json["imageUrl"],
      username: json["username"],
      points: json["points"],
    );
  }

  factory UserProfile.fromAuthUser(User user) {
    return UserProfile(
      fullName: user.displayName!,
      profileImage: user.photoURL ?? "https://firebasestorage.googleapis.com/v0/b/alive-dsm.appspot.com/o/profile_pictures%2Fprofile.png?alt=media&token=3beca1bf-563f-4d7e-96b2-fcd45115fac1",
      username: user.email!.split("@").first,
      points: 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "rollNumber": rollNumber,
      "fullName": fullName,
      "imageUrl": profileImage,
      "points": points,
      "username": username,
    };
  }
}
