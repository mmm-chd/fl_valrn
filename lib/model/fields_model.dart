class FieldsItem {
  final String title;
  final String subtitle;
  final String imageUrl;
  final List<PlantItem> plants;

  FieldsItem({
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.plants,
  });

  // factory FieldsItem.fromJson(Map<String, dynamic> json){
  // }
}

class PlantItem {
  final String title;
  final String latinTitle;
  final String status;
  final int month;
  final DateTime createdAt;
  final String imageUrl;

  PlantItem({
    required this.title,
    required this.latinTitle,
    required this.status,
    required this.month,
    required this.createdAt,
    required this.imageUrl,
  });

  
}