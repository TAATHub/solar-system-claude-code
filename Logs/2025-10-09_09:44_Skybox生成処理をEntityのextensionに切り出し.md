# Skybox生成処理をEntityのextensionに切り出し

## プロンプト
Skyboxの処理をEntityのextensionとして切り出して、再利用しやすいようにしてください

## 概要
Skybox生成処理を`Entity+Skybox.swift`として新規ファイルに切り出し、再利用可能なextensionメソッドとして実装しました。

## 変更点

### 新規ファイル: Entity+Skybox.swift
- `Entity.createSkybox(textureName:radius:)` staticメソッドを追加
- パラメータ:
  - `textureName`: Asset Catalogに登録されたテクスチャ名
  - `radius`: Skyboxの半径（デフォルト: 1000）
- 戻り値: 生成されたSkyboxエンティティ、失敗時はnil
- 処理内容:
  - テクスチャの読み込み
  - UnlitMaterialの設定
  - 球体メッシュの生成
  - X軸反転による内側表示

### ImmersiveView.swift:22-26
- Skybox生成処理を`Entity.createSkybox(textureName: "MilkyWay")`に置き換え
- 11行のコードが3行に簡潔化

## 副作用
特になし。既存の機能は維持したまま、コードの可読性と再利用性が向上しました。

## 関連ファイル
- [Entity+Skybox.swift](../SolarSystemClaudeCode/Entity+Skybox.swift) (新規)
- [ImmersiveView.swift:22-26](../SolarSystemClaudeCode/ImmersiveView.swift#L22-L26)
