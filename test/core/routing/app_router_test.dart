


import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_app/core/routing/app_router.dart';
import 'package:flutter_app/home_screen.dart';
import 'package:flutter_app/features/order/presentation/screens/order_screen.dart';
import 'package:flutter_app/features/cart/presentation/screens/cart_screen.dart';

void main() {
  group('AppRouter', () {
    test('generateRoute returns HomeScreen for homeRoute', () {
      final route = AppRouter.generateRoute(const RouteSettings(name: AppRouter.homeRoute));
      expect(route, isA<MaterialPageRoute>());
      expect(route.builder(null), isA<HomeScreen>());
    });

    test('generateRoute returns OrderScreen for orderRoute', () {
      final route = AppRouter.generateRoute(const RouteSettings(name: AppRouter.orderRoute));
      expect(route, isA<MaterialPageRoute>());
      expect(route.builder(null), isA<OrderScreen>());
    });

    test('generateRoute returns CartScreen for cartRoute', () {
      final route = AppRouter.generateRoute(const RouteSettings(name: AppRouter.cartRoute));
      expect(route, isA<MaterialPageRoute>());
      expect(route.builder(null), isA<CartScreen>());
    });

    test('generateRoute returns error page for unknown route', () {
      final route = AppRouter.generateRoute(const RouteSettings(name: '/unknown'));
      expect(route, isA<MaterialPageRoute>());
      expect(route.builder(null), isA<Text>());
      final widget = route.builder(null) as Text;
      expect(widget.data, 'Error: Unknown route /unknown');
    });
  });
}


