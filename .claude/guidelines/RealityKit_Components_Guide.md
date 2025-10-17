# RealityKitのAttachmentComponentとSwiftUI統合 (visionOS 26)

## AttachmentComponentとは何か (SwiftUIとの統合)
visionOS 26でRealityKitに追加された**AttachmentComponent**とは、SwiftUIのViewをRealityKitのエンティティ(Entity)に直接貼り付けるためのコンポーネントです。正式には**`ViewAttachmentComponent`**という型で、任意のSwiftUIビューをRealityKitのエンティティに結び付ける役割を持ちます。これにより、従来の`RealityView`初期化時にクロージャでアタッチメントを定義する方法に代わって、コード中の任意のタイミングでエンティティにSwiftUIビューを組み込めるようになりました。

```swift
let entity = Entity()
let attachment = ViewAttachmentComponent(rootView: MySwiftUIView())
entity.components.set(attachment)
content.add(entity)
```

このようにしてSwiftUIビューをRealityKit上に配置できます。

## コンテンツの空間配置（位置・回転・スケール・追従）
`ViewAttachmentComponent`を追加したエンティティは通常のエンティティ同様に位置・回転・スケールを操作可能です。

```swift
entity.position = [0, 1.0, -2.0]
entity.orientation = simd_quatf(angle: .pi/2, axis: [0,1,0])
entity.scale = [2.0, 2.0, 2.0]
```

親子関係を利用すると親エンティティに追従させることもできます。シーン直下に追加した場合は独立配置されます。

## 他のSwiftUI連携コンポーネント

### InputTargetComponent
RealityKitエンティティをタップやドラッグの対象にするためのコンポーネントです。`CollisionComponent`と併用します。

```swift
entity.components.set(InputTargetComponent(allowedInputTypes: .all))
entity.generateCollisionShapes(recursive: true)
```

### GestureComponent
SwiftUIの`Gesture`を直接RealityKitエンティティに関連付けるためのコンポーネントです。

```swift
let tapGesture = TapGesture().onEnded { print("Tapped!") }
entity.components.set(GestureComponent(tapGesture))
```

### PresentationComponent
RealityKitのエンティティからSwiftUIのポップオーバーなどを表示します。

```swift
let presentation = PresentationComponent(
    isPresented: $showingPopover,
    configuration: .popover(arrowEdge: .bottom),
    content: PopoverContentView()
)
entity.components.set(presentation)
```

### ImagePresentationComponent
2D画像や空間写真をRealityKit上で表示できるコンポーネントです。

```swift
let imageURL = URL(string: "photo.jpg")!
let imageComponent = try await ImagePresentationComponent(contentsOf: imageURL)
entity.components.set(imageComponent)
content.add(entity)
```

### PhysicsAttachmentComponent / AttachedTransformComponent
物理ジョイントやボーンなど、他エンティティのピンにエンティティを物理的に結合する機能を提供します。
アニメーションするスケルトンなどへの追従や、剛体同士の固定ジョイントに使用します。

## 制約とベストプラクティス
- `ViewAttachmentComponent`や`GestureComponent`はvisionOS 26以降で利用可能。
- インタラクティブなエンティティには必ず`CollisionComponent`と`InputTargetComponent`を付与。
- SwiftUIビューの物理サイズとフォントサイズを考慮し、視認性を確保。
- 動的UIは`ViewAttachmentComponent`を生成してシーンに追加・削除。
- ManipulationComponentでオブジェクトを動かす際はAttachmentエンティティが追従するよう設計。

## まとめ
visionOS 26では、RealityKitにおけるSwiftUI統合が大幅に進化しました。`ViewAttachmentComponent`をはじめとする新コンポーネントにより、SwiftUIで定義したUIを3D空間内のエンティティとして直接操作できるようになり、インタラクティブで没入感のある空間アプリを構築できます。
