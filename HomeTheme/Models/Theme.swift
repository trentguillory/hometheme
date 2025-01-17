//
//  Theme.swift
//  HomeTheme
//
//  Created by Trent Guillory on 10/1/20.
//

import Foundation

struct Theme: Codable, Equatable {
    var id: Int
    var title: String
    var description: String
    var icons: [Asset]
    var widgetPhotos: [Asset]
    var backgrounds: [Asset]
    var previews: [Asset]
    
    enum CodingKeys: String, CodingKey {
        case id, title, description, icons, widgetPhotos = "widget_photos", backgrounds, previews
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        description = try container.decode(String.self, forKey: .description)
        icons = try container.decode([Asset].self, forKey: .icons)
        widgetPhotos = try container.decode([Asset].self, forKey: .widgetPhotos)
        backgrounds = try container.decode([Asset].self, forKey: .backgrounds)
        previews = try container.decode([Asset].self, forKey: .previews)
    }

    init(icons: [Asset], widgetPhotos: [Asset], backgrounds: [Asset], previews: [Asset]) {
        id = 123
        title = "macOS Theme"
        description = "This theme is an icon pack just like the one found on macOS Catalina."
        self.icons = icons
        self.widgetPhotos = widgetPhotos
        self.backgrounds = backgrounds
        self.previews = previews
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(title, forKey: .title)
        try container.encode(description, forKey: .description)
        try container.encode(icons, forKey: .icons)
        try container.encode(widgetPhotos, forKey: .widgetPhotos)
        try container.encode(backgrounds, forKey: .backgrounds)
        try container.encode(previews, forKey: .previews)
    }

    static func == (lhs: Theme, rhs: Theme) -> Bool {
        lhs.id == rhs.id
    }
}
