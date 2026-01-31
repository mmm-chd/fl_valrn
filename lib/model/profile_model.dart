class ProfileModel {
  final int id;
  final String name;
  final String email;
  final String insta;
  final String facebook;
  final String phone;
  final String about;

  ProfileModel({required this.id, required this.name, required this.email, required this.insta, required this.facebook, required this.phone, required this.about});

  factory ProfileModel.fromJson(Map<String, dynamic> json){
    return ProfileModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '', 
      insta: json['instagram'] ?? '', 
      facebook: json['facebook'] ?? '', 
      phone: json['phone'] ?? '', 
      about: json['description'] ?? '');
  }

   Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
    };
  }
}

