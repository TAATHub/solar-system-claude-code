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
    @State private var selectedCelestialBodyName: String?
    @State private var selectedCelestialBodyDescription: String?

    init() {
        // Systemの登録は一度だけ実行されるようにinitで行う
        OrbitSystem.registerSystem()
        RotationSystem.registerSystem()
    }

    var body: some View {
        RealityView { content in
            await SolarSystemBuilder.build(
                in: content,
                scale: 0.01,
                position: [0, -0.15, 0],
                includeSkybox: false,
                includeBGM: false
            )
        } update: { content in
            // 既存のInfoPanelを削除
            if let infoPanel = content.entities.first(where: { $0.name == "InfoPanel" }) {
                infoPanel.removeFromParent()
            }

            // 選択された天体がある場合のみ、新しいパネルを作成
            guard let name = selectedCelestialBodyName,
                  let description = selectedCelestialBodyDescription else {
                return
            }

            let infoPanelEntity = Entity()
            infoPanelEntity.name = "InfoPanel"
            infoPanelEntity.position = [0, 0.3, 0]

            // ViewAttachmentComponentを使用してSwiftUIビューをアタッチ
            let infoView = VStack(spacing: 8) {
                Text(name)
                    .font(.callout)
                    .bold()
                Text(description)
                    .font(.caption)
            }
            .padding()
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .frame(width: 360, height: 180)

            let attachment = ViewAttachmentComponent(rootView: infoView)
            infoPanelEntity.components.set(attachment)
            infoPanelEntity.components.set(BillboardComponent())

            content.add(infoPanelEntity)
        }
        .gesture(
            SpatialTapGesture()
                .targetedToAnyEntity()
                .onEnded { value in
                    // タップされたEntityから天体情報を取得
                    if let info = value.entity.components[CelestialBodyInfoComponent.self] {
                        // 同じ天体をタップした場合は非表示にする
                        if selectedCelestialBodyName == info.name {
                            selectedCelestialBodyName = nil
                            selectedCelestialBodyDescription = nil
                        } else {
                            selectedCelestialBodyName = info.name
                            selectedCelestialBodyDescription = info.description
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
