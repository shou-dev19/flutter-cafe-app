import 'package:freezed_annotation/freezed_annotation.dart';

// ↓ --- この2行が重要 --- ↓
part 'menu_item.freezed.dart'; // freezed が生成するコードを含むファイル
part 'menu_item.g.dart'; // json_serializable が生成するコードを含むファイル
// ↑ ---------------------- ↑

@freezed // freezedを使うことを示すアノテーション
class MenuItem with _$MenuItem {
  // _$クラス名 というMixinを使う

  // ↓ --- クラスの本体を定義 --- ↓
  // このファクトリコンストラクタでプロパティを定義する
  const factory MenuItem({
    required String id,
    required String name,
    required String description,
    required double price,
    required String imageUrl,
  }) = _MenuItem; // _クラス名 というプライベートクラスを指定
  // ↑ ------------------------- ↑

  // ↓ --- JSON変換用のファクトリコンストラクタ --- ↓
  // Map<String, dynamic> (JSON形式) から MenuItem オブジェクトを生成する
  factory MenuItem.fromJson(Map<String, dynamic> json) =>
      _$MenuItemFromJson(json); // _$クラス名FromJson という生成される関数を使う
  // ↑ ------------------------------------------- ↑
}
