

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_app/features/menu/data/models/product.dart';

void main() {
  group('Product', () {
    test('Product can be created with valid data', () {
      final product = Product(
        id: '1',
        name: 'Test Product',
        description: 'This is a test product',
        price: 10.0,
        imageUrl: 'http://example.com/image.jpg',
      );

      expect(product.id, '1');
      expect(product.name, 'Test Product');
      expect(product.description, 'This is a test product');
      expect(product.price, 10.0);
      expect(product.imageUrl, 'http://example.com/image.jpg');
    });

    test('Product can be converted to JSON', () {
      final product = Product(
        id: '1',
        name: 'Test Product',
        description: 'This is a test product',
        price: 10.0,
        imageUrl: 'http://example.com/image.jpg',
      );

      final json = product.toJson();

      expect(json['id'], '1');
      expect(json['name'], 'Test Product');
      expect(json['description'], 'This is a test product');
      expect(json['price'], 10.0);
      expect(json['imageUrl'], 'http://example.com/image.jpg');
    });

    test('Product can be created from JSON', () {
      final json = {
        'id': '1',
        'name': 'Test Product',
        'description': 'This is a test product',
        'price': 10.0,
        'imageUrl': 'http://example.com/image.jpg',
      };

      final product = Product.fromJson(json);

      expect(product.id, '1');
      expect(product.name, 'Test Product');
      expect(product.description, 'This is a test product');
      expect(product.price, 10.0);
      expect(product.imageUrl, 'http://example.com/image.jpg');
    });

    test('Product equality', () {
      final product1 = Product(
        id: '1',
        name: 'Test Product',
        description: 'This is a test product',
        price: 10.0,
        imageUrl: 'http://example.com/image.jpg',
      );
      final product2 = Product(
        id: '1',
        name: 'Test Product',
        description: 'This is a test product',
        price: 10.0,
        imageUrl: 'http://example.com/image.jpg',
      );
      final product3 = Product(
        id: '2',
        name: 'Another Product',
        description: 'Another description',
        price: 20.0,
        imageUrl: 'http://example.com/another.jpg',
      );

      expect(product1, product2);
      expect(product1.hashCode, product2.hashCode);
      expect(product1 == product3, isFalse);
      expect(product1.hashCode == product3.hashCode, isFalse);
    });
  });
}

