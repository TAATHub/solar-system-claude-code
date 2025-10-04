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

    var body: some View {
        RealityView { content in
            // OrbitSystemを登録
            OrbitSystem.registerSystem()

            // Add the initial RealityKit content
            if let immersiveContentEntity = try? await Entity(named: "Immersive", in: realityKitContentBundle) {
                content.add(immersiveContentEntity)

                // Put skybox here.  See example in World project available at
                // https://developer.apple.com/
            }

            // 原点に基準エンティティを配置
            let origin = Entity()
            content.add(origin)

            // サイズ1.0の赤い球体を作成
            let sphereMesh = MeshResource.generateSphere(radius: 0.5)
            let redMaterial = SimpleMaterial(color: .red, isMetallic: false)
            let sphereEntity = ModelEntity(mesh: sphereMesh, materials: [redMaterial])

            // 半径1mの位置に配置（X軸方向）
            sphereEntity.transform.translation = SIMD3<Float>(1, 0, 0)

            // OrbitComponentを追加（半径1m、周期10秒、Y軸まわり）
            sphereEntity.components.set(OrbitComponent(radius: 1.0, period: 10.0, axis: [0, 1, 0]))

            origin.addChild(sphereEntity)
        }
    }
}

#Preview(immersionStyle: .mixed) {
    ImmersiveView()
        .environment(AppModel())
}
