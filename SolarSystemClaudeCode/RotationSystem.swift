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
            guard let rotationComponent = entity.components[RotationComponent.self] else { continue }

            // 現在の回転に追加の回転を適用
            let deltaRotation = simd_quatf(
                angle: rotationComponent.angularVelocity * Float(context.deltaTime),
                axis: rotationComponent.axis
            )
            entity.orientation = entity.orientation * deltaRotation
        }
    }
}
