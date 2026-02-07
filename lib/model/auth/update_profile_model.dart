import 'dart:convert';

UpdateProfileModel updateProfileModelFromJson(String str) =>
    UpdateProfileModel.fromJson(json.decode(str));

String updateProfileModelToJson(UpdateProfileModel data) =>
    json.encode(data.toJson());

class UpdateProfileModel {
  String message;
  User updateUser;

  UpdateProfileModel({required this.message, required this.updateUser});

  factory UpdateProfileModel.fromJson(Map<String, dynamic> json) =>
      UpdateProfileModel(
        message: json["message"],
        updateUser: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
    "message": message,
    "user": updateUser.toJson(),
  };
}

class User {
  int id;
  String name;
  String email;
  String phone;
  dynamic instagram;
  dynamic facebook;
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
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    instagram: json["instagram"],
    facebook: json["facebook"],
    description: json["description"],
    emailVerifiedAt: json["email_verified_at"],
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
