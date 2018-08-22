//
//  ReviewResponse.swift
//  MovieApp
//
//  Created by Sami Youssef on 8/21/18.
//  Copyright © 2018 Sami Youssef. All rights reserved.
//

import Foundation

struct ReviewResponse: Codable {
    var results: [ReviewObj]

    enum RootKeys: String, CodingKey {
        case id, page, results, total_pages, total_results
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: RootKeys.self)
        results = try container.decode([ReviewObj].self, forKey: .results)
    }
}
