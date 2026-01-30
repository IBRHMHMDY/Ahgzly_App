import 'package:ahgzly_app/features/restaurants/domain/entities/restaurant_entity.dart';

class RestaurantModel extends RestaurantEntity {
  const RestaurantModel({
    required super.id,
    required super.name,
    // required super.description,
    required super.address,
    required super.phone,
    required super.image,
    // required super.rating,
  });

  factory RestaurantModel.fromJson(Map<String, dynamic> json) {
    return RestaurantModel(
      id: json['id'],
      name: json['name'] ?? 'Unknown Restaurant',
      // description: json['description'] ?? '',
      address: json['address'] ?? '',
      phone: json['phone'] ?? '',
      image:
          json['image'] ??
          'https://placehold.co/600x400', // صورة افتراضية في حال عدم وجود صورة
      // التعامل الآمن مع الأرقام (قد تأتي int أو double أو String)
      // rating: (json['rating'] is int)
      //     ? (json['rating'] as int).toDouble()
      //     : (json['rating'] as double?) ?? 0.0,
    );
  }
}
