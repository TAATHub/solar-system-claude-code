//
//  VolumeView.swift
//  SolarSystemClaudeCode
//
//  Volume表示用のView
//

import SwiftUI
import RealityKit

struct VolumeView: View {
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
                scale: 0.01,
                position: [0, -0.3, 0],
                includeSkybox: false,
                includeBGM: false
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

#Preview {
    VolumeView()
        .environment(AppModel())
}
