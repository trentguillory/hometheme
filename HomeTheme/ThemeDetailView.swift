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

    @State var viewScaleToUse: CGFloat = 1
    @State var isDraggingDown: Bool = false

    func setViewScale(with offset: CGFloat) {
        withAnimation {
            let calculatedScale = min(1, 1 - offset * 0.005)
            viewScaleToUse = max(0.8, calculatedScale)
        }
    }

    @State var useDragOverlay = true

    var body: some View {
        ZStack(alignment: .topLeading) {
            ZStack(alignment: .topLeading) {
                ThemeListItem(theme: theme, geoWidth: geoWidth, selectedTheme: $selectedTheme, isOpen: $isOpen)
                    .offset(x: 0, y: headerYOffset)
                    .zIndex(1)
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
                        ScrollViewReader { (proxy: ScrollViewProxy) in
                            VStack(alignment: .leading, spacing: 16) {
                                Text(theme.title)
                                    .font(.title)
                                    .id(444)
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
                    }
                    .zIndex(0)
                    .background(Color.background)
                    .coordinateSpace(name: "frameLayer")
                    .onPreferenceChange(OffsetPreferenceKey.self, perform: { offset in
                        let yOffset = offset - innerVStackPadding
                        headerYOffset = yOffset

                        if headerYOffset >= -32 {
                            useDragOverlay = true
                        } else {
                            useDragOverlay = false
                        }
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
            .zIndex(0)
            .cornerRadius(viewScaleToUse == 1 ? 0 : 32)
            .scaleEffect(viewScaleToUse)

            if useDragOverlay {
                // Drag-To-Dismiss Capture
                VStack {
                    VStack {}
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                        .background(Color.black.opacity(0.001).contentShape(Rectangle()))
                        .gesture(
                            DragGesture()
                                .onChanged { gesture in
                                    let yGesture = gesture.translation.height

                                    if yGesture < 0 {
                                        // scrolling down
                                        useDragOverlay = false
                                    } else {
                                        // scrolling up
                                        setViewScale(with: yGesture)
                                    }
                                }
                                .onEnded { gesture in
                                    if viewScaleToUse <= 0.8 {
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                            withAnimation(Animation.spring()) {
                                                preFadeIn = true
                                                isOpen = false
                                                viewScaleToUse = 1
                                            }
                                        }
                                    } else {
                                        withAnimation {
                                            viewScaleToUse = 1
                                        }
                                    }
                                }
                        )

                    VStack {}
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                }
                .zIndex(1)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)

            }
        }
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
