//
//  ThemeListItem.swift
//  HomeTheme
//
//  Created by Trent Guillory on 10/8/20.
//

import SwiftUI

struct ThemeListItem: View {
    @State var theme: Theme
    var geoWidth: CGFloat

    // Amount to decrease each icon by
    var iconAdjustment: CGFloat = 4

    var body: some View {
        VStack(alignment: .center) {
            VStack {
                VStack(spacing: -2) {
                    GridStack(rows: 2, columns: 4) { row, col in
                        IconView(icon: theme.icons[row * 4 + col], iconWidth: iconSize)
                            .padding(iconPadding)
                    }
                    Text(theme.title).font(.caption).foregroundColor(.white)
                        .padding(4)
                }
                .padding(gridPadding)
            }
            .background(
                theme.backgrounds[0].testStaticImage!
                    .resizable()
                    .cornerRadius(16)
            )
        }
        .padding()
    }

    var gridPadding: CGFloat {
        return iconAdjustment * 2
    }
    var iconSize: CGFloat {
        return geoWidth / 6 - iconAdjustment
    }
    var iconPadding: CGFloat {
        let leftover = geoWidth - iconSize * 4
        return leftover / 10
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
