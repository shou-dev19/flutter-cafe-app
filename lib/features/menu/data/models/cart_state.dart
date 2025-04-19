import 'package:freezed_annotation/freezed_annotation.dart';
import 'cart_item.dart';

part 'cart_state.freezed.dart';

@freezed
class CartState with _$CartState {
  const CartState._(); // Private constructor for getters

  const factory CartState({
    @Default([]) List<CartItem> items,
  }) = _CartState;

  // Calculate total price based on items
  double get totalPrice => items.fold(
      0.0, (sum, item) => sum + (item.price * item.quantity));
}