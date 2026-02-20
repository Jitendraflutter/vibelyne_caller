class PointPackModel {
  final String id;
  final String title;
  final String description;
  final num? price;
  final num? originalPrice;
  final int points;
  final String category;
  final String? discountPercent;
  final String? badgeText;
  final bool isOneTime;
  final bool isPopular;
  final int displayOrder;

  PointPackModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    this.originalPrice,
    required this.points,
    required this.category,
    this.discountPercent,
    this.badgeText,
    required this.isOneTime,
    required this.isPopular,
    required this.displayOrder,
  });

  // Factory constructor to create a model from Firestore document data
  factory PointPackModel.fromFirestore(
    Map<String, dynamic> json,
    String docId,
  ) {
    return PointPackModel(
      id: docId,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      price: json['price'],
      originalPrice: json['original_price'],
      points: json['points']?.toInt() ?? 0,
      category: json['category'] ?? 'starter',
      discountPercent: json['discount_percent'],
      badgeText: json['badge_text'],
      isOneTime: json['is_one_time'] ?? false,
      isPopular: json['is_popular'] ?? false,
      displayOrder: json['display_order']?.toInt() ?? 0,
    );
  }
}
