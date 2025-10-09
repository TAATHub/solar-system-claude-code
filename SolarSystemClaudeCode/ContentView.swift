//
//  ContentView.swift
//  SolarSystemClaudeCode
//
//  Created by TAAT on 2025/10/03.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ContentView: View {
    @Environment(AppModel.self) private var appModel
    @Environment(\.openWindow) private var openWindow

    var body: some View {
        VStack(spacing: 40) {
            Text("Solar System")
                .font(.largeTitle)
                .bold()

            Text("没入空間で宇宙の広がりを感じたり、\nボリュームで手元に置いたり。\nあなたの好きなスタイルで太陽系シミュレーションを楽しめます。\n気になる天体をタッチすれば、詳しい説明も見られます。")
                .font(.body)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)

            VStack(spacing: 16) {   
                ToggleImmersiveSpaceButton()
                
                Button("Show Volume") {
                    openWindow(id: "SolarSystemVolume")
                }
                .disabled(appModel.immersiveSpaceState != .closed)
            }
        }
        .padding()
        .frame(width: 640, height: 640)
    }
}

#Preview(windowStyle: .automatic) {
    ContentView()
        .environment(AppModel())
}
