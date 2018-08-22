//
//  TraillerObj.swift
//  MovieApp
//
//  Created by Sami Youssef on 8/21/18.
//  Copyright © 2018 Sami Youssef. All rights reserved.
//

import Foundation

/*
 "id": "5a200baa925141033608f5f0",
 "iso_639_1": "en",
 "iso_3166_1": "US",
 "key": "6ZfuNTqbHE8",
 "name": "Official Trailer",
 "site": "YouTube",
 "size": 1080,
 "type": "Trailer"
 */

struct TraillerObj: Codable {

    var id: String
    var key: String
    var name: String
    var site: String
    var size: Int
    var type: String

    enum TraillerKeys: String, CodingKey {
        case id
        case key
        case name
        case site
        case size
        case type
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: TraillerKeys.self)
        id = try container.decode(String.self, forKey: .id)
        key = try container.decode(String.self, forKey: .key)
        name = try container.decode(String.self, forKey: .name)
        site = try container.decode(String.self, forKey: .site)
        size = try container.decode(Int.self, forKey: .size)
        type = try container.decode(String.self, forKey: .type)
    }

}


