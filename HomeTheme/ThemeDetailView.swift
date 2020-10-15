//
//  ThemeDetailView.swift
//  HomeTheme
//
//  Created by Trent Guillory on 10/14/20.
//

import SwiftUI

struct ThemeDetailView: View {
    @State var theme: Theme
    @State var geoWidth: CGFloat
    @Binding var selectedTheme: Theme?
    @Binding var isOpen: Bool

    @State private var preFadeIn = true
    @State private var headerYOffset: CGFloat = 0
    @State private var headerHeight: CGFloat = 100

    var innerVStackPadding: CGFloat = 32

    var adjustedGeoWidth: CGFloat {
        if isOpen {
            return geoWidth
        } else {
            return geoWidth - themeListGap
        }
    }

    var body: some View {
        ZStack(alignment: .topLeading) {
            ThemeListItem(theme: theme, geoWidth: geoWidth, selectedTheme: $selectedTheme, isOpen: $isOpen)
                .offset(x: 0, y: headerYOffset)
                .background(
                    GeometryReader { geometry in
                        Color.clear
                            .onAppear {
                                headerHeight = geometry.size.height
                            }
                    }
                )

            if isOpen {
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        Text(theme.title)
                            .font(.title)
                            .padding(.top, headerHeight + innerVStackPadding + 24)
                            .background(
                                GeometryReader { geometry in
                                    Color.clear
                                        .preference(key: OffsetPreferenceKey.self,
                                                    value: geometry.frame(in: .named("frameLayer")).minY)
                                }
                            )
                        Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
                            .font(.title2)
                    }
                    .padding(innerVStackPadding)
                }
                .coordinateSpace(name: "frameLayer")
                .onPreferenceChange(OffsetPreferenceKey.self, perform: { offset in
                    //print("scrollview offset: \(offset - innerVStackPadding)")
                    let yOffset = offset - innerVStackPadding
                    headerYOffset = yOffset
                })
                .padding(preFadeIn
                    ? EdgeInsets(top: 60, leading: 0, bottom: 0, trailing: 0)
                    : EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                .opacity(preFadeIn ? 0 : 1)
                .onAppear {
                    withAnimation {
                        preFadeIn = false
                    }
                }
            }
        }
        .background(Color.background)
    }
}

private struct OffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = .zero
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {}
}

struct ThemeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let iconAssets = [Asset(name: "Safari", altText: "", image: Image("safari")),
                          Asset(name: "Find My", altText: "", image: Image("find-my")),
                          Asset(name: "Firefox", altText: "", image: Image("firefox")),
                          Asset(name: "Siri", altText: "", image: Image("siri")),
                          Asset(name: "Telegram", altText: "", image: Image("telegram")),
                          Asset(name: "Symbols", altText: "", image: Image("symbols")),
                          Asset(name: "Spotify", altText: "", image: Image("spotify")),
                          Asset(name: "Messages", altText: "", image: Image("messages"))]

        let backgroundImg = Asset(name: "Background", altText: "", image: Image("background"))

        let theme = Theme(icons: iconAssets, widgetPhotos: [], backgrounds: [backgroundImg], previews: [])

        return
            GeometryReader { geometry in
                ThemeDetailView(theme: theme, geoWidth: geometry.size.width, selectedTheme: Binding.constant(nil), isOpen: .constant(false))
            }
    }
}
