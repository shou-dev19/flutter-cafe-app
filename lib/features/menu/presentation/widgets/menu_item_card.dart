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
      // CardThemeで設定されるスタイルを使用
      margin: EdgeInsets.zero, // GridViewのspacingを使うのでゼロに
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4.0),
                child: Image.asset(
                  menuItem.imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity, // Ensure image tries to fill width
                  errorBuilder: (context, error, stackTrace) =>
                      const Center(child: Icon(Icons.broken_image, size: 40)),
                ),
                // child: Image.network(
                //   menuItem.imageUrl,
                //   fit: BoxFit.cover,
                //   width: double.infinity, // Ensure image tries to fill width
                //   loadingBuilder: (context, child, loadingProgress) {
                //      if (loadingProgress == null) return child;
                //      return Center(child: CircularProgressIndicator(
                //        value: loadingProgress.expectedTotalBytes != null
                //            ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                //            : null,
                //      ));
                //    },
                //    errorBuilder: (context, error, stackTrace) =>
                //        const Center(child: Icon(Icons.broken_image, size: 40)),
                // ),
              ),
            ),
            const SizedBox(height: 12),
            Text(menuItem.name, style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, color: Colors.black87)),
            const SizedBox(height: 4),
            Text(
              '¥${menuItem.price.toStringAsFixed(0)}',
              style: textTheme.titleSmall?.copyWith(color: colorScheme.primary), // 価格はアクセントカラー
            ),
            const SizedBox(height: 8),
            Text(
              menuItem.description,
              style: textTheme.bodySmall?.copyWith(color: Colors.black54), // 説明文の色
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const Spacer(), // ボタンを下に押しやる
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                 // 画像に合わせてスタイルを設定
                 style: TextButton.styleFrom(
                   foregroundColor: Colors.black87, // 文字色
                   backgroundColor: Colors.grey[200], // 薄いグレーの背景
                   shape: RoundedRectangleBorder(
                     borderRadius: BorderRadius.circular(8),
                   ),
                   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8)
                 ),
                onPressed: () {
                  ref.read(cartProvider.notifier).addItem(menuItem);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${menuItem.name} をカートに追加しました！'),
                      duration: const Duration(seconds: 1),
                      behavior: SnackBarBehavior.floating, // オプション: スナックバーの表示形式
                    ),
                  );
                },
                child: const Text('カートに追加'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}