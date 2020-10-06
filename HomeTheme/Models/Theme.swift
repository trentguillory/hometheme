//
//  Theme.swift
//  HomeTheme
//
//  Created by Trent Guillory on 10/1/20.
//

import Foundation

struct Theme: Decodable {
    var id: String
    var title: String
    var description: String
    var icons: [Asset]
    //var widgetPhotos: [Asset]
    //var backgrounds: [Asset]
    //var previews: [Asset]
    
    enum CodingKeys: String, CodingKey {
        case id, data
    }

    enum DataCodingKeys: String, CodingKey {
        case title, description, icons, widgetPhotos = "widget_photos", backgrounds, previews
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)

        let dataContainer = try container.nestedContainer(keyedBy: DataCodingKeys.self, forKey: .data)
        title = try dataContainer.decode(String.self, forKey: .title)
        description = try dataContainer.decode(String.self, forKey: .description)
        icons = try dataContainer.decode([Asset].self, forKey: .icons)
        //widgetPhotos = try dataContainer.decode([Asset].self, forKey: .widgetPhotos)
        //backgrounds = try dataContainer.decode([Asset].self, forKey: .backgrounds)
        //previews = try dataContainer.decode([Asset].self, forKey: .previews)
    }
}
