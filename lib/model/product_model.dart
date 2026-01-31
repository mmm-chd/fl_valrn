// lib/model/product_model.dart

class ProductItem {
  final int id;
  final int userId;
  final int? categoryId;
  final String title;
  final String price;
  final String? location;
  final String desc;
  final String? imageUrl; 
  final String status;
  final String createdAt;
  final String updatedAt;
  final User? user;

  ProductItem({
    required this.id,
    required this.userId,
    this.categoryId,
    required this.title,
    required this.price,
    this.location,
    required this.desc,
    this.imageUrl,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.user,
  });

  factory ProductItem.fromJson(Map<String, dynamic> json) {
    return ProductItem(
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? 0,
      categoryId: json['category_id'], // TAMBAHKAN PARSING INI
      title: json['name'] ?? '',
      price: json['price']?.toString() ?? '0',
      location: json['location'],
      desc: json['description'] ?? '',
      imageUrl: json['image'],
      status: json['status'] ?? 'active',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      user: json['user'] != null ? User.fromJson(json['user']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'category_id': categoryId, // TAMBAHKAN DI SINI
      'name': title, // Convert back to 'name' for API
      'price': price,
      'location': location,
      'description': desc, // Convert back to 'description' for API
      'image': imageUrl, // Convert back to 'image' for API
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'user': user?.toJson(),
    };
  }

  // Getter untuk subtitle (bisa diambil dari description atau kombinasi lain)
  String get subtitle =>
      desc.length > 50 ? '${desc.substring(0, 50)}...' : desc;

  // Helper method untuk get full image URL
  String getImageUrl(String baseUrl) {
    if (imageUrl == null || imageUrl!.isEmpty) {
      return 'https://img.freepik.com/free-vector/illustration-gallery-icon_53876-27002.jpg';
    }

    // Jika sudah full URL
    if (imageUrl!.startsWith('http')) {
      return imageUrl!;
    }

    // Gabungkan dengan base URL
    return '$baseUrl/storage/products/$imageUrl';
  }
}

class User {
  final int id;
  final String name;
  final String email;
  final String? number; // untuk WhatsApp

  User({
    required this.id,
    required this.name,
    required this.email,
    this.number,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      number:
          json['number'] ??
          json['phone'], // fallback ke 'phone' jika 'number' tidak ada
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'email': email, 'number': number};
  }
}
