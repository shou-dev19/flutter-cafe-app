import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/menu_item.dart';
import '../../../cart/presentation/providers/cart_notifier.dart'; // To access CartNotifier

class MenuItemCard extends ConsumerWidget {
  final MenuItem menuItem;

  const MenuItemCard({super.key, required this.menuItem});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      clipBehavior: Clip.antiAlias, // Clip the image to the card shape
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 16 / 9, // Common aspect ratio for images
              child: ClipRRect( // Optional: round image corners
                borderRadius: BorderRadius.circular(4.0),
                child: Image.network(
                  menuItem.imageUrl,
                  fit: BoxFit.cover,
                  // Optional: Add loading/error builders for Image.network
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                          : null,
                    ));
                  },
                  errorBuilder: (context, error, stackTrace) =>
                      const Center(child: Icon(Icons.broken_image, size: 40)),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(menuItem.name, style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(
              '\$${menuItem.price.toStringAsFixed(2)}',
              style: textTheme.titleSmall?.copyWith(color: colorScheme.primary),
            ),
            const SizedBox(height: 8),
            Text(
              menuItem.description,
              style: textTheme.bodySmall,
              maxLines: 3, // Limit description lines
              overflow: TextOverflow.ellipsis,
            ),
            const Spacer(), // Push button to the bottom
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.black87, // Button background color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8)
                ),
                onPressed: () {
                  // Add item to cart using the notifier
                  ref.read(cartProvider.notifier).addItem(menuItem);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${menuItem.name} added to cart!'),
                      duration: const Duration(seconds: 1),
                    ),
                  );
                },
                child: const Text('Add to Cart'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}