//
//  CelestialBodyModel.swift
//  SolarSystemClaudeCode
//
//  Created by TAAT on 2025/10/05.
//

import SwiftUI
import RealityKit
import RealityKitContent

/// 天体のパラメータを保持するモデル
struct CelestialBodyModel {
    let modelName: String
    let size: Float  // Sun = 1.0基準のサイズ
    let tiltAngle: Float // ラジアン
    let rotationAxis: SIMD3<Float>
    let rotationPeriod: Float
    let orbitRadius: Float?
    let orbitPeriod: Float?
    let orbitAxis: SIMD3<Float>

    init(
        modelName: String,
        size: Float = 1.0,
        tiltAngleDegrees: Float,
        rotationAxis: SIMD3<Float> = [0, 1, 0],
        rotationPeriod: Float,
        orbitRadius: Float? = nil,
        orbitPeriod: Float? = nil,
        orbitAxis: SIMD3<Float> = [0, 1, 0]
    ) {
        self.modelName = modelName
        self.size = size
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

    /// RealityKitバンドルから天体Entityを読み込んでセットアップする
    static func addCelestialBody(
        model: CelestialBodyModel,
        to parent: Entity
    ) async -> (orbitContainer: Entity, rotationContainer: Entity)? {
        // RealityKitバンドルからモデルを読み込む
        guard let celestialBody = try? await Entity(named: model.modelName, in: realityKitContentBundle) else {
            print("Failed to load model: \(model.modelName)")
            return nil
        }

        // サイズを設定（Sun = 1.0基準）
        celestialBody.scale = SIMD3<Float>(repeating: model.size)

        // 公転用コンテナ
        let orbitContainer = Entity()
        parent.addChild(orbitContainer)

        // 自転用コンテナ
        let rotationContainer = Entity()
        orbitContainer.addChild(rotationContainer)
        rotationContainer.addChild(celestialBody)

        // 自転軸の傾きを設定
        rotationContainer.orientation = simd_quatf(angle: model.tiltAngle, axis: [0, 0, 1])

        // 公転コンポーネント
        if let orbitRadius = model.orbitRadius, let orbitPeriod = model.orbitPeriod {
            orbitContainer.components[OrbitComponent.self] = OrbitComponent(
                radius: orbitRadius,
                period: Double(orbitPeriod),
                axis: model.orbitAxis
            )
        }

        // 自転コンポーネント
        rotationContainer.components[RotationComponent.self] = RotationComponent(
            axis: model.rotationAxis,
            period: Double(model.rotationPeriod)
        )

        return (orbitContainer, rotationContainer)
    }
}
