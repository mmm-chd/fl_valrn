class Journal {
  final int id;
  final String title;
  final String description;
  final String? imageUrl;

  Journal({
    required this.id,
    required this.title,
    required this.description,
    this.imageUrl,
  });

  factory Journal.fromJson(Map<String, dynamic> json) {
    return Journal(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      imageUrl: json['image_url'],
    );
  }
}