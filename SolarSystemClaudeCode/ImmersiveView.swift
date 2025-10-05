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

            // y軸から30°傾けた回転を設定
            let tiltAngle = Float(30.0 * .pi / 180.0)
            let tiltRotation = simd_quatf(angle: tiltAngle, axis: SIMD3<Float>(1, 0, 0))
            cubeEntity.transform.rotation = tiltRotation

            // OrbitComponentを追加（半径5m、周期5秒、Y軸まわり）
            cubeEntity.components.set(OrbitComponent(radius: 5.0, period: 10.0, axis: [0, 1, 0]))

            // RotationComponentを追加（y軸方向で自転、周期1秒）
            cubeEntity.components.set(RotationComponent(axis: [0, 1, 0], period: 1.0))

            origin.addChild(cubeEntity)

            // サイズ0.5の白いキューブを作成
            let whiteCubeMesh = MeshResource.generateBox(size: 0.5)
            let whiteMaterial = SimpleMaterial(color: .white, isMetallic: false)
            let whiteCubeEntity = ModelEntity(mesh: whiteCubeMesh, materials: [whiteMaterial])

            // y軸から30°傾けた回転を設定
           let whiteTiltAngle = Float(30.0 * .pi / 180.0)
           let whiteTiltRotation = simd_quatf(angle: whiteTiltAngle, axis: SIMD3<Float>(1, 0, 0))
           whiteCubeEntity.transform.rotation = whiteTiltRotation

            // OrbitComponentを追加（半径2.0m、周期1.0秒、Y軸まわり）
            whiteCubeEntity.components.set(OrbitComponent(radius: 2.0, period: 10.0, axis: [0, 1, 0]))

            // RotationComponentを追加（y軸方向で自転、周期1.0秒）
            whiteCubeEntity.components.set(RotationComponent(axis: [0, 1, 0], period: 1.0))

            cubeEntity.addChild(whiteCubeEntity)
        }
    }
}

#Preview(immersionStyle: .mixed) {
    ImmersiveView()
        .environment(AppModel())
}
