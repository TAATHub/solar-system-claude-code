//
//  View+Debug.swift
//  SolarSystemClaudeCode
//
//  Created by TAAT on 2025/10/09.
//

import SwiftUI

extension View {
    func debugBorder3D(_ color: Color, width: CGFloat) -> some View {
        spatialOverlay {
            ZStack {
                Color.clear.border(color, width: width)

                ZStack {
                    Color.clear.border(color, width: width)
                    Spacer()
                    Color.clear.border(color, width: width)
                }
                .rotation3DLayout(.degrees(90), axis: .y)

                Color.clear.border(color, width: width)
            }
        }
    }
}
