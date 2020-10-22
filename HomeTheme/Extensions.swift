//
//  Extensions.swift
//  HomeTheme
//
//  Created by Trent Guillory on 10/14/20.
//

import SwiftUI

public extension Color {
    static var background: Color {
        #if os(macOS)
        return Color(NSColor.windowBackgroundColor)
        #else
        return Color(UIColor.systemBackground)
        #endif
    }

    static var foreground: Color {
        #if os(macOS)
        return Color(NSColor.label)
        #else
        return Color(UIColor.label)
        #endif
    }

    static var secondaryBackground: Color {
        #if os(macOS)
        return Color(NSColor.underPageBackgroundColor)
        #else
        return Color(UIColor.secondarySystemBackground)
        #endif
    }

    static var tertiaryBackground: Color {
        #if os(macOS)
        return Color(NSColor.controlBackgroundColor)
        #else
        return Color(UIColor.tertiarySystemBackground)
        #endif
    }
}

struct VisualEffectView: UIViewRepresentable {
    var uiVisualEffect: UIVisualEffect?

    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView {
        UIVisualEffectView()
    }

    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) {
        uiView.effect = uiVisualEffect
    }
}

