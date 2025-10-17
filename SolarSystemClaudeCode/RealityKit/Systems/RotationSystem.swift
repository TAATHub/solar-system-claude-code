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

            // 回転軸に対して相対的に回転を適用
            let rotation = simd_quatf(
                angle: rotationComponent.angularVelocity * Float(context.deltaTime),
                axis: rotationComponent.axis
            )
            entity.setOrientation(rotation, relativeTo: entity)
        }
    }
}
