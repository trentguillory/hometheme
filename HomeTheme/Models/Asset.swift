//
//  Asset.swift
//  HomeTheme
//
//  Created by Trent Guillory on 10/1/20.
//

import Foundation
import SwiftUI

struct Asset: Decodable {
    var name: String
    var alternativeText: String
    var largeImage: URL?
    var mediumImage: URL?
    var thumbnailImage: URL?
    
    enum CodingKeys: String, CodingKey {
        case image, name, alternativeText = "alternativetext"
    }
    
    enum ImageCodingKeys: CodingKey {
        case url, medium, thumbnail
    }
    
    enum FormatPropertyKeys: CodingKey {
        case url
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        alternativeText = try container.decode(String.self, forKey: .alternativeText)

        let imageContainer = try container.nestedContainer(keyedBy: ImageCodingKeys.self, forKey: .image)
        let largeImagePath = try imageContainer.decode(String.self, forKey: .url)
        largeImage = URL(string: largeImagePath)

        let mediumImageContainer = try imageContainer.nestedContainer(keyedBy: FormatPropertyKeys.self, forKey: .medium)
        let mediumImagePath = try mediumImageContainer.decode(String.self, forKey: .url)
        mediumImage = URL(string: mediumImagePath)

        let thumbnailImageContainer = try imageContainer.nestedContainer(keyedBy: FormatPropertyKeys.self, forKey: .thumbnail)
        let thumbnailImagePath = try thumbnailImageContainer.decode(String.self, forKey: .url)
        thumbnailImage = URL(string: thumbnailImagePath)
    }
}
