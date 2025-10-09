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
            await SolarSystemBuilder.build(
                in: content,
                scale: 0.1,
                position: [0, 1, 0],
                includeSkybox: true,
                includeBGM: true
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
