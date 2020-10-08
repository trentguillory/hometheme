//
//  ThemeListView.swift
//  HomeTheme
//
//  Created by Trent Guillory on 10/1/20.
//

import SwiftUI

struct ThemeListView: View {
    @State var themesModel = ThemesViewModel()
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                LazyVStack {
                    ForEach(themesModel.themes, id: \.id) { theme in
                        ThemeListItem(theme: theme, geoWidth: geometry.size.width)
                    }
                }
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                Button(action: {
                    NetworkManager.shared.getThemes { themes in
                        DispatchQueue.main.async {
                            themesModel.themes = themes
                        }
                    }
                }, label: {
                    Text("Fetch Themes")
                })
            }
        }
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
