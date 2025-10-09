# 作業ログ: RealityKitでBGMループ再生機能を実装

## プロンプト
BGM.mp3を追加したので、Immersive Spaceに入った後にBGMを繰り返し再生してください

## 概要
Immersive ViewにBGMの繰り返し再生機能を実装しました。当初AVAudioPlayerで実装しましたが、RealityKitのAmbientAudioComponentを使用する方法に変更しました。

## 変更点

### 1. 当初実装（AVAudioPlayer）
- AVFoundationをインポート
- @State private var audioPlayer: AVAudioPlayerを追加
- onAppearでBGMを読み込み、numberOfLoops = -1で無限ループ設定
- onDisappearで停止

### 2. 最終実装（AmbientAudioComponent）
- RealityKitのAudio APIを使用
- AudioFileResourceの初期化時に`configuration: .init(shouldLoop: true)`でループ設定
- AmbientAudioComponentを使用して環境音として再生
- prepareAudio().play()で再生開始

### 実装コード
```swift
// BGMの設定
do {
    let audioResource = try await AudioFileResource(
        named: "BGM.mp3",
        configuration: .init(shouldLoop: true)
    )
    let bgmEntity = Entity()
    bgmEntity.components[AmbientAudioComponent.self] = AmbientAudioComponent()
    content.add(bgmEntity)

    bgmEntity.prepareAudio(audioResource).play()
} catch {
    print("BGMの読み込みに失敗しました: \(error)")
}
```

## 副作用
- なし
- RealityKitのECSパターンに準拠した実装
- 3D空間での環境音として適切に再生

## 関連ファイル
- [ImmersiveView.swift](../SolarSystemClaudeCode/ImmersiveView.swift)
- BGM.mp3（プロジェクトルートに追加済み）

## 技術的な学び
1. AmbientAudioComponentは位置に依存しない環境音の再生に適している
2. AudioFileResourceのConfigurationでループ設定が可能
3. Entity.ambientAudioプロパティとentity.components[AmbientAudioComponent.self]は同じコンポーネントを設定する2つの方法
4. AmbientAudioComponent()は引数なしで初期化し、prepareAudio()でリソースを渡す
