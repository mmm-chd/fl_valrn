class Journal {
  final int id;
  final String title;
  final String? description;
  final String? imageUrl;

  Journal({
    required this.id,
    required this.title,
    this.description,
    this.imageUrl,
  });

  factory Journal.fromJson(Map<String, dynamic> json) {
    return Journal(
      id: json['id'],
      title: json['title'] ?? '-',
      description: json['description'],
      imageUrl: json['image_url']??
          'https://img.freepik.com/free-vector/illustration-gallery-icon_53876-27002.jpg', // default jika null

    );
  }
}