# BuildAndRun.md

## 変数
- プロジェクト名: `SolarSystemClaudeCode.xcodeproj`
- スキーム名: `SolarSystemClaudeCode`
- Bundle ID: `com.TAATHub.SolarSystemClaudeCode`
- アプリ名: `SolarSystemClaudeCode.app`
- Platform: `visionOS`

## 対象デバイスIDの取得

実機とシミュレータのデバイスIDは異なるため、それぞれ以下のコマンドで取得する

- 実機の場合
    - `xcrun devicectl list devices`で`connected`状態のデバイスを取得
        - `available (paired)`ではない
- シミュレータの場合
    - `xcrun simctl list devices`で`Booted`状態のデバイスを取得
        - `Shutdown`状態のデバイスしかない場合は、最新のiOSバージョンのデバイスを取得

## ビルド

**実機を優先**して、`xcodebuild`コマンドでビルドを行う

ただし、`-destination`で指定するデバイスIDは、`xcrun`で取得した対象デバイス名をもとに、`-showdestinations`で再取得して指定すること

`xcodebuild -project '${プロジェクト名}$' -scheme '${スキーム名}' -showdestinations`

### 実機の場合

`xcodebuild -project '${プロジェクト名}$' -scheme '${スキーム名}' -destination 'platform=${Platform},id=${実機のデバイスID}'`

### シミュレータの場合

`xcodebuild -project '${プロジェクト名}$' -scheme '${スキーム名}' -destination 'platform=${Platform} Simulator,id=${シミュレータのデバイスID}'`

## インストール

ビルド成功後、アプリを対象デバイスにインストールする

### 実機の場合

`xcrun devicectl device install app --device '${実機のデバイスID}' '${アプリ名へのパス}'`

### シミュレータの場合

シミュレータが未起動の場合、`xcrun simctl boot シミュレータのデバイスID`でシミュレータを起動してからインストールを行う

`xcrun simctl install '${シミュレータのデバイスID}' '${アプリ名へのパス}'`

## 実行

### 実機の場合

`xcrun devicectl device process launch --device '${実機のデバイスID}' '${Bundle ID}'`

### シミュレータの場合

`xcrun simctl launch '${シミュレータのデバイスID}' '${Bundle ID}'`