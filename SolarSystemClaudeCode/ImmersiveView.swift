//
//  ImmersiveView.swift
//  SolarSystemClaudeCode
//
//  Created by TAAT on 2025/10/03.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ImmersiveView: View {
    @Environment(AppModel.self) private var appModel

    init() {
        // Systemの登録は一度だけ実行されるようにinitで行う
        OrbitSystem.registerSystem()
        RotationSystem.registerSystem()
    }

    var body: some View {
        RealityView { content in
            // 原点に基準エンティティを配置
            let origin = Entity()
            content.add(origin)

            origin.position = [0, 1, 0]
            origin.scale *= 0.01

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
        }
        .gesture(
            SpatialTapGesture()
                .targetedToAnyEntity()
                .onEnded { value in
                    // タップされたEntityから天体情報を取得
                    if let info = value.entity.components[CelestialBodyInfoComponent.self] {
                        appModel.selectedCelestialBodyName = info.name
                        appModel.selectedCelestialBodyDescription = info.description
                    }
                }
        )
    }
}

#Preview(immersionStyle: .mixed) {
    ImmersiveView()
        .environment(AppModel())
}
