//
//  Entity+Transform.swift
//  SolarSystemClaudeCode
//
//  Created by TAAT on 2025/10/08.
//

import RealityKit

extension Entity {
    /// Z-up座標系からY-up座標系に変換するための回転を適用
    ///
    /// RealityKitはY-up座標系を使用しますが、一部の3Dモデルは
    /// Z-up座標系で作成されています。このメソッドはX軸周りに
    /// -90度回転することで座標系を変換します。
    func applyZUpToYUpConversion() {
        transform.rotation = simd_quatf(angle: -.pi / 2, axis: [1, 0, 0])
    }
}
