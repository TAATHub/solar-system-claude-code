# RealityKit Development Rules

## ECS (Entity Component System) について

## System の実装
- RealityKitのSystemは`System`プロトコルに準拠する
- 必須メソッド:
  - `init(scene: RealityKit.Scene)`
  - `func update(context: SceneUpdateContext)`
- EntityQueryは静的プロパティとして定義: `static let query = EntityQuery(where: .has(ComponentType.self))`

## System の登録
- Systemの登録は`SystemType.registerSystem()`を使用する
- RealityKit.Systemに標準で用意されているメソッドを使用
- カスタムのregisterSystemメソッドは作成しない

## エンティティの取得
- Systemのupdate内でエンティティを取得する際は`context.entities(matching: query, updatingSystemWhen: .rendering)`を使用
- `context.scene.performQuery()`は使用しない（古いAPI）
- `updatingSystemWhen: .rendering`パラメータでレンダリング時の更新を指定

## Component の実装
- Componentは`Component`プロトコルに準拠する構造体として実装
- データの格納とパラメータの初期化を担当
- Systemがロジックを処理し、Componentがデータを保持する役割分担を明確にする

## RealityKit コード例

```swift
// Component
struct OrbitComponent: Component {
    let radius: Float
    let angularVelocity: Float
    var currentAngle: Float
    
    init(radius: Float, angularVelocity: Float) {
        self.radius = radius
        self.angularVelocity = angularVelocity
        self.currentAngle = 0.0
    }
}

// System
struct OrbitSystem: System {
    static let query = EntityQuery(where: .has(OrbitComponent.self))
    
    init(scene: RealityKit.Scene) {}
    
    func update(context: SceneUpdateContext) {
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
            guard var orbitComponent = entity.components[OrbitComponent.self] else { continue }
            
            // Update orbital position
            orbitComponent.currentAngle += orbitComponent.angularVelocity * Float(context.deltaTime)
            
            let x = cos(orbitComponent.currentAngle) * orbitComponent.radius
            let z = sin(orbitComponent.currentAngle) * orbitComponent.radius
            entity.position = SIMD3<Float>(x, 0, z)
            
            // Update component
            entity.components[OrbitComponent.self] = orbitComponent
        }
    }
}

// System登録例
OrbitSystem.registerSystem()
```