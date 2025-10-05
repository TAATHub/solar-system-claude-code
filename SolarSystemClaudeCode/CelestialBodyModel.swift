//
//  CelestialBodyModel.swift
//  SolarSystemClaudeCode
//
//  Created by TAAT on 2025/10/05.
//

import SwiftUI
import RealityKit

/// 天体のパラメータを保持するモデル
struct CelestialBodyModel {
    let size: Float
    let color: UIColor
    let tiltAngle: Float // ラジアン
    let rotationAxis: SIMD3<Float>
    let rotationPeriod: Float
    let orbitRadius: Float?
    let orbitPeriod: Float?
    let orbitAxis: SIMD3<Float>

    init(
        size: Float,
        color: UIColor,
        tiltAngleDegrees: Float,
        rotationAxis: SIMD3<Float> = [0, 1, 0],
        rotationPeriod: Float,
        orbitRadius: Float? = nil,
        orbitPeriod: Float? = nil,
        orbitAxis: SIMD3<Float> = [0, 1, 0]
    ) {
        self.size = size
        self.color = color
        self.tiltAngle = tiltAngleDegrees * .pi / 180.0
        self.rotationAxis = rotationAxis
        self.rotationPeriod = rotationPeriod
        self.orbitRadius = orbitRadius
        self.orbitPeriod = orbitPeriod
        self.orbitAxis = orbitAxis
    }
}

/// 天体Entityを生成するファクトリークラス
class CelestialBodyFactory {

    /// 天体Entityを生成する
    static func createCelestialBody(from model: CelestialBodyModel) -> ModelEntity {
        let mesh = MeshResource.generateBox(size: model.size)
        let material = SimpleMaterial(color: model.color, isMetallic: false)
        let entity = ModelEntity(mesh: mesh, materials: [material])

        // 傾きの設定
        let tiltRotation = simd_quatf(angle: model.tiltAngle, axis: SIMD3<Float>(1, 0, 0))
        entity.transform.rotation = tiltRotation

        // 自転コンポーネントの追加
        entity.components.set(RotationComponent(axis: model.rotationAxis, period: Double(model.rotationPeriod)))

        return entity
    }

    /// 公転用コンテナEntityを生成する
    static func createOrbitContainer(radius: Float, period: Float, axis: SIMD3<Float>) -> Entity {
        let container = Entity()
        container.components.set(OrbitComponent(radius: radius, period: Double(period), axis: axis))
        return container
    }

    /// 天体とその公転コンテナを親に追加する
    static func addCelestialBody(
        model: CelestialBodyModel,
        to parent: Entity
    ) -> (container: Entity, body: ModelEntity) {
        let body = createCelestialBody(from: model)

        if let orbitRadius = model.orbitRadius, let orbitPeriod = model.orbitPeriod {
            let container = createOrbitContainer(radius: orbitRadius, period: orbitPeriod, axis: model.orbitAxis)
            parent.addChild(container)
            container.addChild(body)
            return (container, body)
        } else {
            parent.addChild(body)
            return (parent, body)
        }
    }
}
