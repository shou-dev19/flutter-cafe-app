import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'home_screen.dart'; // Import your home screen

void main() {
  runApp(
    // Wrap your app with ProviderScope
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // --- 色の定義 ---
    const scaffoldBgColor = Color(0xFFF5F5F5); // 明るいグレー (例: grey[100]相当)
    // const scaffoldBgColor = Color(0xFFFAFAFA); // 限りなく白に近いグレー
    const appBarColor = Colors.white;
    const appBarForegroundColor = Colors.black87; // AppBarの文字やアイコンの色
    const cardColor = Colors.white;
    const accentOrange = Colors.deepOrange; // カートボタンや確定ボタンの色
    const accentRed = Colors.redAccent; // 削除ボタンの色

    return MaterialApp(
      title: 'カフェ アップ',
      theme: ThemeData(
        // ColorSchemeのseedはボタン等に影響するが、AppBarは個別設定
        colorScheme: ColorScheme.fromSeed(
          seedColor: accentOrange,
          brightness: Brightness.light,
        ),
        useMaterial3: true,

        // --- Scaffold全体の背景色を設定 ---
        scaffoldBackgroundColor: scaffoldBgColor,

        // --- AppBarのテーマを白背景・黒文字に設定 ---
        appBarTheme: const AppBarTheme(
          backgroundColor: appBarColor,
          foregroundColor: appBarForegroundColor,
          elevation: 1, // わずかな影で境界を示す

          // surfaceTintColor を AppBar の背景色と同じにするか、完全に透明にする
          surfaceTintColor: appBarColor, // または Colors.transparent

          titleTextStyle: TextStyle( // タイトルのスタイル
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: appBarForegroundColor, // 文字色
          ),
          iconTheme: IconThemeData( // アイコンの色
            color: appBarForegroundColor,
          ),
          // 必要に応じてスクロール時の影の色も調整
          // scrolledUnderElevation: 0, // スクロール時の影をなくす場合
        ),

        // --- カードのテーマ ---
        cardTheme: CardThemeData(
          color: cardColor, // カードの背景色を白に明示
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),

        // --- 全体のボタンテーマ（個々のボタンで上書き可能） ---
         elevatedButtonTheme: ElevatedButtonThemeData(
           style: ElevatedButton.styleFrom(
             // 基本はオレンジ系にしておくが、Confirm Orderボタンでこのスタイルが使われる想定
             foregroundColor: Colors.white,
             backgroundColor: accentOrange,
             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
           ),
         ),
         textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              // TextButtonのデフォルトスタイル (Add to Cart や Remove で上書き)
              // foregroundColor: accentOrange,
            )
         ),

        // 日本語フォントが適切に表示されるようにフォントファミリーを指定することも検討
        // fontFamily: 'Noto Sans JP', // google_fonts パッケージなどを利用
      ),
      home: const HomeScreen(),
    );
  }
}
