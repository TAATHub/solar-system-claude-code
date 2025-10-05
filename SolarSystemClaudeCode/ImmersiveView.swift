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
            // 原点に基準エンティティを配置
            let origin = Entity()
            content.add(origin)

            if let sun = try? await Entity(named: "Sun", in: realityKitContentBundle) {
                origin.addChild(sun)
            }
            
            // === Earthのセットアップ ===
            let earthModel = CelestialBodyModel(
                modelName: "Earth",
                size: 0.3,                // 視認性を重視したサイズ
                tiltAngleDegrees: 23.44,  // 地軸の傾き
                rotationPeriod: 1.0,      // 1日で自転（視認性のため実時間スケール）
                orbitRadius: 5.0,         // 視認性のため圧縮
                orbitPeriod: 10.0         // 視認性のため圧縮
            )
            guard let (earthOrbitContainer, _) = await CelestialBodyFactory.addCelestialBody(
                model: earthModel,
                to: origin
            ) else { return }

            // === Moonのセットアップ ===
            let moonModel = CelestialBodyModel(
                modelName: "Moon",
                size: 0.1,                // 視認性を重視したサイズ(Earthの約1/3)
                tiltAngleDegrees: 1.54,   // 月の自転軸傾き
                rotationPeriod: 2.0,      // 潮汐ロック（公転周期と同じ）
                orbitRadius: 2.0,         // 地球からの距離（視認性のため圧縮）
                orbitPeriod: 2.0          // 約27日（視認性のため圧縮）
            )
            _ = await CelestialBodyFactory.addCelestialBody(
                model: moonModel,
                to: earthOrbitContainer
            )
        }
    }
}

#Preview(immersionStyle: .mixed) {
    ImmersiveView()
        .environment(AppModel())
}
