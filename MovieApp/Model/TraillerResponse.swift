
//
//  TraillerResponse.swift
//  MovieApp
//
//  Created by Sami Youssef on 8/21/18.
//  Copyright © 2018 Sami Youssef. All rights reserved.
//

import Foundation

struct TraillerResponse: Codable {

    var traillerList: [TraillerObj]

    enum RootKeys: String, CodingKey {
        case id, results
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: RootKeys.self)
        traillerList = try container.decode([TraillerObj].self, forKey: .results)
    }
}
