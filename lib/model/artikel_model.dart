class ArtikelModel {
  final int id;
  final String title;
  final String slug;
  final String content;
  final String? thumbnail;
  final String status;
  final int createdBy;
  final String? publishedAt;
  final String createdAt;
  final String updatedAt;

  ArtikelModel({
    required this.id,
    required this.title,
    required this.slug,
    required this.content,
    this.thumbnail,
    required this.status,
    required this.createdBy,
    this.publishedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ArtikelModel.fromJson(Map<String, dynamic> json) {
    return ArtikelModel(
      id: json['id'],
      title: json['title'],
      slug: json['slug'],
      content: json['content'],
      thumbnail: json['thumbnail'],
      status: json['status'],
      createdBy: json['created_by'],
      publishedAt: json['published_at'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}