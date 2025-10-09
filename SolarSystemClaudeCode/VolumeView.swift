//
//  VolumeView.swift
//  SolarSystemClaudeCode
//
//  Volume表示用のView
//

import SwiftUI
import RealityKit

struct VolumeView: View {
    @Environment(AppModel.self) private var appModel

    init() {
        // Systemの登録は一度だけ実行されるようにinitで行う
        OrbitSystem.registerSystem()
        RotationSystem.registerSystem()
    }

    var body: some View {
        RealityView { content, attachments in
            await SolarSystemBuilder.build(
                in: content,
                scale: 0.01,
                position: [0, -0.15, 0],
                includeSkybox: false,
                includeBGM: false
            )
        } update: { content, attachments in
            // Attachment用のEntityを探す
            if let infoPanel = content.entities.first(where: { $0.name == "InfoPanel" }) {
                // 既存のパネルを削除
                infoPanel.removeFromParent()
            }

            // 選択された天体がある場合、新しいパネルを追加
            if appModel.selectedCelestialBodyName != nil,
               let attachmentEntity = attachments.entity(for: "info") {
                attachmentEntity.name = "InfoPanel"
                attachmentEntity.position = [0, 0, 0]
                content.add(attachmentEntity)
            }
        } attachments: {
            if let name = appModel.selectedCelestialBodyName,
               let description = appModel.selectedCelestialBodyDescription {
                Attachment(id: "info") {
                    VStack(spacing: 8) {
                        Text(name)
                            .font(.callout)
                            .bold()
                        Text(description)
                            .font(.caption)
                    }
                    .padding()
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .frame(maxWidth: 360)
                }
            }
        }
        .gesture(
            SpatialTapGesture()
                .targetedToAnyEntity()
                .onEnded { value in
                    // タップされたEntityから天体情報を取得
                    if let info = value.entity.components[CelestialBodyInfoComponent.self] {
                        // 同じ天体をタップした場合は非表示にする
                        if appModel.selectedCelestialBodyName == info.name {
                            appModel.selectedCelestialBodyName = nil
                            appModel.selectedCelestialBodyDescription = nil
                        } else {
                            appModel.selectedCelestialBodyName = info.name
                            appModel.selectedCelestialBodyDescription = info.description
                        }
                    }
                }
        )
    }
}

#Preview {
    VolumeView()
        .environment(AppModel())
}
