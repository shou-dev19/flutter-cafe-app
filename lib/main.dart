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
    return MaterialApp(
      // アプリタイトルを日本語に (OSのタスクスイッチャーなどで表示される)
      title: 'カフェ デライト',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black87,
          elevation: 1,
        ),
        cardTheme: CardTheme(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        // 日本語フォントが適切に表示されるようにフォントファミリーを指定することも検討
        // fontFamily: 'Noto Sans JP', // google_fonts パッケージなどを利用
      ),
      home: const HomeScreen(),
    );
  }
}