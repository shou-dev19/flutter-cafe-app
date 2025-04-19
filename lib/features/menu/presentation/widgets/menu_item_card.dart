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
      clipBehavior: Clip.antiAlias,
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4.0),
                child: Image.network(
                  menuItem.imageUrl,
                  fit: BoxFit.cover,
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
              // 通貨記号を円に
              '¥${menuItem.price.toStringAsFixed(0)}', // 小数点以下なしに
              style: textTheme.titleSmall?.copyWith(color: colorScheme.primary),
            ),
            const SizedBox(height: 8),
            Text(
              menuItem.description,
              style: textTheme.bodySmall,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const Spacer(),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                 style: TextButton.styleFrom(
                   foregroundColor: Colors.white,
                   backgroundColor: Colors.black87,
                   shape: RoundedRectangleBorder(
                     borderRadius: BorderRadius.circular(8),
                   ),
                   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8)
                 ),
                onPressed: () {
                  ref.read(cartProvider.notifier).addItem(menuItem);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      // SnackBarメッセージを日本語に
                      content: Text('${menuItem.name} をカートに追加しました！'),
                      duration: const Duration(seconds: 1),
                    ),
                  );
                },
                // ボタンラベルを日本語に
                child: const Text('カートに追加'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}