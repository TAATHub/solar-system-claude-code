# 作業ログ: Entity読み込み時にpositionを原点にリセット

## プロンプト

各天体はReality Composer Proのシーン上では、見やすいように原点からずらしているので、読み込み時にpositionを原点に戻してください

## 概要

Reality Composer Proで編集時に配置されたEntity位置をリセットし、プログラム側で制御する公転・自転システムが正しく動作するようにしました。

## 変更点

### CelestialBodyModel.swift (CelestialBodyFactory.addCelestialBody)

シーンから取得したEntityのpositionを原点にリセットする処理を追加:

```swift
// Reality Composer Proで配置時のオフセットをリセット
celestialBody.position = .zero
```

この処理により:
- Reality Composer Proでの編集時の位置は維持される（編集しやすい）
- ランタイムでは原点からスタートし、OrbitSystemが正しく動作する

## 副作用

なし。むしろReality Composer Pro上での編集位置とランタイムでの動作位置を分離できるため、編集性が向上します。

## 関連ファイル

- [CelestialBodyModel.swift:60](../SolarSystemClaudeCode/CelestialBodyModel.swift#L60)

## ビルド結果

✅ ビルド成功、visionOSシミュレータで正常に動作確認済み
