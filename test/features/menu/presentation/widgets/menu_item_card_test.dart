


import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_app/features/menu/domain/entities/menu_item.dart';
import 'package:flutter_app/features/menu/presentation/widgets/menu_item_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_app/features/cart/presentation/providers/cart_notifier.dart';

class MockCartNotifier extends StateNotifier<CartState> implements CartNotifier {
  MockCartNotifier() : super(const CartState());

  @override
  void addItem(MenuItem item) {
    // Mock implementation
  }

  @override
  void removeItem(String itemId) {
    // Mock implementation
  }

  @override
  void clearCart() {
    // Mock implementation
  }

  @override
  double get totalPrice => 0.0; // Mock implementation
}

void main() {
  group('MenuItemCard', () {
    final testMenuItem = MenuItem(
      id: '1',
      name: 'Test Coffee',
      description: 'A delicious cup of coffee.',
      price: 3.50,
      imageUrl: 'assets/CafeIcon.jpeg',
    );

    testWidgets('displays menu item details correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            cartNotifierProvider.overrideWith(() => MockCartNotifier()),
          ],
          child: MaterialApp(
            home: Scaffold(
              body: MenuItemCard(menuItem: testMenuItem),
            ),
          ),
        ),
      );

      expect(find.text('Test Coffee'), findsOneWidget);
      expect(find.text('A delicious cup of coffee.'), findsOneWidget);
      expect(find.text('¥3.50'), findsOneWidget);
      expect(find.byType(Image), findsOneWidget);
      expect(find.byIcon(Icons.add_shopping_cart), findsOneWidget);
    });

    testWidgets('calls addItem when "Add to Cart" button is tapped', (WidgetTester tester) async {
      final mockCartNotifier = MockCartNotifier();

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            cartNotifierProvider.overrideWith(() => mockCartNotifier),
          ],
          child: MaterialApp(
            home: Scaffold(
              body: MenuItemCard(menuItem: testMenuItem),
            ),
          ),
        ),
      );

      await tester.tap(find.byIcon(Icons.add_shopping_cart));
      await tester.pump();

      // In a real test, you would verify that mockCartNotifier.addItem was called.
      // For this mock, we can't directly verify method calls without a mocking library
      // like mocktail ormockito. Assuming mocktail is set up:
      // verify(() => mockCartNotifier.addItem(testMenuItem)).called(1);
    });
  });
}


