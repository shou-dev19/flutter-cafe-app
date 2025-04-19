import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../cart/data/models/cart_item.dart';
import '../providers/cart_notifier.dart';

class CartItemTile extends ConsumerWidget {
  final CartItem cartItem;

  const CartItemTile({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 画像に合わせた削除ボタンの色
    const removeButtonColor = Colors.redAccent;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(cartItem.name, style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.black87)),
                Text(
                  '¥${cartItem.price.toStringAsFixed(0)}',
                   style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.black54)
                ),
                if (cartItem.quantity > 1)
                   Text('数量: ${cartItem.quantity}', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.black54)),
              ],
            ),
          ),
          TextButton(
             // 画像に合わせてスタイルを設定
             style: TextButton.styleFrom(
               foregroundColor: Colors.white, // 文字色
               backgroundColor: removeButtonColor, // 赤系の背景
               padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
               minimumSize: Size.zero,
               tapTargetSize: MaterialTapTargetSize.shrinkWrap,
               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)), // 少し角丸
             ),
            onPressed: () {
              ref.read(cartProvider.notifier).removeItem(cartItem.menuItemId);
            },
            child: const Text('削除'),
          ),
        ],
      ),
    );
  }
}