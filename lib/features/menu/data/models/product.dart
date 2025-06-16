import 'package:freezed_annotation/freezed_annotation.dart';

part 'product.freezed.dart';
part 'product.g.dart';

@freezed
class Product with _$Product {
  const factory Product({
    required String id,
    required String name,
    required String description,
    required double price,
    required String imageUrl,
  }) = _Product;

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);
}
