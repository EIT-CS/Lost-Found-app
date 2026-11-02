class LostFoundItem {
  const LostFoundItem({
    required this.title,
    required this.description,
    required this.location,
    required this.category,
    required this.isLost,
    this.createdAt,
    this.imagePath,
  });

  final String title;
  final String description;
  final String location;
  final String category;
  final bool isLost;
  final DateTime? createdAt;
  final String? imagePath;
}
