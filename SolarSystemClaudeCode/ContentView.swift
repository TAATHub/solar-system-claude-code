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

    var body: some View {
        VStack {
            Model3D(named: "Scene", bundle: realityKitContentBundle)
                .padding(.bottom, 50)

            if let name = appModel.selectedCelestialBodyName,
               let description = appModel.selectedCelestialBodyDescription {
                VStack(spacing: 10) {
                    Text(name)
                        .font(.title)
                        .bold()
                    Text(description)
                        .font(.body)
                }
                .padding()
                .background(.regularMaterial)
                .cornerRadius(12)
            }

            ToggleImmersiveSpaceButton()
        }
        .padding()
    }
}

#Preview(windowStyle: .automatic) {
    ContentView()
        .environment(AppModel())
}
