
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_app/features/menu/data/models/menu_item.dart';

void main() {
  group('MenuItem', () {
    test('MenuItem can be created with valid data', () {
      final menuItem = MenuItem(
        id: '1',
        name: 'Test Item',
        description: 'This is a test item',
        price: 10.0,
        imageUrl: 'http://example.com/image.jpg',
      );

      expect(menuItem.id, '1');
      expect(menuItem.name, 'Test Item');
      expect(menuItem.description, 'This is a test item');
      expect(menuItem.price, 10.0);
      expect(menuItem.imageUrl, 'http://example.com/image.jpg');
    });

    test('MenuItem can be converted to JSON', () {
      final menuItem = MenuItem(
        id: '1',
        name: 'Test Item',
        description: 'This is a test item',
        price: 10.0,
        imageUrl: 'http://example.com/image.jpg',
      );

      final json = menuItem.toJson();

      expect(json['id'], '1');
      expect(json['name'], 'Test Item');
      expect(json['description'], 'This is a test item');
      expect(json['price'], 10.0);
      expect(json['imageUrl'], 'http://example.com/image.jpg');
    });

    test('MenuItem can be created from JSON', () {
      final json = {
        'id': '1',
        'name': 'Test Item',
        'description': 'This is a test item',
        'price': 10.0,
        'imageUrl': 'http://example.com/image.jpg',
      };

      final menuItem = MenuItem.fromJson(json);

      expect(menuItem.id, '1');
      expect(menuItem.name, 'Test Item');
      expect(menuItem.description, 'This is a test item');
      expect(menuItem.price, 10.0);
      expect(menuItem.imageUrl, 'http://example.com/image.jpg');
    });

    test('MenuItem equality', () {
      final menuItem1 = MenuItem(
        id: '1',
        name: 'Test Item',
        description: 'This is a test item',
        price: 10.0,
        imageUrl: 'http://example.com/image.jpg',
      );
      final menuItem2 = MenuItem(
        id: '1',
        name: 'Test Item',
        description: 'This is a test item',
        price: 10.0,
        imageUrl: 'http://example.com/image.jpg',
      );
      final menuItem3 = MenuItem(
        id: '2',
        name: 'Another Item',
        description: 'Another description',
        price: 20.0,
        imageUrl: 'http://example.com/another.jpg',
      );

      expect(menuItem1, menuItem2);
      expect(menuItem1.hashCode, menuItem2.hashCode);
      expect(menuItem1 == menuItem3, isFalse);
      expect(menuItem1.hashCode == menuItem3.hashCode, isFalse);
    });
  });
}
