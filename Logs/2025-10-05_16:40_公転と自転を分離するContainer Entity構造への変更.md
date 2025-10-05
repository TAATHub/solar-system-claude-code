# 作業ログ: 公転と自転を分離するContainer Entity構造への変更

## プロンプト
赤いキューブが自転すると、逆回転行列も影響を受けて、結果的に白いキューブの回転軸が変化してしまう問題を解決するため、それぞれのキューブの親に公転用のContainer Entityを追加し、そのContainerにOrbitComponentを適用し、キューブ本体のEntityに自転軸の傾きやRotationComponentを適用するように変更。

## 概要
公転と自転を完全に分離するため、各キューブに公転用のContainer Entityを追加しました。これにより、親の自転が子の回転軸に影響しなくなります。

## 変更点

### 階層構造の変更

**変更前:**
```mermaid
graph TD
    A[origin] --> B[cubeEntity 赤]
    B --> C[whiteCubeEntity 白]

    B -.-> B1[OrbitComponent<br/>半径5m, 周期10秒]
    B -.-> B2[RotationComponent<br/>Y軸, 周期5秒]
    B -.-> B3[傾き 30°]

    C -.-> C1[OrbitComponent<br/>半径2m, 周期10秒]
    C -.-> C2[RotationComponent<br/>Y軸, 周期5秒]
    C -.-> C3[逆回転行列で傾き補正]

    style B fill:#f99
    style C fill:#fff,stroke:#333
```

**問題点:** 赤いキューブが自転すると、その回転が白いキューブの自転軸に影響を与えてしまう

**変更後:**
```mermaid
graph TD
    A[origin] --> B[redOrbitContainer]
    B --> C[cubeEntity 赤]
    B --> D[whiteOrbitContainer]
    D --> E[whiteCubeEntity 白]

    B -.-> B1[OrbitComponent<br/>半径5m, 周期10秒]

    C -.-> C1[RotationComponent<br/>Y軸, 周期1秒]
    C -.-> C2[傾き 30°]

    D -.-> D1[OrbitComponent<br/>半径2m, 周期2秒]

    E -.-> E1[RotationComponent<br/>Y軸, 周期1秒]
    E -.-> E2[傾き 5°]

    style C fill:#f99
    style E fill:#fff,stroke:#333
    style B fill:#fcc,stroke:#999,stroke-dasharray: 5 5
    style D fill:#eee,stroke:#999,stroke-dasharray: 5 5
```

**解決:** 公転用Containerを追加することで、公転と自転が完全に分離される

### コードの変更内容

1. **赤いキューブのセットアップ**
   - `redOrbitContainer` Entityを作成
   - OrbitComponentをContainerに適用
   - RotationComponentと傾きはキューブ本体に適用

2. **白いキューブのセットアップ**
   - `whiteOrbitContainer` Entityを作成
   - OrbitComponentをContainerに適用
   - RotationComponentと傾きはキューブ本体に適用
   - 親の回転を相殺する逆回転行列の計算を削除（不要になった）

3. **パラメータ調整**
   - 赤いキューブの自転周期: 5秒 → 1秒
   - 白いキューブの公転周期: 10秒 → 2秒
   - 白いキューブの傾き: -30° → 5°

## 副作用
- なし（既存のOrbitSystemとRotationSystemはそのまま動作）

## 関連ファイル
- `/Users/taat/git/SolarSystemClaudeCode/SolarSystemClaudeCode/ImmersiveView.swift`

## コミット
- コミットID: 4b8c06b
- ブランチ: feature/satellite
- メッセージ: "Separate orbit and rotation using container entities"
