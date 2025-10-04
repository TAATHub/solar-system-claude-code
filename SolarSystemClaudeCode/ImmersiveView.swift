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

            // サイズ1.0の赤いキューブを作成
            let cubeMesh = MeshResource.generateBox(size: 1.0)
            let redMaterial = SimpleMaterial(color: .red, isMetallic: false)
            let cubeEntity = ModelEntity(mesh: cubeMesh, materials: [redMaterial])

            // 半径1mの位置に配置（X軸方向）
            cubeEntity.transform.translation = SIMD3<Float>(1, 0, 0)

            // OrbitComponentを追加（半径1m、周期10秒、Y軸まわり）
            cubeEntity.components.set(OrbitComponent(radius: 1.0, period: 10.0, axis: [0, 1, 0]))

            // RotationComponentを追加（垂直方向から30°傾けた軸で自転、周期5秒）
            // 垂直方向（Y軸）から30°傾けた軸を計算
            let tiltAngle = Float(30.0 * .pi / 180.0) // 30度をラジアンに変換
            let rotationAxis = SIMD3<Float>(sin(tiltAngle), cos(tiltAngle), 0)
            cubeEntity.components.set(RotationComponent(axis: rotationAxis, period: 5.0))

            origin.addChild(cubeEntity)
        }
    }
}

#Preview(immersionStyle: .mixed) {
    ImmersiveView()
        .environment(AppModel())
}
