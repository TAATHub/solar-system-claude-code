//
//  SolarSystemBuilder.swift
//  SolarSystemClaudeCode
//
//  太陽系の構築ロジックを共通化
//

import SwiftUI
import RealityKit
import RealityKitContent

@MainActor
struct SolarSystemBuilder {
    /// 太陽系を構築してRealityViewContentに追加する
    /// - Parameters:
    ///   - content: RealityViewのcontent
    ///   - scale: 全体のスケール（デフォルト: 0.05）
    ///   - position: 原点の位置（デフォルト: [0, 1, 0]）
    ///   - includeSkybox: Skyboxを含めるか（デフォルト: true）
    ///   - includeBGM: BGMを含めるか（デフォルト: true）
    static func build(
        in content: RealityViewContent,
        scale: Float = 0.05,
        position: SIMD3<Float> = [0, 1, 0],
        includeSkybox: Bool = true,
        includeBGM: Bool = true
    ) async {
        // Skyboxの設定
        if includeSkybox, let skybox = await Entity.createSkybox(textureName: "MilkyWay") {
            content.add(skybox)
        }

        // 原点に基準エンティティを配置
        let origin = Entity()
        content.add(origin)

        origin.position = position
        origin.scale *= scale

        // SolarSystemシーンを読み込む
        guard let solarSystemScene = try? await Entity(named: "SolarSystem", in: realityKitContentBundle) else {
            print("SolarSystemシーンの読み込みに失敗しました")
            return
        }

        // === 天体のセットアップ ===
        // Sun
        _ = await CelestialBodyFactory.addCelestialBody(
            model: CelestialBodyData.sun,
            to: origin,
            fromScene: solarSystemScene
        )
        // Mercury
        _ = await CelestialBodyFactory.addCelestialBody(
            model: CelestialBodyData.mercury,
            to: origin,
            fromScene: solarSystemScene
        )

        // Venus
        _ = await CelestialBodyFactory.addCelestialBody(
            model: CelestialBodyData.venus,
            to: origin,
            fromScene: solarSystemScene
        )

        // Earth
        guard let (earthOrbitContainer, _) = await CelestialBodyFactory.addCelestialBody(
            model: CelestialBodyData.earth,
            to: origin,
            fromScene: solarSystemScene
        ) else { return }

        // Moon（地球の子として配置）
        _ = await CelestialBodyFactory.addCelestialBody(
            model: CelestialBodyData.moon,
            to: earthOrbitContainer,
            fromScene: solarSystemScene
        )

        // Mars
        _ = await CelestialBodyFactory.addCelestialBody(
            model: CelestialBodyData.mars,
            to: origin,
            fromScene: solarSystemScene
        )

        // Jupiter
        _ = await CelestialBodyFactory.addCelestialBody(
            model: CelestialBodyData.jupiter,
            to: origin,
            fromScene: solarSystemScene
        )

        // Saturn
        _ = await CelestialBodyFactory.addCelestialBody(
            model: CelestialBodyData.saturn,
            to: origin,
            fromScene: solarSystemScene
        )

        // Uranus
        _ = await CelestialBodyFactory.addCelestialBody(
            model: CelestialBodyData.uranus,
            to: origin,
            fromScene: solarSystemScene
        )

        // Neptune
        _ = await CelestialBodyFactory.addCelestialBody(
            model: CelestialBodyData.neptune,
            to: origin,
            fromScene: solarSystemScene
        )

        // BGMの設定
        if includeBGM {
            do {
                let audioResource = try await AudioFileResource(
                    named: "BGM.mp3",
                    configuration: .init(shouldLoop: true)
                )
                let bgmEntity = Entity()
                
                var component = AmbientAudioComponent()
                component.gain = 0.1
                
                bgmEntity.components.set(component)
                content.add(bgmEntity)

                bgmEntity.prepareAudio(audioResource).play()
            } catch {
                print("BGMの読み込みに失敗しました: \(error)")
            }
        }
    }
}
