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
      appBar: AppBar(
        // AppBarタイトルを日本語に
        title: const Text('カフェ デライト'),
        centerTitle: false,
        actions: [
          _CartIcon(cartState: cartState, isWideScreen: isWideScreen),
          const SizedBox(width: 8),
        ],
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 1,
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
                  // セクションタイトルを日本語に
                  Text('メニュー', style: Theme.of(context).textTheme.headlineSmall),
                  const SizedBox(height: 16),
                  Expanded(
                    child: menuItemsAsyncValue.when(
                      data: (items) => items.isEmpty
                        // 空メッセージを日本語に
                        ? const Center(child: Text('メニューが見つかりません。'))
                        : GridView.builder(
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: _getCrossAxisCount(screenWidth),
                              childAspectRatio: 0.75,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                            ),
                            itemCount: items.length,
                            itemBuilder: (context, index) =>
                                MenuItemCard(menuItem: items[index]),
                          ),
                      loading: () => const Center(child: CircularProgressIndicator()),
                      error: (error, stackTrace) => Center(
                        // エラーメッセージを日本語に
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
       // Narrow screen 用の Drawer や BottomSheet を設定する場合
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
    return Stack(
      alignment: Alignment.center,
      children: [
        ElevatedButton.icon(
          icon: const Icon(Icons.shopping_cart_outlined, size: 20),
          // ボタンラベルを日本語に
          label: const Text('カート'),
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.deepOrangeAccent,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
          onPressed: () {
            if (!isWideScreen) {
              // 例: BottomSheet を表示
               showModalBottomSheet(
                 context: context,
                 // CartSectionの高さを適切に設定する必要がある
                 builder: (_) => Container(
                   height: MediaQuery.of(context).size.height * 0.6, // 高さを画面の60%に
                   child: _CartSection(cartState: cartState)
                  )
               );
              // print("カート画面へ遷移 または Bottom Sheet/Drawer を表示");
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
                color: Colors.red,
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
      return Container(
        color: Colors.grey[100],
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // セクションタイトルを日本語に
            Text('カート', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 16),
            Expanded(
              child: cartState.items.isEmpty
                  // 空メッセージを日本語に
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
                  // ラベルを日本語に
                  Text('合計:', style: Theme.of(context).textTheme.titleLarge),
                  Text(
                    // 通貨記号を円に (必要に応じて)
                    '¥${cartState.totalPrice.toStringAsFixed(0)}', // 小数点以下なしに
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: cartState.items.isEmpty ? null : () {
                  // 注文確定ロジック
                  print('注文確定ボタンが押されました！ 合計: ¥${cartState.totalPrice.toStringAsFixed(0)}');
                },
                // ボタンラベルを日本語に
                child: const Text('注文を確定する'),
              ),
            ),
          ],
        ),
      );
    }
}