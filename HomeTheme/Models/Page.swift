//
//  Page.swift
//  HomeTheme
//
//  Created by Trent Guillory on 10/6/20.
//

import Foundation

struct Page<T: Decodable>: Decodable {
    var results: [T]
    var pageNumber: Int

    enum CodingKeys: String, CodingKey {
        case results, page
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        pageNumber = try container.decode(Int.self, forKey: .page)
        results = try container.decode([T].self, forKey: .results)
    }
}
