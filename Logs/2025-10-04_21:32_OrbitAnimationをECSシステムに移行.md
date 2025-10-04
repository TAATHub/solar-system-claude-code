# 作業ログ: OrbitAnimationをECSシステムに移行

## プロンプト
@SolarSystemClaudeCode/ImmersiveView.swift#L38でOrbitAnimationで円周運動を実装していますが、太陽系シミュレーションのようにオブジェクトが多くなったり、自転や公転が存在する場合、Animationだと複雑になってしまうので、ECSのSystemを使って赤い球体の円周運動を修正してください

## 概要
ImmersiveViewで使用していたOrbitAnimationによる円周運動の実装を、RealityKitのECS（Entity Component System）パターンに移行しました。これにより、複数の天体の自転・公転を扱う太陽系シミュレーションに対応しやすい構造に変更しました。

## 変更点

### 新規ファイル作成

1. **OrbitComponent.swift** (新規作成)
   - 軌道運動に必要なパラメータを保持するComponent
   - パラメータ:
     - `radius`: 軌道半径（メートル）
     - `angularVelocity`: 角速度（ラジアン/秒）
     - `currentAngle`: 現在の角度（ラジアン）
     - `axis`: 軌道の軸（デフォルトはY軸）
   - イニシャライザで周期（period）から角速度を自動計算

2. **OrbitSystem.swift** (新規作成)
   - 軌道運動のロジックを処理するSystem
   - `EntityQuery`でOrbitComponentを持つエンティティを検索
   - `update`メソッドで毎フレーム:
     - 角度を更新（角速度 × デルタ時間）
     - 軌道上の新しい位置を計算
     - エンティティの位置を更新
   - Y軸まわりの回転に最適化（X-Z平面上の円運動）
   - 他の軸にも対応可能（回転行列使用）

### 既存ファイル修正

3. **ImmersiveView.swift**
   - OrbitAnimationの実装を削除（L38-48）
   - OrbitSystemの登録を追加（L17）
   - OrbitComponentを球体エンティティに追加（L40）
   - パラメータ: 半径1m、周期10秒、Y軸まわり

## 技術的詳細

### ECS実装の利点
- **拡張性**: 複数の天体を追加しても、同じSystemで処理可能
- **保守性**: コンポーネントがデータ、Systemがロジックと役割が明確
- **パフォーマンス**: RealityKitのECSエンジンによる最適化が効く
- **組み合わせ可能**: 自転用のComponentを追加するだけで自転+公転が実現可能

### 軌道計算
- Y軸まわりの回転: `x = cos(θ) * r`, `z = sin(θ) * r`
- 角速度の計算: `ω = 2π / 周期`

## 副作用
- OrbitAnimationへの依存がなくなり、AnimationResourceの生成処理が不要になった
- System登録が必要（初回のみ実行）
- 今後、自転や複数天体を追加する際は、同様のパターンで実装可能

## 関連ファイル
- `/Users/taat/git/SolarSystemClaudeCode/SolarSystemClaudeCode/OrbitComponent.swift`（新規）
- `/Users/taat/git/SolarSystemClaudeCode/SolarSystemClaudeCode/OrbitSystem.swift`（新規）
- `/Users/taat/git/SolarSystemClaudeCode/SolarSystemClaudeCode/ImmersiveView.swift`（修正）

## ビルド&実行結果
✅ ビルド成功
✅ visionOS Simulator上で正常動作確認
