import 'dart:convert';

ProfileModel profileModelFromJson(String str) =>
    ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  String message;
  User user;

  ProfileModel({required this.message, required this.user});

  factory ProfileModel.fromJson(Map<String, dynamic> json) =>
      ProfileModel(message: json["message"], user: User.fromJson(json["user"]));

  Map<String, dynamic> toJson() => {"message": message, "user": user.toJson()};
}

class User {
  int id;
  String name;
  String email;
  String phone;
  String instagram;
  String facebook;
  dynamic description;
  dynamic emailVerifiedAt;
  DateTime createdAt;
  DateTime updatedAt;
  String role;
  int isActive;
  dynamic otpCode;
  dynamic otpExpiresAt;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.instagram,
    required this.facebook,
    required this.description,
    required this.emailVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.role,
    required this.isActive,
    required this.otpCode,
    required this.otpExpiresAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: safeString(json["name"]),
    email: safeString(json["email"]),
    phone: safeString(json["phone"]),
    instagram: safeString(json["instagram"]),
    facebook: safeString(json["facebook"]),
    description: safeString(json["description"]),
    emailVerifiedAt: safeString(json["email_verified_at"]),
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    role: json["role"],
    isActive: json["is_active"],
    otpCode: json["otp_code"],
    otpExpiresAt: json["otp_expires_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "phone": phone,
    "instagram": instagram,
    "facebook": facebook,
    "description": description,
    "email_verified_at": emailVerifiedAt,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "role": role,
    "is_active": isActive,
    "otp_code": otpCode,
    "otp_expires_at": otpExpiresAt,
  };
}

String safeString(dynamic value, {String fallback = '-'}) {
  if (value == null) return fallback;
  if (value is String && value.trim().isEmpty) return fallback;
  return value.toString();
}
