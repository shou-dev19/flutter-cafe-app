import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/menu_item.dart';

// Interface (abstract class)
abstract class MenuRepository {
  Future<List<MenuItem>> getMenuItems();
}

// Implementation
class LocalMenuRepository implements MenuRepository {
  @override
  Future<List<MenuItem>> getMenuItems() async {
    try {
      // Load the JSON string from assets
      final String response = await rootBundle.loadString('assets/menu.json');
      // Decode the JSON string into a List<dynamic>
      final List<dynamic> data = json.decode(response);
      // Map the dynamic list to a List<MenuItem>
      return data.map((json) => MenuItem.fromJson(json)).toList();
    } catch (e) {
      // Handle potential errors during file loading or parsing
      print('Error loading menu items: $e');
      // Consider throwing a custom exception or returning an empty list
      throw Exception('Failed to load menu items');
    }
  }
}

// Provider for the repository implementation
final menuRepositoryProvider = Provider<MenuRepository>((ref) {
  return LocalMenuRepository();
});

// FutureProvider to fetch menu items using the repository
final menuItemsProvider = FutureProvider<List<MenuItem>>((ref) async {
  final menuRepository = ref.watch(menuRepositoryProvider);
  return menuRepository.getMenuItems();
});