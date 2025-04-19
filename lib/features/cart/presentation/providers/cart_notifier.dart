import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/cart_item.dart';
import '../../data/models/cart_state.dart';
import '../../../menu/data/models/menu_item.dart'; // To add items easily

// StateNotifier for Cart logic
class CartNotifier extends StateNotifier<CartState> {
  CartNotifier() : super(const CartState()); // Initial empty state

  // Add item to cart (handles existing items by increasing quantity)
  void addItem(MenuItem menuItem) {
    final currentState = state;
    final items = List<CartItem>.from(currentState.items); // Create mutable copy
    final existingItemIndex = items.indexWhere(
        (item) => item.menuItemId == menuItem.id);

    if (existingItemIndex != -1) {
      // Item already exists, increase quantity
      final existingItem = items[existingItemIndex];
      items[existingItemIndex] = existingItem.copyWith(
        quantity: existingItem.quantity + 1,
      );
    } else {
      // Item doesn't exist, add new CartItem
      items.add(CartItem(
        menuItemId: menuItem.id,
        name: menuItem.name,
        price: menuItem.price,
        quantity: 1,
      ));
    }
    state = currentState.copyWith(items: items); // Update state
  }

  // Remove item from cart (or decrease quantity, here we remove entirely)
  void removeItem(String menuItemId) {
    final currentState = state;
    final items = List<CartItem>.from(currentState.items);
    items.removeWhere((item) => item.menuItemId == menuItemId);
    state = currentState.copyWith(items: items); // Update state
  }

  // Clear the entire cart
  void clearCart() {
    state = const CartState(); // Reset to initial empty state
  }
}

// StateNotifierProvider for the CartNotifier
final cartProvider = StateNotifierProvider<CartNotifier, CartState>((ref) {
  return CartNotifier();
});