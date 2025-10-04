//
//  RotationComponent.swift
//  SolarSystemClaudeCode
//
//  Component for rotation motion
//

import RealityKit

struct RotationComponent: Component {
    /// 回転軸
    let axis: SIMD3<Float>
    /// 角速度（ラジアン/秒）
    let angularVelocity: Float

    init(axis: SIMD3<Float>, period: Double) {
        self.axis = normalize(axis)
        // 周期から角速度を計算（1周 = 2π rad）
        self.angularVelocity = Float(2.0 * .pi / period)
    }
}
