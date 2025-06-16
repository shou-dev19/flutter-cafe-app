

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_app/features/menu/data/repositories/menu_repository.dart';
import 'package:flutter_app/features/menu/domain/entities/menu_item.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_app/data/datasources/remote/api_client.dart';

class MockApiClient extends Mock implements ApiClient {}

void main() {
  group('MenuRepository', () {
    late MenuRepository menuRepository;
    late MockApiClient mockApiClient;

    setUp(() {
      mockApiClient = MockApiClient();
      menuRepository = MenuRepository(apiClient: mockApiClient);
    });

    test('getMenuItems returns a list of MenuItem', () async {
      final mockResponse = [
        {
          'id': '1',
          'name': 'Coffee',
          'description': 'Hot coffee',
          'price': 3.0,
          'imageUrl': 'coffee.jpg'
        },
        {
          'id': '2',
          'name': 'Tea',
          'description': 'Hot tea',
          'price': 2.5,
          'imageUrl': 'tea.jpg'
        },
      ];

      when(() => mockApiClient.get('menu.json'))
          .thenAnswer((_) async => mockResponse);

      final menuItems = await menuRepository.getMenuItems();

      expect(menuItems, isA<List<MenuItem>>());
      expect(menuItems.length, 2);
      expect(menuItems[0].name, 'Coffee');
      expect(menuItems[1].name, 'Tea');
      verify(() => mockApiClient.get('menu.json')).called(1);
    });

    test('getMenuItems throws an exception on API error', () async {
      when(() => mockApiClient.get('menu.json'))
          .thenThrow(Exception('Failed to load menu'));

      expect(() => menuRepository.getMenuItems(), throwsA(isA<Exception>()));
      verify(() => mockApiClient.get('menu.json')).called(1);
    });
  });
}

