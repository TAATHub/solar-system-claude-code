# RealityKit ECS（visionOS 26.0）Swiftコーディングガイド

## RealityKitにおけるECSの基本概念

RealityKitでは**Entity-Component-System (ECS)**アーキテクチャが採用されており、アプリ内のオブジェクトを3つの要素に分離して扱います。各要素の役割は以下のとおりです。

- **Entity（エンティティ）** – 3D空間上に配置するオブジェクトを表すコンテナです。自身はデータや振る舞いを持たず、**識別子**・**親子構造**として機能し、複数のComponentをまとめます。
- **Component（コンポーネント）** – Entityに付与できる属性や機能を表すデータです。**見た目（モデルやマテリアル）**や**物理特性**、**動作パラメータ**などを定義します。
- **System（システム）** – 複数のEntityにまたがる共通の振る舞いを定義します。各フレームで実行され、シーン内の特定条件を満たすEntityを検索して更新します。

これらにより、RealityKitではオブジェクトのデータとロジックを分離して再利用性や拡張性を高めています。

## Entityの作成と階層構造

```swift
let anchor = AnchorEntity(world: .zero)
scene.addAnchor(anchor)

let sphereEntity = Entity()
sphereEntity.name = "Sphere"
anchor.addChild(sphereEntity)
```

Entityは`addChild`や`setParent`で親子構造を持ち、Anchorに属して初めてシーンに存在できます。

```swift
let ball = Entity()
ball.components.set(ModelComponent(
    mesh: .generateSphere(radius: 0.1),
    materials: [SimpleMaterial(color: .red, isMetallic: false)]
))
ball.components.set(CollisionComponent(shapes: [.generateSphere(radius: 0.1)]))
ball.components.set(InputTargetComponent(allowedInputTypes: .all))
```

## Componentの定義と操作

カスタムコンポーネントは以下のように定義します：

```swift
public struct MovingComponent: Component, Codable {
    public var moveSpeed: Float = 0.1
    public init() { }
}
```

付与・更新例：

```swift
entity.components.set(MovingComponent())
if var comp = entity.components[MovingComponent.self] {
    comp.moveSpeed = 0.2
    entity.components[MovingComponent.self] = comp
}
```

## Systemの定義と登録

```swift
class MovingSystem: System {
    static let movingQuery = EntityQuery(where: .has(MovingComponent.self))

    required init(scene: Scene) {}

    func update(context: SceneUpdateContext) {
        for entity in context.scene.performQuery(Self.movingQuery) {
            guard let comp = entity.components[MovingComponent.self] else { continue }
            let speed = comp.moveSpeed
            let forward = entity.transform.matrix.columns.2.xyz
            entity.position += forward * speed
        }
    }
}
```

登録はアプリ起動時に行います：

```swift
@main
struct MyGameApp: App {
    init() {
        MovingComponent.registerComponent()
        MovingSystem.registerSystem()
    }
    var body: some Scene {
        ImmersiveSpace { ContentView() }
    }
}
```

## 現行バージョン（visionOS 26.0）のベストプラクティス

- **Component/Systemは必ず登録する**
- **update(context:)は軽量化する**
- **EntityQueryで対象を絞る**
- **Codableを使いReality Composer Pro対応にする**
- **Systemはステートレス設計**
- **パフォーマンスを考慮してO(n)処理にする**
- **デバッグにはRealityKit Debuggerを活用**

RealityKitのECSを活用することで、1フレームあたり1回のSystem呼び出しで多くのオブジェクトを効率的に制御でき、visionOSでの動的な空間アプリ構築を最適化できます。
