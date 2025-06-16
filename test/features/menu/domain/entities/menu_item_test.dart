


import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_app/features/menu/data/models/menu_item.dart';

void main() {
  group('MenuItem Entity', () {
    test('should create a MenuItem entity with correct properties', () {
      const menuItem = MenuItem(
        id: '1',
        name: 'Espresso',
        description: 'Strong coffee',
        price: 2.5,
        imageUrl: 'assets/espresso.jpg',
      );

      expect(menuItem.id, '1');
      expect(menuItem.name, 'Espresso');
      expect(menuItem.description, 'Strong coffee');
      expect(menuItem.price, 2.5);
      expect(menuItem.imageUrl, 'assets/espresso.jpg');
    });

    test('should support value equality', () {
      const menuItem1 = MenuItem(
        id: '1',
        name: 'Espresso',
        description: 'Strong coffee',
        price: 2.5,
        imageUrl: 'assets/espresso.jpg',
      );
      const menuItem2 = MenuItem(
        id: '1',
        name: 'Espresso',
        description: 'Strong coffee',
        price: 2.5,
        imageUrl: 'assets/espresso.jpg',
      );
      const menuItem3 = MenuItem(
        id: '2',
        name: 'Latte',
        description: 'Milky coffee',
        price: 3.5,
        imageUrl: 'assets/latte.jpg',
      );

      expect(menuItem1, equals(menuItem2));
      expect(menuItem1, isNot(equals(menuItem3)));
    });
  });
}


