import 'package:ahgzly_app/core/api/end_points.dart';
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
    // 1. استخراج قيمة الصورة
    String imageUrl = "${EndPoints.storageUrl}/$json['logo']";

    
    return RestaurantModel(
      id: json['id'],
      name: json['name'] ?? 'Unknown Restaurant',
      // description: json['description'] ?? '',
      address: json['address'] ?? '',
      phone: json['phone'] ?? '',
      image: imageUrl,
      // التعامل الآمن مع الأرقام (قد تأتي int أو double أو String)
      // rating: (json['rating'] is int)
      //     ? (json['rating'] as int).toDouble()
      //     : (json['rating'] as double?) ?? 0.0,
    );
  }
}
