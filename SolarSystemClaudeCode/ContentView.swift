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
            Model3D(named: "Scene", bundle: realityKitContentBundle)
                .padding(.bottom, 50)

            if let name = appModel.selectedCelestialBodyName,
               let description = appModel.selectedCelestialBodyDescription {
                VStack(spacing: 16) {
                    Text(name)
                        .font(.title)
                        .bold()
                    Text(description)
                        .font(.body)
                }
                .padding()
                .background(.regularMaterial)
                .cornerRadius(8)
            }

            ToggleImmersiveSpaceButton()

            Button("Open Volume") {
                openWindow(id: "SolarSystemVolume")
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
