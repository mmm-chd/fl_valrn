class ArtikelItem {
  final String title;
  final String subtitle;
  final String imageUrl;
  final bool isImageLeft;
  final bool isDescription;

  ArtikelItem( {
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    this.isImageLeft = false,
    this.isDescription=false,
  });
}