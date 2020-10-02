//
//  Asset.swift
//  HomeTheme
//
//  Created by Trent Guillory on 10/1/20.
//

import Foundation
import SwiftUI

struct Asset: Codable {
    var name: String
    var alternativeText: String
    var largeImage: URL?
    var mediumImage: URL?
    var smallImage: URL?
    var thumbnailImage: URL?
    
    enum CodingKeys: CodingKey {
        case name, alternativeText, formats
    }
    
    enum AssetFormatKeys: CodingKey {
        case large, medium, small, thumbnail
    }
    
    enum FormatPropertyKeys: CodingKey {
        case url
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        alternativeText = try container.decode(String.self, forKey: .alternativeText)
        
        let formatContainer = try container.nestedContainer(keyedBy: AssetFormatKeys.self, forKey: .formats)
        
        let largeImageContainer = try formatContainer.nestedContainer(keyedBy: FormatPropertyKeys.self, forKey: .large)
        let largeImagePath = try largeImageContainer.decode(String.self, forKey: .url)
        
        let mediumImageContainer = try formatContainer.nestedContainer(keyedBy: FormatPropertyKeys.self, forKey: .medium)
        let mediumImagePath = try mediumImageContainer.decode(String.self, forKey: .url)
        
        let smallImageContainer = try formatContainer.nestedContainer(keyedBy: FormatPropertyKeys.self, forKey: .small)
        let smallImagePath = try smallImageContainer.decode(String.self, forKey: .url)
        
        let thumbnailImageContainer = try formatContainer.nestedContainer(keyedBy: FormatPropertyKeys.self, forKey: .thumbnail)
        let thumbnailImagePath = try thumbnailImageContainer.decode(String.self, forKey: .url)
        
        largeImage = NetworkManager.urlForPath(path: largeImagePath)
        mediumImage = NetworkManager.urlForPath(path: mediumImagePath)
        smallImage = NetworkManager.urlForPath(path: smallImagePath)
        thumbnailImage = NetworkManager.urlForPath(path: thumbnailImagePath)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(alternativeText, forKey: .alternativeText)
        
        // TODO: Verify if this is useful. We likely need to upload
        // images elsewhere and always read back the url.
        var formatContainer = container.nestedContainer(keyedBy: AssetFormatKeys.self, forKey: .formats)
        try formatContainer.encode(largeImage, forKey: .large)
        try formatContainer.encode(mediumImage, forKey: .medium)
        try formatContainer.encode(smallImage, forKey: .small)
        try formatContainer.encode(thumbnailImage, forKey: .thumbnail)
    }
}
