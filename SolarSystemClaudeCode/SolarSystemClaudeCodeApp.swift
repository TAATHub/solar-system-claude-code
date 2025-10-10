//
//  SolarSystemClaudeCodeApp.swift
//  SolarSystemClaudeCode
//
//  Created by TAAT on 2025/10/03.
//

import SwiftUI

@main
struct SolarSystemClaudeCodeApp: App {

    @State private var appModel = AppModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(appModel)
        }
        .windowResizability(.contentSize)

        ImmersiveSpace(id: appModel.immersiveSpaceID) {
            ImmersiveView()
                .environment(appModel)
                .onAppear {
                    appModel.immersiveSpaceState = .open
                }
                .onDisappear {
                    appModel.immersiveSpaceState = .closed
                }
        }
        .immersionStyle(selection: .constant(.full), in: .full)
        
        WindowGroup(id: "SolarSystemVolume") {
            VolumeView()
                .environment(appModel)
                .frame(width: 600, height: 600)
                .frame(depth: 600)
        }
        .windowStyle(.volumetric)
        .windowResizability(.contentSize)
        .volumeWorldAlignment(.gravityAligned)
     }
}
