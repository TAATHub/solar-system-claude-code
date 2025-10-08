//
//  AppModel.swift
//  SolarSystemClaudeCode
//
//  Created by TAAT on 2025/10/03.
//

import SwiftUI

/// Maintains app-wide state
@MainActor
@Observable
class AppModel {
    let immersiveSpaceID = "ImmersiveSpace"
    enum ImmersiveSpaceState {
        case closed
        case inTransition
        case open
    }
    var immersiveSpaceState = ImmersiveSpaceState.closed

    /// 選択された天体の情報
    var selectedCelestialBodyName: String?
    var selectedCelestialBodyDescription: String?
}
