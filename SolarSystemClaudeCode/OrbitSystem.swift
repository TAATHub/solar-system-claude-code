//
//  OrbitSystem.swift
//  SolarSystemClaudeCode
//
//  System for orbital motion
//

import RealityKit

struct OrbitSystem: System {
    static let query = EntityQuery(where: .has(OrbitComponent.self))

    init(scene: RealityKit.Scene) {}

    func update(context: SceneUpdateContext) {
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
            guard var orbitComponent = entity.components[OrbitComponent.self] else { continue }

            // 角度を更新
            orbitComponent.currentAngle += orbitComponent.angularVelocity * Float(context.deltaTime)

            // 軌道上の位置を計算
            // Y軸まわりの回転の場合：X-Z平面上で円運動
            if orbitComponent.axis == SIMD3<Float>(0, 1, 0) {
                let x = cos(orbitComponent.currentAngle) * orbitComponent.radius
                let z = sin(orbitComponent.currentAngle) * orbitComponent.radius
                entity.position = SIMD3<Float>(x, 0, z)
            } else {
                // 他の軸の場合は回転行列を使用
                let rotationMatrix = simd_float3x3(
                    simd_quatf(angle: orbitComponent.currentAngle, axis: orbitComponent.axis)
                )
                let initialPosition = SIMD3<Float>(orbitComponent.radius, 0, 0)
                entity.position = rotationMatrix * initialPosition
            }

            // コンポーネントを更新
            entity.components[OrbitComponent.self] = orbitComponent
        }
    }
}
