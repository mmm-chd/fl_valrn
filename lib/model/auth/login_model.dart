import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
    String message;
    User user;
    String token;

    LoginModel({
        required this.message,
        required this.user,
        required this.token,
    });

    factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
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
    int id;
    String name;
    String email;
    String phone;
    String instagram;
    String facebook;
    String description;
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
