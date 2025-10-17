# visionOS Window Management

## defaultWindowPlacement
- visionOSでウィンドウの配置を指定する際に使用
- `WindowGroup`に対して`.defaultWindowPlacement`モディファイアを適用
- クロージャの引数: `(content, context)`
  - `context.windows`で現在開いているウィンドウにアクセス可能
  - ウィンドウIDで特定のウィンドウを検索

## 配置オプション
- `.trailing(WindowProxy)` - 指定ウィンドウの右側に配置
- `.leading(WindowProxy)` - 指定ウィンドウの左側に配置
- `.below(WindowProxy)` - 指定ウィンドウの下に配置
- `.above(WindowProxy)` - 指定ウィンドウの上に配置
- `.utilityPanel` - ユーティリティパネルとして配置

## 実装例
```swift
.defaultWindowPlacement { content, context in
    if let targetWindow = context.windows.first(where: { $0.id == targetWindowID }) {
        return WindowPlacement(.trailing(targetWindow))
    }
    return WindowPlacement() // フォールバック
}
```