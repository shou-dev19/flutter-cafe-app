import 'package:freezed_annotation/freezed_annotation.dart';
// Import MenuItem if needed directly

part 'cart_item.freezed.dart';
// No g.dart needed if not directly serializing CartItem with quantity

@freezed
class CartItem with _$CartItem {
  const factory CartItem({
    required String menuItemId, // Reference to MenuItem
    required String name,
    required double price,
    required int quantity,
  }) = _CartItem;

  // If you need to serialize/deserialize CartItem (e.g., for saving cart state)
  // add factory CartItem.fromJson(Map<String, dynamic> json) => _$CartItemFromJson(json);
  // and run build_runner again
}