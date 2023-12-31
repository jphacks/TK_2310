# safa_app

ゴミ拾いと広告のマッチングサービス「SAFA」のモバイルアプリです。

# 導入

**install flutter**

```bash
# if you don't have plugins
asdf plugin add flutter
asdf plugin add dart

asdf install
make setup
```

**install xcodes**

xcodes とは、Xcode のバージョン管理ツールです。

```bash
brew install xcodesorg/made/xcodes
xcodes install
```

**install packages**

```bash

flutter pub run import_sorter:main
flutter pub add dev:very_good_analysis

# only MacOS
brew install FlutterGen/tap/fluttergen
# end

dart pub global activate flutter_gen


```

# 使用方法

Makefile を使用しているので、以下のコマンドを実行することで、必要なコマンドを実行できます。

```bash
# example
# flutter clean
make clean

# commit前は必ずformatをかける
make format

```

# ディレクトリ構成

```
├── lib/
│   ├── foundation/ (基盤系のインスタンスまとめ)
│   │   └── supabase/
│   │   └── supabase_auth.dart
│   ├── domain/ (DB アクセス関連)
│   │   └── entity/
│   │   ├── xxx_entity.dart
│   │   └── repository/
│   │   └── xxx_repo.dart
│   ├── presentation/ (UI 層)
│   │   ├── component/ (全ての screen で使用するコンポーネント)
│   │   ├── screen/
│   │   └──── xxx/
│   │         └── component/
│   │             └── xxx_screen.dart
│   ├── route
│   │   └── auto_route.dart
│   ├── hooks
│   │   └── use_xxx.dart
│   ├── use_case/
│   │ └── xxx_use_case.dart
│   ├── theme/
│   │ └── xxx.dart
│   └── main.dart
├── pubspec.lock
├── pubspec.yaml
├── DOCUMENT.md
└── README.md
```

# 実装方針

## 画像の利用

- widget

[extended_image](https://pub.dev/packages/extended_image)を利用しているので、画像のキャッシュは自動で行われる。

```dart
// example
// assetsもあります
ExtendedImage.network(
    'https://avatars.githubusercontent.com/u/1396951?v=4',
    width: 100,
    height: 100,
    fit: BoxFit.cover,
    cache: true,
    border: Border.all(color: Colors.red, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(30.0)),
    //cancelToken: cancellationToken,
)
```

- 画像の挿入

[flutter_gen](https://pub.dev/packages/flutter_gen)を利用しているので、以下のコマンドを実行することで、画像の挿入が可能です。

使い方

```bash
# assets/imagesに画像を挿入したら、以下のコマンドを実行する
make build_runner
```

記法

```dart
// example
// profileの部分のが画像のファイル名に値する
Widget build(BuildContext context) {
  return Assets.images.profile.image();
}

```

## 空白の利用

[gap](https://pub.dev/packages/gap)を利用しているので、空白の調整は自動で行われる。

```dart
// example
Gap(10)
```

## カラーの適応

flutter_gen を利用しているので、以下のコマンドを実行することで、カラーの挿入が可能です。

使い方

1. assets/colors にカラーを挿入

```xml
<?xml version="1.0" encoding="utf-8"?>
<resources>
    <color name="test_color">#DBEDFB</color>
    <!-- ここにカラーを挿入する -->
    <color name="xxxx">16進数のカラーコード</color>
</resources>
```

2. assets/colors にカラーを挿入したら、以下のコマンドを実行する

```bash
make build_runner
```

<!-- TODO: auto_route, riverpod, hooks, freezed -->
