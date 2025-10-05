# 作業ログ: CelestialBodyModelにサイズパラメータを追加しスケール調整機能を実装

## プロンプト

> RealityComposer Proで作成したモデルはサイズ1.0なので、CelestialBodyModelでサイズを設定できるようにしてください。
> なお、サイズの基準としてSunを1.0とする

## 概要

RealityComposer Proで作成した3Dモデルは全てサイズ1.0で統一されているため、CelestialBodyModelにサイズパラメータを追加し、Sun=1.0を基準としたスケール調整を可能にしました。

## 変更点

### 1. CelestialBodyModel.swift - モデル定義

**追加内容**:
```swift
struct CelestialBodyModel {
    let modelName: String
    let size: Float  // Sun = 1.0基準のサイズ ← 追加
    // ...

    init(
        modelName: String,
        size: Float = 1.0,  // デフォルト値: 1.0 ← 追加
        // ...
    )
}
```

**説明**:
- `size`プロパティを追加（Sun = 1.0基準）
- デフォルト値を1.0に設定（Sunの場合は明示不要）

### 2. CelestialBodyFactory.swift - スケール適用

**追加内容**:
```swift
static func addCelestialBody(/*...*/) async -> (/*...*/)? {
    guard let celestialBody = try? await Entity(named: model.modelName, /*...*/) else {
        // ...
    }

    // サイズを設定（Sun = 1.0基準）← 追加
    celestialBody.scale = SIMD3<Float>(repeating: model.size)

    // ...
}
```

**説明**:
- モデル読み込み後、`celestialBody.scale`にサイズを設定
- SIMD3で均等スケール（X, Y, Z全て同じ値）

### 3. ImmersiveView.swift - Earth/Moonのサイズ設定

**変更内容**:
```swift
// Earthのセットアップ
let earthModel = CelestialBodyModel(
    modelName: "Earth",
    size: 0.00918,  // 太陽の直径の約1/109 ← 追加
    // ...
)

// Moonのセットアップ
let moonModel = CelestialBodyModel(
    modelName: "Moon",
    size: 0.00250,  // 太陽の直径の約1/400 ← 追加
    // ...
)
```

**天文的数値（実スケール）**:
| 天体  | 実際の直径比 | 設定値  |
|-------|--------------|---------|
| Sun   | 1.0          | 1.0     |
| Earth | 1/109        | 0.00918 |
| Moon  | 1/400        | 0.00250 |

## 副作用

なし。既存のSunはデフォルト値1.0が適用され、動作に変更はありません。

## 関連ファイル

- `/Users/taat/git/SolarSystemClaudeCode/SolarSystemClaudeCode/CelestialBodyModel.swift` (CelestialBodyModel.swift:13-21, 58-59)
- `/Users/taat/git/SolarSystemClaudeCode/SolarSystemClaudeCode/ImmersiveView.swift` (ImmersiveView.swift:32, 46)

## ビルド&実行結果

- ビルド: 成功
- 実行: Apple Vision Pro実機で正常起動
- エラー・警告: なし
