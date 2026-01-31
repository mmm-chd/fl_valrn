class ProductItem {
  final int id;
  final String title;
  final String subtitle;
  final String price;
  final double rate;
  final String imageUrl;
  final String desc;


  ProductItem( {required this.id, required this.title, required this.subtitle, required this.price, required this.rate, required this.imageUrl, required this.desc,});
  
  factory ProductItem.fromJson(Map<String, dynamic> json){
    return ProductItem(
      id: json['id'],
      title: json['name'], 
      subtitle: json['description'], 
      price: json['price'], 
      rate: json['price'], 
      imageUrl: json['image'] ??
          'https://via.placeholder.com/300',
      desc: json['description']);
  }

}