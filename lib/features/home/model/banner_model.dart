class BannerModel {
  final String id;
  final String title;
  final String subtitle;
  final String imageUrl;
  final String targetScreen;
  final bool isActive;

  BannerModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.targetScreen,
    required this.isActive,
  });

  factory BannerModel.fromFirestore(Map<String, dynamic> data, String id) {
    return BannerModel(
      id: id,
      title: data['title'] ?? '',
      subtitle: data['subtitle'] ?? '',
      imageUrl: data['image_url'] ?? '',
      targetScreen: data['target_screen'] ?? '',
      isActive: data['is_active'] ?? false,
    );
  }
}
