import 'package:fl_valrn/model/auth/profile_model.dart';

class UserSession {
  final int id;
  final String name;
  final String email;
  final String? description;
  final String? phone;
  final String? instagram;
  final String? facebook;

  UserSession({
    this.id = 0,
    this.name = '',
    this.email = '',
    this.description,
    this.phone,
    this.instagram,
    this.facebook,
  });

  bool get isLoggedIn => id > 0 && name.isNotEmpty;

  factory UserSession.fromProfileModel(User user) {
    return UserSession(
      id: user.id,
      name: user.name,
      email: user.email,
      description: user.description,
      phone: user.phone,
      instagram: user.instagram,
      facebook: user.facebook,
    );
  }

  factory UserSession.empty() {
    return UserSession();
  }
}
