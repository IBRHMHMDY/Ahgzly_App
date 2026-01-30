import 'package:equatable/equatable.dart';

class RestaurantEntity extends Equatable {
  final int id;
  final String name;
  // final String description;
  final String address;
  final String phone;
  final String image; // رابط الصورة
  // final double rating;

  const RestaurantEntity({
    required this.id,
    required this.name,
    // required this.description,
    required this.address,
    required this.phone,
    required this.image,
    // required this.rating,
  });

  @override
  List<Object?> get props => [id, name, address, phone, image];
}
