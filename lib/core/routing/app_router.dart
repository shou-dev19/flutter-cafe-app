

import 'package:flutter/material.dart';
import 'package:flutter_app/home_screen.dart';
import 'package:flutter_app/features/order/presentation/screens/order_screen.dart';
import 'package:flutter_app/features/cart/presentation/screens/cart_screen.dart';

class AppRouter {
  static const String homeRoute = '/';
  static const String orderRoute = '/order';
  static const String cartRoute = '/cart';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeRoute:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case orderRoute:
        return MaterialPageRoute(builder: (_) => const OrderScreen());
      case cartRoute:
        return MaterialPageRoute(builder: (_) => const CartScreen());
      default:
        return MaterialPageRoute(builder: (_) => Text('Error: Unknown route ${settings.name}'));
    }
  }
}

