//
//  DarkButtonStyle.swift
//  Sprinkl
//
//  Created by Andy Lyek on 5/17/25.
//

import SwiftUI

struct DarkButtonStyle: ButtonStyle {
    @State var isHovering: Bool = false
    var hoverColor: Color = Color.cyan
    var defaultBackgroundColor: Color = Color.black
        .opacity(0.5)
    

    func makeBody(configuration: Configuration) -> some View {

        let currentBackgroundColor = isHovering ? hoverColor : defaultBackgroundColor

        configuration.label
            .foregroundColor(.white)
            .padding(8) // Add padding around the label content
            .background(currentBackgroundColor)
            .cornerRadius(8)
            .contentShape(Rectangle())
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.spring(response: 0.3, dampingFraction: 0.5), value: configuration.isPressed)            .animation(.easeInOut(duration: 0.2), value: isHovering)
            .onHover { hovering in
                isHovering = hovering
            }
    }
}


#Preview {
    VStack {
        Text("Buttons:").padding(30)
        Button(action: {
            print("Clicked")
        }, label: {
            Image(systemName: "light.min")
                .scaledToFit()
                .padding(4)
        })
            .font(.title)
            .buttonStyle(DarkButtonStyle(hoverColor: .cyan))

    }.padding(10)
}
