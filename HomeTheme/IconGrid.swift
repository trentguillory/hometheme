//
//  IconGrid.swift
//  HomeTheme
//
//  Created by Trent Guillory on 10/22/20.
//

import SwiftUI

enum ThemeStyle {
    case light, dark
}

struct IconGrid: View {
    var icons: [Asset]
    var geoWidth: CGFloat
    var customIconCount: Int?
    var customIconSize: CGFloat?
    var customIconPadding: CGFloat?
    var customRowCount: Int?
    var columnCount: Int = 4
    var showTitles: Bool = true
    var customStyle: ThemeStyle?

    var iconSize: CGFloat {
        if let explicitIconSize = customIconSize {
            return explicitIconSize
        } else {
            return geoWidth / 6
        }
    }
    var iconPadding: CGFloat {
        if let explicitIconPadding = customIconPadding {
            return explicitIconPadding
        } else {
            let leftover = geoWidth - iconSize * 4
            return leftover / 10
        }
    }

    var iconCount: Int {
        if let explicitIconCount = customIconCount {
            return explicitIconCount
        } else {
            return icons.count
        }
    }

    var rowCount: Int {
        if let explicitRowCount = customRowCount {
            return explicitRowCount
        } else {
            let wholeRows = iconCount / columnCount
            let incompleteRows = (iconCount % columnCount == 0) ? 0 : 1
            return wholeRows + incompleteRows
        }
    }

    var textColor: Color {
        if let explicitColor = customStyle {
            switch explicitColor {
            case .dark:
                return .black
            case .light:
                return .white
            }
        } else {
            return .foreground
        }
    }

    var body: some View {
        VStack {
            GridStack(rows: rowCount, columns: columnCount) { row, col in
                VStack(spacing: 0) {
                    if row * columnCount + col < icons.count {
                        IconView(icon: icons[row * columnCount + col], iconWidth: iconSize)
                            .padding(iconPadding)
                        if showTitles {
                            Text(icons[row * columnCount + col].name)
                                .font(.caption)
                                .offset(y: -1 * iconPadding * 0.4)
                                .foregroundColor(textColor)
                        }
                    }
                }
            }
        }
    }
}

struct IconGrid_Previews: PreviewProvider {
    static var previews: some View {
        let iconAssets = [Asset(name: "Safari", altText: "", image: Image("safari")),
                          Asset(name: "Find My", altText: "", image: Image("find-my")),
                          Asset(name: "Firefox", altText: "", image: Image("firefox")),
                          Asset(name: "Siri", altText: "", image: Image("siri")),
                          Asset(name: "Telegram", altText: "", image: Image("telegram")),
                          Asset(name: "Symbols", altText: "", image: Image("symbols")),
                          Asset(name: "Spotify", altText: "", image: Image("spotify")),
                          Asset(name: "Messages", altText: "", image: Image("messages")),
                          Asset(name: "Find My", altText: "", image: Image("find-my")),
                          Asset(name: "Firefox", altText: "", image: Image("firefox"))]

        return
            GeometryReader { geometry in
                IconGrid(icons: iconAssets, geoWidth: geometry.size.width)
            }.background(Color.gray)
    }
}
