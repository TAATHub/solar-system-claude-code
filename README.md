# 太陽系シミュレーション

visionOS向けの3D太陽系シミュレーションアプリケーションです。Immersive SpaceとVolumeの両方で太陽系を体験でき、天体にタッチすることで詳細情報を確認できます。

![デモ動画](https://drive.google.com/file/d/1ScSIVKoFV_wMpggmanNgDmt1qT1D21Dv/view?usp=sharing)

## 特徴

- **没入型体験**: Immersive Spaceで太陽系全体を360度見渡せる
- **ボリュームモード**: Volumeウィンドウでコンパクトに太陽系を表示
- **インタラクティブ**: 天体をタップすると名前や詳細情報が表示される
- **リアルな動き**: 惑星の公転・自転をシミュレーション
- **美しいビジュアル**: 各惑星の特徴を再現したテクスチャとマテリアル

## 技術スタック

- **Swift**: アプリケーションロジック
- **SwiftUI**: UI構築
- **RealityKit**: 3Dレンダリングとアニメーション
- **ECSアーキテクチャ**: Entity-Component-Systemによる効率的なオブジェクト管理

## プロジェクト構造

```
SolarSystemClaudeCode/
├── SolarSystemClaudeCodeApp.swift    # アプリエントリーポイント
├── AppModel.swift                     # アプリ状態管理
├── ContentView.swift                  # メインビュー
├── ImmersiveView.swift               # Immersive Space用ビュー
├── VolumeView.swift                  # Volume用ビュー
├── SolarSystemBuilder.swift          # 太陽系の構築ロジック
├── CelestialBodyData.swift           # 天体データ定義
├── CelestialBodyModel.swift          # 天体モデル
├── OrbitComponent.swift              # 公転コンポーネント
├── OrbitSystem.swift                 # 公転システム
├── RotationComponent.swift           # 自転コンポーネント
├── RotationSystem.swift              # 自転システム
├── CelestialBodyInfoComponent.swift  # 天体情報コンポーネント
└── Entity+Skybox.swift               # Skybox拡張
```

## 動作要件

- visionOS 26.0以上
- Xcode 16.0以上
- Apple Vision Pro

## ビルド方法

1. リポジトリをクローン
```bash
git clone [repository-url]
cd SolarSystemClaudeCode
```

2. Xcodeでプロジェクトを開く
```bash
open SolarSystemClaudeCode.xcodeproj
```

3. ターゲットデバイスを選択（Vision Proシミュレータまたは実機）

4. Command + Rでビルド＆実行

## 使い方

1. アプリを起動すると、メインウィンドウが表示されます
2. 「View Options」をタップしてビューを選択:
   - **Volume**: コンパクトなウィンドウ内で太陽系を表示
   - **Immersive**: 没入型の全画面空間で太陽系を体験
3. 天体をタップすると、その天体の名前と情報が表示されます
4. Immersive Spaceでは視線を動かして360度太陽系を見渡せます

## ECSアーキテクチャ

このプロジェクトはRealityKitのEntity-Component-Systemパターンを採用しています：

### Components（コンポーネント）
- **OrbitComponent**: 公転軌道のパラメータ（半径、速度、初期角度）
- **RotationComponent**: 自転のパラメータ（速度、軸）
- **CelestialBodyInfoComponent**: 天体の情報（名前、説明）

### Systems（システム）
- **OrbitSystem**: 全惑星の公転運動を毎フレーム更新
- **RotationSystem**: 全天体の自転運動を毎フレーム更新

これにより、データとロジックを分離し、効率的で拡張性の高い実装を実現しています。

## コーディングガイドライン

開発に参加する場合は、以下のガイドラインを参照してください：

- [RealityKit ECS Guide](.claude/RealityKit_ECS_Guide.md)
- [RealityKit AttachmentComponent Guide](.claude/RealityKit_AttachmentComponent_Guide.md)
- [visionOS Window Management](.claude/visionOSWindowManagement.md)