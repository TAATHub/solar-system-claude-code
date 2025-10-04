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
    @State private var startTime = Date()

    var body: some View {
        TimelineView(.animation) { context in
            let elapsed = context.date.timeIntervalSince(startTime)

            // 10秒で1周 (角速度 = 2π / 10)
            let angularVelocity = 2.0 * .pi / 10.0
            let angle = Float(elapsed * angularVelocity)

            // 半径1の円周運動
            let radius: Float = 1.0
            let x = radius * cos(angle)
            let z = radius * sin(angle)

            RealityView { content in
                // Add the initial RealityKit content
                if let immersiveContentEntity = try? await Entity(named: "Immersive", in: realityKitContentBundle) {
                    content.add(immersiveContentEntity)

                    // Put skybox here.  See example in World project available at
                    // https://developer.apple.com/
                }

                // サイズ1.0の赤い球体を作成
                let sphereMesh = MeshResource.generateSphere(radius: 0.5)
                let redMaterial = SimpleMaterial(color: .red, isMetallic: false)
                let sphereEntity = ModelEntity(mesh: sphereMesh, materials: [redMaterial])
                sphereEntity.name = "redSphere"

                content.add(sphereEntity)
            } update: { content in
                // 球体の位置を更新
                if let sphereEntity = content.entities.first(where: { $0.name == "redSphere" }) {
                    sphereEntity.position = [x, 0, z]
                }
            }
        }
    }
}

#Preview(immersionStyle: .mixed) {
    ImmersiveView()
        .environment(AppModel())
}
