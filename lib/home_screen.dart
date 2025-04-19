import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import './features/cart/data/models/cart_state.dart'; // For CartState type hint
import './features/cart/presentation/providers/cart_notifier.dart';
import './features/menu/data/repositories/menu_repository.dart'; // For menuItemsProvider
import './features/cart/presentation/widgets/cart_item_tile.dart';
import './features/menu/presentation/widgets/menu_item_card.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  int _getCrossAxisCount(double width) {
    if (width < 600) return 1;
    if (width < 900) return 2;
    if (width < 1200) return 3;
    return 4;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final menuItemsAsyncValue = ref.watch(menuItemsProvider);
    final cartState = ref.watch(cartProvider);
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isWideScreen = screenWidth >= 900;

    return Scaffold(
      // AppBarのスタイルは main.dart の AppBarTheme で設定される
      appBar: AppBar(
        leading: Padding(padding: const EdgeInsets.all(4),
        child: Image.asset(
                  'assets/CafeIcon.jpeg',
                  fit: BoxFit.cover,
                  // width: double.infinity, // Ensure image tries to fill width
                  // errorBuilder: (context, error, stackTrace) =>
                  //     const Center(child: Icon(Icons.broken_image, size: 40)),
                ),),
        title: const Text('カフェ アップ'),
        centerTitle: false,
        actions: [
          _CartIcon(cartState: cartState, isWideScreen: isWideScreen),
          const SizedBox(width: 8),
        ],
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- Menu Section ---
          Expanded(
            flex: isWideScreen ? 2 : 1,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('メニュー', style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.black87)), // 文字色を濃いめに
                  const SizedBox(height: 16),
                  Expanded(
                    child: menuItemsAsyncValue.when(
                      data: (items) => items.isEmpty
                        ? const Center(child: Text('メニューが見つかりません。'))
                        : GridView.builder(
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: _getCrossAxisCount(screenWidth),
                              childAspectRatio: 0.75, // 比率調整
                              crossAxisSpacing: 12, // カード間のスペース調整
                              mainAxisSpacing: 12, // カード間のスペース調整
                            ),
                            itemCount: items.length,
                            itemBuilder: (context, index) =>
                                MenuItemCard(menuItem: items[index]),
                          ),
                      loading: () => const Center(child: CircularProgressIndicator()),
                      error: (error, stackTrace) => Center(
                        child: Text('メニュー読込エラー: ${error.toString()}'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // --- Cart Section (Only on Wide Screens) ---
          if (isWideScreen)
            Expanded(
              flex: 1,
              child: _CartSection(cartState: cartState),
            ),
        ],
      ),
      // endDrawer: isWideScreen ? null : Drawer(child: _CartSection(cartState: cartState)),
    );
  }
}

// --- Helper Widget for Cart Icon ---
class _CartIcon extends StatelessWidget {
  final CartState cartState;
  final bool isWideScreen;

  const _CartIcon({required this.cartState, required this.isWideScreen});

  @override
  Widget build(BuildContext context) {
    final itemCount = cartState.items.fold<int>(0, (sum, item) => sum + item.quantity);
    // 画像に合わせたオレンジ色
    final Color cartButtonColor = Colors.deepOrange; // ThemeのseedColorと同じ

    return Stack(
      alignment: Alignment.center,
      children: [
        ElevatedButton.icon(
          icon: const Icon(Icons.shopping_cart_outlined, size: 20),
          label: const Text('カート'),
          style: ElevatedButton.styleFrom(
             // 画像に合わせてオレンジ色に設定
             foregroundColor: Colors.white,
             backgroundColor: cartButtonColor,
             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
          onPressed: () {
             if (!isWideScreen) {
               showModalBottomSheet(
                 context: context,
                 isScrollControlled: true,
                 builder: (_) => FractionallySizedBox(
                      heightFactor: 0.7,
                      child: _CartSection(cartState: cartState)
                   )
               );
             } else {
               print("カートは表示済み");
             }
          },
        ),
        if (itemCount > 0)
          Positioned(
            right: 4,
            top: 4,
            child: Container(
               padding: const EdgeInsets.all(2),
               decoration: BoxDecoration(
                 color: Colors.red, // バッジの色は赤
                 borderRadius: BorderRadius.circular(10),
               ),
               constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
               child: Text(
                 '$itemCount',
                 style: const TextStyle(color: Colors.white, fontSize: 10),
                 textAlign: TextAlign.center,
               ),
            ),
          ),
      ],
    );
  }
}


// --- Helper Widget for Cart Section ---
class _CartSection extends StatelessWidget {
    final CartState cartState;
    const _CartSection({required this.cartState});

    @override
    Widget build(BuildContext context) {
      return Card(
        child: Padding(padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('カート', style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.black87)),
            const SizedBox(height: 16),
            Expanded(
              child: cartState.items.isEmpty
                  ? const Center(child: Text('カートは空です。'))
                  : ListView.builder(
                      itemCount: cartState.items.length,
                      itemBuilder: (context, index) =>
                          CartItemTile(cartItem: cartState.items[index]),
                    ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('合計:', style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.black87)),
                  Text(
                    '¥${cartState.totalPrice.toStringAsFixed(0)}',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                // style は main.dart の elevatedButtonTheme で設定される (オレンジ色)
                onPressed: cartState.items.isEmpty ? null : () {
                  print('注文確定ボタンが押されました！ 合計: ¥${cartState.totalPrice.toStringAsFixed(0)}');
                },
                child: const Text('注文を確定する'),
              ),
            ),
          ],
        ),),
      );
    }
}