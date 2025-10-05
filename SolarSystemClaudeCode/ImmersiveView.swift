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
    init() {
        // Systemの登録は一度だけ実行されるようにinitで行う
        OrbitSystem.registerSystem()
        RotationSystem.registerSystem()
    }

    var body: some View {
        RealityView { content in

            // Add the initial RealityKit content
            if let immersiveContentEntity = try? await Entity(named: "Immersive", in: realityKitContentBundle) {
                content.add(immersiveContentEntity)

                // Put skybox here.  See example in World project available at
                // https://developer.apple.com/
            }

            // 原点に基準エンティティを配置
            let origin = Entity()
            content.add(origin)

            // === 赤いキューブのセットアップ ===
            let redCubeModel = CelestialBodyModel(
                size: 1.0,
                color: .red,
                tiltAngleDegrees: 30.0,
                rotationPeriod: 1.0,
                orbitRadius: 5.0,
                orbitPeriod: 10.0
            )
            let (redOrbitContainer, _) = CelestialBodyFactory.addCelestialBody(
                model: redCubeModel,
                to: origin
            )

            // === 白いキューブのセットアップ ===
            let whiteCubeModel = CelestialBodyModel(
                size: 0.5,
                color: .white,
                tiltAngleDegrees: 5.0,
                rotationPeriod: 1.0,
                orbitRadius: 2.0,
                orbitPeriod: 2.0
            )
            _ = CelestialBodyFactory.addCelestialBody(
                model: whiteCubeModel,
                to: redOrbitContainer
            )
        }
    }
}

#Preview(immersionStyle: .mixed) {
    ImmersiveView()
        .environment(AppModel())
}
