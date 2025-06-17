


import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_app/core/constants/app_constants.dart';

void main() {
  group('AppConstants', () {
    test('appName is correct', () {
      expect(AppConstants.appName, 'Cafe App');
    });

    test('menuAssetPath is correct', () {
      expect(AppConstants.menuAssetPath, 'assets/menu.json');
    });

    test('cafeIconAssetPath is correct', () {
      expect(AppConstants.cafeIconAssetPath, 'assets/CafeIcon.jpeg');
    });
  });
}


