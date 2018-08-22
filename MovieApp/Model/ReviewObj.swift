//
//  ReviewObj.swift
//  MovieApp
//
//  Created by Sami Youssef on 8/21/18.
//  Copyright © 2018 Sami Youssef. All rights reserved.
//

import Foundation

/*
 "author": "Screen-Space",
 "content": "\"It is a bold undertaking, to readjust what is expected of the MCU/Avengers formula, and there are moments when the sheer scale and momentum match the narrative ambition...\"\r\n\r\nRead the full review here: http://screen-space.squarespace.com/reviews/2018/4/25/avengers-infinity-war.html",
 "id": "5adff809c3a3683daa00ad3d",
 "url": "https://www.themoviedb.org/review/5adff809c3a3683daa00ad3d"
 */

struct ReviewObj: Codable {

    var author: String
    var content: String
    var id: String
    var url: String

    enum ReviewKeys: String, CodingKey {
        case author
        case content
        case id
        case url
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ReviewKeys.self)
        author = try container.decode(String.self, forKey: .author)
        content = try container.decode(String.self, forKey: .content)
        id = try container.decode(String.self, forKey: .id)
        url = try container.decode(String.self, forKey: .url)
    }
}
