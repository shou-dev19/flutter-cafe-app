import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../cart/data/models/cart_item.dart';
import '../providers/cart_notifier.dart';

class CartItemTile extends ConsumerWidget {
  final CartItem cartItem;

  const CartItemTile({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(cartItem.name, style: Theme.of(context).textTheme.titleMedium),
                Text(
                  // 通貨記号を円に
                  '¥${cartItem.price.toStringAsFixed(0)}', // 小数点以下なしに
                   style: Theme.of(context).textTheme.bodySmall
                ),
                if (cartItem.quantity > 1)
                   // ラベルを日本語に
                   Text('数量: ${cartItem.quantity}', style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ),
          TextButton(
             style: TextButton.styleFrom(
               foregroundColor: Colors.white,
               backgroundColor: Colors.redAccent,
               padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
               minimumSize: Size.zero,
               tapTargetSize: MaterialTapTargetSize.shrinkWrap,
             ),
            onPressed: () {
              ref.read(cartProvider.notifier).removeItem(cartItem.menuItemId);
            },
            // ボタンラベルを日本語に
            child: const Text('削除'),
          ),
        ],
      ),
    );
  }
}