class ProductItem {
  final int id;
  final String title;
  final String subtitle;
  final double price;
  final String imageUrl;
  final String desc;
  final User? user;
  final String location;


  ProductItem(  {required this.id, required this.title, required this.subtitle, required this.price,  required this.imageUrl, required this.desc, this.user, required this.location,});
  
  factory ProductItem.fromJson(Map<String, dynamic> json){
    print(json);
    return ProductItem(
      id: json['id'],
      title: json['name'], 
      subtitle: json['description'], 
      price: double.parse(json['price'].toString()), 
    
      imageUrl: json['image'] ??
          'https://img.freepik.com/free-vector/illustration-gallery-icon_53876-27002.jpg',
      desc: json['description'],
      location: json['location'] ?? 'Tidak diketahui',
      user: User.fromJson(json['user']),
      
    );
    
  }

}

class User {
  final int id;
  final String name;
  final String email;

  User({
    required this.id,
    required this.name,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
    );
  }
}