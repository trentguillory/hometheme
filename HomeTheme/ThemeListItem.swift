//
//  ThemeListItem.swift
//  HomeTheme
//
//  Created by Trent Guillory on 10/8/20.
//

import SwiftUI

struct ThemeListItem: View {
    @State var theme: Theme
    @State var iconWidth: CGFloat = 50
    var deviceWidth: CGFloat

    var body: some View {
        ZStack {
            theme.backgrounds[0].testStaticImage!
                .resizable()
                .frame(width: .infinity, height: iconSize * 2 + iconPadding * 4, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .cornerRadius(16)
            GridStack(rows: 2, columns: 4) { row, col in
                IconView(icon: theme.icons[row * 4 + col], iconWidth: iconSize)
                    .padding(iconPadding)
            }
        }
    }

    var iconSize: CGFloat {
        return deviceWidth / 6
    }
    var iconPadding: CGFloat {
        let leftover = deviceWidth - iconWidth * 4
        return leftover / 16
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
                ThemeListItem(theme: theme, deviceWidth: geometry.size.width)
                .padding()
                .background(Color.black)
            }
    }
}
