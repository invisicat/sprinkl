//
//  OverlayPicker.swift
//  Sprinkl
//
//  Created by Andy Lyek on 5/18/25.
//

import SwiftUI

public struct OverlayPicker<Data, Content> : View where Data: Hashable, Content: View {
    public let sources: [Data]
    public let selected: Data?
    public let itemBuilder: (Data) -> Content
    
    @State private var backgroundColor: Color = Color.black.opacity(0.05)
    
    func pickerBackgroundColor(_ color: Color) -> OverlayPicker {
        var view = self
        view._backgroundColor = State(initialValue: color)
        return view
    }
    
    @State private var cornerRadius: CGFloat?
    
    func cornerRadius(_ cornerRadius: CGFloat) -> OverlayPicker {
        var view = self
        view._cornerRadius = State(initialValue: cornerRadius)
        return view
    }
    
    @State private var borderColor: Color?
    
    func borderColor(_ borderColor: Color) -> OverlayPicker {
        var view = self
        view._borderColor = State(initialValue: borderColor)
        return view
    }
    
    @State private var borderWidth: CGFloat?
    
    func borderWidth(_ borderWidth: CGFloat) -> OverlayPicker {
        var view = self
        view._borderWidth = State(initialValue: borderWidth)
        return view
    }
    
    private var customIndicator: AnyView? = nil
    
    public init(
        _ sources: [Data],
        selection: Data?,
        indicatorBuilder: @escaping () -> some View,
        @ViewBuilder itemBuilder: @escaping (Data) -> Content
    ) {
        self.sources = sources
        self.selected = selection
        self.itemBuilder = itemBuilder
        self.customIndicator = AnyView(indicatorBuilder())
    }
    
    public init(
        _ sources: [Data],
        selection: Data?,
        @ViewBuilder itemBuilder: @escaping (Data) -> Content
    ) {
        self.sources = sources
        self.selected = selection
        self.itemBuilder = itemBuilder
    }
    
    public var body: some View {
        ZStack(alignment: .center) {
            if let selection = selected, let selectedIdx = sources.firstIndex(of: selection) {
                if let customIndicator = customIndicator {
                    customIndicator
                } else {
                    GeometryReader { geo in
                        RoundedRectangle(cornerRadius: cornerRadius ?? 6.0)
                            .foregroundColor(.accentColor)
                            .padding(EdgeInsets(top: borderWidth ?? 2, leading: borderWidth ?? 2, bottom: borderWidth ?? 2, trailing: borderWidth ?? 2))
                            .frame(width: geo.size.width / CGFloat(sources.count))
                            .shadow(color: .black.opacity(0.1), radius: 2, x: 1, y: 1)
                            .animation(.spring().speed(1.5))
                            .offset(x: geo.size.width / CGFloat(sources.count) * CGFloat(selectedIdx), y: 0)
                    }.frame(height: 32)
                }
            }
            
            HStack(spacing: 0) {
                ForEach(sources, id: \.self) { item in
                    itemBuilder(item)
                }
            }
        }
        .background(
            RoundedRectangle(cornerRadius: cornerRadius ?? 6.0)
                .fill(
                    backgroundColor,
                )
        )
    }
}

