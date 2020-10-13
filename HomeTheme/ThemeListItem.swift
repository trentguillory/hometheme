//
//  ThemeListItem.swift
//  HomeTheme
//
//  Created by Trent Guillory on 10/8/20.
//

import SwiftUI

struct ThemeListItem: View {
    @State var theme: Theme
    @State var isOpen = false
    @State var geoWidth: CGFloat

    var body: some View {
        VStack(alignment: .center) {
            VStack {
                VStack(spacing: -2 * iconPadding) {
                    GridStack(rows: 2, columns: 4) { row, col in
                        IconView(icon: theme.icons[row * 4 + col], iconWidth: iconSize)
                            .padding(iconPadding)
                    }
                    .padding(iconPadding)
                    Text(theme.title).font(.caption).foregroundColor(.white)
                        .padding(iconPadding)
                }
            }
            .background(
                theme.backgrounds[0].testStaticImage!
                    .resizable()
                    .cornerRadius(isOpen ? 0 : 16)
            )
        }
        .onTapGesture {
            if !isOpen {
                withAnimation {
                    isOpen = true
                    geoWidth = geoWidth + 32
                }
            } else {
                withAnimation {
                    isOpen = false
                    geoWidth = geoWidth - 32
                }
            }
        }

    }
    // iconWidth * 4 + paddingUnit * 10 = totalWidth

    var iconSize: CGFloat {
        return geoWidth / 6
    }
    var iconPadding: CGFloat {
        let leftover = geoWidth - iconSize * 4
        return leftover / 10
    }
}

struct PreferenceViewSetter: View {
    let themeId: Int

    var body: some View {
        GeometryReader { geometry in
            Rectangle()
                .fill(Color.clear)
                .preference(key: ThemeListPreferenceKey.self,
                            value: [ThemeListPreferenceData(themeId: self.themeId, rect: geometry.frame(in: .named(themeListCoordSpace)))])
        }
    }
}

struct ThemeListItem_Previews: PreviewProvider {
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
                ThemeListItem(theme: theme, geoWidth: geometry.size.width)
            }
    }
}
