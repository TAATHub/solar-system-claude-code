//
//  OrbitComponent.swift
//  SolarSystemClaudeCode
//
//  Component for orbital motion
//

import RealityKit

struct OrbitComponent: Component {
    /// 軌道半径（メートル）
    let radius: Float
    /// 角速度（ラジアン/秒）
    let angularVelocity: Float
    /// 現在の角度（ラジアン）
    var currentAngle: Float
    /// 軌道の軸（デフォルトはY軸）
    let axis: SIMD3<Float>

    init(radius: Float, period: Double, axis: SIMD3<Float> = [0, 1, 0]) {
        self.radius = radius
        // 周期から角速度を計算（1周 = 2π rad、XZ平面では負の値で反時計回り）
        self.angularVelocity = -Float(2.0 * .pi / period)
        self.currentAngle = 0.0
        self.axis = normalize(axis)
    }
}
