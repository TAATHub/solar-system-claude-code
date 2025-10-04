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
            origin.addChild(sphereEntity)

            // 原点まわりにY軸で10秒/周の軌道アニメーション
            let orbit = OrbitAnimation(
                duration: 10.0,                     // 1周 = 10秒
                axis: [0, 1, 0],                    // Y軸まわり
                startTransform: sphereEntity.transform,
                bindTarget: .transform,
                repeatMode: .repeat                 // 無限ループ
            )

            if let animationResource = try? AnimationResource.generate(with: orbit) {
                sphereEntity.playAnimation(animationResource)
            }
        }
    }
}

#Preview(immersionStyle: .mixed) {
    ImmersiveView()
        .environment(AppModel())
}
