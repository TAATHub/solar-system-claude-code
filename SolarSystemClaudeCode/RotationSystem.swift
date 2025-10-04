//
//  RotationSystem.swift
//  SolarSystemClaudeCode
//
//  System for rotation motion
//

import RealityKit

struct RotationSystem: System {
    static let query = EntityQuery(where: .has(RotationComponent.self))

    init(scene: RealityKit.Scene) {}

    func update(context: SceneUpdateContext) {
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
            guard var rotationComponent = entity.components[RotationComponent.self] else { continue }

            // 累積角度を更新
            rotationComponent.currentAngle += rotationComponent.angularVelocity * Float(context.deltaTime)

            // 固定された回転軸に対して絶対的な回転を適用
            entity.orientation = simd_quatf(
                angle: rotationComponent.currentAngle,
                axis: rotationComponent.axis
            )

            // コンポーネントを更新
            entity.components[RotationComponent.self] = rotationComponent
        }
    }
}
