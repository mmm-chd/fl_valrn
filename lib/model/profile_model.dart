class ProfileModel {
  final int id;
  final String name;
  final String email;
  final String? phone;
  final String? instagram;
  final String? facebook;
  final String? description;
  final String? emailVerifiedAt;
  final String createdAt;
  final String updatedAt;
  final String role;
  final int isActive;
  final String? otpCode;
  final String? otpExpiresAt;

  ProfileModel({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    this.instagram,
    this.facebook,
    this.description,
    this.emailVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.role,
    required this.isActive,
    this.otpCode,
    this.otpExpiresAt,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'],
      instagram: json['instagram'],
      facebook: json['facebook'],
      description: json['description'],
      emailVerifiedAt: json['email_verified_at'],
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      role: json['role'] ?? 'user',
      isActive: json['is_active'] ?? 1,
      otpCode: json['otp_code'],
      otpExpiresAt: json['otp_expires_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'instagram': instagram,
      'facebook': facebook,
      'description': description,
      'email_verified_at': emailVerifiedAt,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'role': role,
      'is_active': isActive,
      'otp_code': otpCode,
      'otp_expires_at': otpExpiresAt,
    };
  }

  // Getter untuk compatibility dengan kode lama
  String get insta => instagram ?? '';
  String get about => description ?? '';
  
  // Helper getters
  bool get isEmailVerified => emailVerifiedAt != null;
  bool get isAdmin => role == 'admin';
  bool get hasPhone => phone != null && phone!.isNotEmpty;
  bool get hasInstagram => instagram != null && instagram!.isNotEmpty;
  bool get hasFacebook => facebook != null && facebook!.isNotEmpty;
  bool get hasDescription => description != null && description!.isNotEmpty;

  // Copy with method untuk update data
  ProfileModel copyWith({
    int? id,
    String? name,
    String? email,
    String? phone,
    String? instagram,
    String? facebook,
    String? description,
    String? emailVerifiedAt,
    String? createdAt,
    String? updatedAt,
    String? role,
    int? isActive,
    String? otpCode,
    String? otpExpiresAt,
  }) {
    return ProfileModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      instagram: instagram ?? this.instagram,
      facebook: facebook ?? this.facebook,
      description: description ?? this.description,
      emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      role: role ?? this.role,
      isActive: isActive ?? this.isActive,
      otpCode: otpCode ?? this.otpCode,
      otpExpiresAt: otpExpiresAt ?? this.otpExpiresAt,
    );
  }
}

// Response wrapper untuk API response
class ProfileResponse {
  final String message;
  final ProfileModel user;

  ProfileResponse({
    required this.message,
    required this.user,
  });

  factory ProfileResponse.fromJson(Map<String, dynamic> json) {
    return ProfileResponse(
      message: json['message'] ?? '',
      user: ProfileModel.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'user': user.toJson(),
    };
  }
}