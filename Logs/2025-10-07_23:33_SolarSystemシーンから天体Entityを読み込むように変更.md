# 作業ログ: SolarSystemシーンから天体Entityを読み込むように変更

## プロンプト

SolarSystemシーンを用意したので、SolarSystemを読み込んでその中からSun、Earth、MoonのEntityを探すように処理を変更してください。

## 概要

個別のEntityファイルからの読み込みを、SolarSystemシーン全体を読み込んでからその中のEntityを検索する方式に変更しました。

## 変更点

### 1. ImmersiveView.swift

- SolarSystemシーンを一度だけ読み込むように変更
- Sun、Earth、MoonはSolarSystemシーンから`findEntity(named:)`で検索
- CelestialBodyFactoryに`fromScene`パラメータを追加して渡すように変更

変更前:
```swift
if let sun = try? await Entity(named: "Sun", in: realityKitContentBundle) {
    origin.addChild(sun)
}
```

変更後:
```swift
// SolarSystemシーンを読み込む
guard let solarSystemScene = try? await Entity(named: "SolarSystem", in: realityKitContentBundle) else {
    print("SolarSystemシーンの読み込みに失敗しました")
    return
}

// Sunを取得して追加
if let sun = solarSystemScene.findEntity(named: "Sun") {
    origin.addChild(sun)
}
```

### 2. CelestialBodyModel.swift (CelestialBodyFactory)

- `addCelestialBody`メソッドに`fromScene: Entity`パラメータを追加
- RealityKitバンドルから個別にEntityを読み込む代わりに、渡されたシーンから検索するように変更

変更前:
```swift
static func addCelestialBody(
    model: CelestialBodyModel,
    to parent: Entity
) async -> (orbitContainer: Entity, rotationContainer: Entity)? {
    guard let celestialBody = try? await Entity(named: model.modelName, in: realityKitContentBundle) else {
        print("Failed to load model: \(model.modelName)")
        return nil
    }
```

変更後:
```swift
static func addCelestialBody(
    model: CelestialBodyModel,
    to parent: Entity,
    fromScene scene: Entity
) async -> (orbitContainer: Entity, rotationContainer: Entity)? {
    guard let celestialBody = scene.findEntity(named: model.modelName) else {
        print("Failed to find entity: \(model.modelName)")
        return nil
    }
```

## 副作用

- SolarSystemシーンにSun、Earth、Moonという名前のEntityが存在しない場合、読み込みに失敗します
- エラーメッセージが"Failed to load model"から"Failed to find entity"に変更されました

## 関連ファイル

- [ImmersiveView.swift](../SolarSystemClaudeCode/ImmersiveView.swift)
- [CelestialBodyModel.swift](../SolarSystemClaudeCode/CelestialBodyModel.swift)

## ビルド結果

✅ ビルド成功、Apple Vision Pro実機で正常に動作確認済み
