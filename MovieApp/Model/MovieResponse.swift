//
//  MovieResponse.swift
//  MovieApp
//
//  Created by Sami Youssef on 8/19/18.
//  Copyright © 2018 Sami Youssef. All rights reserved.
//

import Foundation

struct MovieResponse: Codable {

    var page: Int
    var total_results: Int
    var total_pages: Int
    var results: [MovieObj]

    enum movieResponseKeys: String, CodingKey {
        case page
        case total_results
        case total_pages
        case results
    }

    enum additionalKeys: String, CodingKey {
        case results
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: movieResponseKeys.self)
        page = try values.decode(Int.self, forKey: .page)
        total_results = try values.decode(Int.self, forKey: .total_results)
        total_pages = try values.decode(Int.self, forKey: .total_pages)
        results = try values.decode([MovieObj].self, forKey: .results)
    }

}
