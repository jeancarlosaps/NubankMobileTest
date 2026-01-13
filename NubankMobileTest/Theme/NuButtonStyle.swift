//
//  NuButtonStyle.swift
//  NubankMobileTest
//
//  Created by Jean Carlos on 30/11/25.
//

import SwiftUI

struct NuButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.horizontal, 18)
            .padding(.vertical, 12)
            .background(Color.nuPurple)
            .foregroundColor(.white)
            .cornerRadius(12)
            .opacity(configuration.isPressed ? 0.7 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}
