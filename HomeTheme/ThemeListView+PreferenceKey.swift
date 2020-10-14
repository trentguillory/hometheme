//
//  ThemeListView+PreferenceKey.swift
//  HomeTheme
//
//  Created by Trent Guillory on 10/13/20.
//

import Foundation
import SwiftUI

let themeListGap: CGFloat = 32
let themeListCoordSpace = "ThemeListCoordinateSpace"

struct ThemeListPreferenceData: Equatable {
    let themeId: Int
    let rect: CGRect
    let geoWidth: CGFloat
}

struct ThemeListPreferenceKey: PreferenceKey {
    typealias Value = [ThemeListPreferenceData]

    static var defaultValue: [ThemeListPreferenceData] = []

    static func reduce(value: inout [ThemeListPreferenceData], nextValue: () -> [ThemeListPreferenceData]) {
        value.append(contentsOf: nextValue())
    }
}
