//
//  ThemeListItem.swift
//  HomeTheme
//
//  Created by Trent Guillory on 10/8/20.
//

import SwiftUI

struct ThemeListItem: View {
    @State var theme: Theme
    @State var geoWidth: CGFloat
    @Binding var selectedTheme: Theme?
    @Binding var isOpen: Bool

    var adjustedGeoWidth: CGFloat {
        if isOpen {
            return geoWidth
        } else {
            return geoWidth - themeListGap
        }
    }

    var body: some View {
        VStack(alignment: .center) {
            VStack {
                VStack(spacing: -2 * iconPadding) {
                    GridStack(rows: 2, columns: 4) { row, col in
                        IconView(icon: theme.icons[row * 4 + col], iconWidth: iconSize)
                            .padding(iconPadding)
                    }
                    .padding(isOpen
                                ? EdgeInsets(top: iconPadding * 4, leading: iconPadding, bottom: iconPadding, trailing: iconPadding)
                                : EdgeInsets(top: iconPadding, leading: iconPadding, bottom: iconPadding, trailing: iconPadding))
                    Text(theme.title).font(.caption).foregroundColor(.white)
                        .frame(maxWidth: iconSize * 5)
                        .padding(iconPadding)
                        .opacity(isOpen ? 0 : 1)
                }
            }
            .background(
                theme.backgrounds[0].testStaticImage!
                    .resizable()
                    .cornerRadius(isOpen ? 0 : 16)
            )
        }
        .background(
            GeometryReader { geometry in
                Rectangle()
                    .fill(Color.clear)
                    .preference(key: ThemeListPreferenceKey.self,
                                value: [ThemeListPreferenceData(themeId: theme.id,
                                                                rect: geometry.frame(in: .named(themeListCoordSpace)),
                                                                geoWidth: geoWidth)])
            }
        )
    }

    var iconSize: CGFloat {
        return adjustedGeoWidth / 6
    }
    var iconPadding: CGFloat {
        let leftover = adjustedGeoWidth - iconSize * 4
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
                ThemeListItem(theme: theme, geoWidth: geometry.size.width, selectedTheme: Binding.constant(nil), isOpen: .constant(false))
            }
    }
}
