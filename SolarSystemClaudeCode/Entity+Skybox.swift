//
//  Entity+Skybox.swift
//  SolarSystemClaudeCode
//
//  Created by TAAT on 2025/10/09.
//

import RealityKit

extension Entity {
    /// Skyboxエンティティを生成します
    /// - Parameters:
    ///   - textureName: Asset Catalogに登録されたテクスチャ名
    ///   - radius: Skyboxの半径（デフォルト: 1000）
    /// - Returns: 生成されたSkyboxエンティティ。テクスチャの読み込みに失敗した場合はnil
    static func createSkybox(textureName: String, radius: Float = 1000) async -> Entity? {
        guard let texture = try? await TextureResource(named: textureName) else {
            print("Skyboxテクスチャ '\(textureName)' の読み込みに失敗しました")
            return nil
        }

        var material = UnlitMaterial()
        material.color = .init(texture: .init(texture))

        let mesh = MeshResource.generateSphere(radius: radius)
        let skyboxEntity = ModelEntity(mesh: mesh, materials: [material])

        // 内側から見えるようにX軸を反転
        skyboxEntity.scale *= .init(x: -1, y: 1, z: 1)

        return skyboxEntity
    }
}
