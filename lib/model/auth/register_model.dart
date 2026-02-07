import 'dart:convert';

RegisterModel registerModelFromJson(String str) =>
    RegisterModel.fromJson(json.decode(str));

String registerModelToJson(RegisterModel data) => json.encode(data.toJson());

class RegisterModel {
  String message;
  User user;
  String token;

  RegisterModel({
    required this.message,
    required this.user,
    required this.token,
  });

  factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
    message: json["message"],
    user: User.fromJson(json["user"]),
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "user": user.toJson(),
    "token": token,
  };
}

class User {
  String name;
  String email;
  String phone;
  String instagram;
  String facebook;
  DateTime updatedAt;
  DateTime createdAt;
  int id;

  User({
    required this.name,
    required this.email,
    required this.phone,
    required this.instagram,
    required this.facebook,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    name: safeString(json["name"]),
    email: safeString(json["email"]),
    phone: safeString(json["phone"]),
    instagram: safeString(json["instagram"]),
    facebook: safeString(json["facebook"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    createdAt: DateTime.parse(json["created_at"]),
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "phone": phone,
    "instagram": instagram,
    "facebook": facebook,
    "updated_at": updatedAt.toIso8601String(),
    "created_at": createdAt.toIso8601String(),
    "id": id,
  };
}

String safeString(dynamic value, {String fallback = '-'}) {
  if (value == null) return fallback;
  if (value is String && value.trim().isEmpty) return fallback;
  return value.toString();
}
