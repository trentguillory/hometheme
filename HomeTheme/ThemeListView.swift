//
//  ThemeListView.swift
//  HomeTheme
//
//  Created by Trent Guillory on 10/1/20.
//

import SwiftUI

struct ThemeListView: View {
    @Environment(\.colorScheme) var colorScheme
    @State var themesModel = ThemesViewModel()
    @State var selectedTheme: Theme?
    @State private var cellData: [Int: ThemeListPreferenceData] = [:]
    //@State private var selectedThemeGeoData: ThemeListPreferenceData?

    @State private var detailViewOpen = false
    
    var body: some View {
            GeometryReader { geometry in
                ZStack(alignment: .topLeading) {
                    NavigationView {
                        ScrollView {
                            LazyVStack(spacing: 16) {
                                ForEach(themesModel.themes, id: \.id) { theme in
                                    ThemeListItem(theme: theme,
                                                  geoWidth: geometry.size.width,
                                                  selectedTheme: $selectedTheme,
                                                  isOpen: .constant(false))
                                        .onTapGesture {
                                            selectedTheme = theme
                                        }
                                }
                            }
                            .onPreferenceChange(ThemeListPreferenceKey.self) { preferences in
                                for p in preferences {
                                    self.cellData[p.themeId] = p
                                }
                            }
                            Text("Hello, World!")
                            Button(action: {
                                NetworkManager.shared.getThemes { themes in
                                    DispatchQueue.main.async {
                                        themesModel.themes = themes
                                    }
                                }
                            }, label: {
                                Text("Fetch Themes")
                            })
                        }.navigationBarTitle("Themes")
                    }.blur(radius: detailViewOpen ? 25 : 0, opaque: true)

//                    if detailViewOpen {
//                        VisualEffectView(uiVisualEffect: UIBlurEffect(style: colorScheme == .dark ? .dark : .light))
//                            .edgesIgnoringSafeArea(.all)
//                            .transition(.opacity)
//                    }

                    if let currentTheme = selectedTheme, let currentThemeLayout = cellData[currentTheme.id] {
                        ThemeDetailView(theme: currentTheme,
                                      geoWidth: currentThemeLayout.geoWidth,
                                      selectedTheme: $selectedTheme,
                                      isOpen: $detailViewOpen)
                            .offset(x: detailViewOpen ? 0 : currentThemeLayout.rect.minX,
                                    y: detailViewOpen ? 0 : currentThemeLayout.rect.minY)
                            .onAppear {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                    withAnimation {
                                        detailViewOpen = true
                                    }
                                }
                            }
                            .onChange(of: detailViewOpen) { _ in
                                if detailViewOpen == false {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                                        withAnimation {
                                            selectedTheme = nil
                                        }
                                    }
                                }
                            }
                    }

                }
                .edgesIgnoringSafeArea(.all)
                .coordinateSpace(name: themeListCoordSpace)
                .onAppear {
        //            NetworkManager.shared.getThemes { themes in
        //                DispatchQueue.main.async {
        //                    themesModel.themes = themes
        //                }
        //            }
                    themesModel.themes = NetworkManager.shared.testGetThemes()
                }
            }
    }
}

struct ThemeListView_Previews: PreviewProvider {
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

        var theme = Theme(icons: iconAssets, widgetPhotos: [], backgrounds: [backgroundImg], previews: [])
        var theme2 = theme
        var theme3 = theme
        var theme4 = theme

        theme2.id = 2
        theme3.id = 3
        theme4.id = 4

        return Group {
            ThemeListView(themesModel: ThemesViewModel(themes: [theme, theme2, theme3, theme4]))
        }
    }
}
