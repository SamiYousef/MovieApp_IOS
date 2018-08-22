//
//  MovieObj.swift
//  MovieApp
//
//  Created by Sami Youssef on 8/18/18.
//  Copyright © 2018 Sami Youssef. All rights reserved.
//

import Foundation

/*
 "vote_count": 9142,
 "id": 283995,
 "video": false,
 "vote_average": 7.6,
 "title": "Guardians of the Galaxy Vol. 2",
 "popularity": 46.63,
 "poster_path": "/y4MBh0EjBlMuOzv9axM4qJlmhzz.jpg",
 "original_language": "en",
 "original_title": "Guardians of the Galaxy Vol. 2",
 "genre_ids": [
 28,
 12,
 35,
 878
 ],
 "backdrop_path": "/aJn9XeesqsrSLKcHfHP4u5985hn.jpg",
 "adult": false,
 "overview": "The Guardians must fight to keep their newfound family together as they unravel the mysteries of Peter Quill's true parentage.",
 "release_date": "2017-04-19"
 */
struct MovieObj: Codable {
    var vote_count: Int
    var id: Int
    var video: Bool
    var vote_average: Float
    var title: String
    var popularity: Float
    var poster_path: String
    var original_language: String
    var original_title: String
    var genre_ids: [Int]
    var backdrop_path: String?
    var adult: Bool
    var overview: String
    var release_date: String

    enum codingKeys: String, CodingKey {
        case vote_count
        case id
        case video
        case vote_average
        case title
        case popularity
        case poster_path
        case original_language
        case original_title
        case genre_ids
        case backdrop_path
        case adult
        case overview
        case release_date
    }

    public init(from decoder: Decoder) throws {
        let movieValues = try decoder.container(keyedBy: codingKeys.self)
        vote_count = try movieValues.decode(Int.self, forKey: .vote_count)
        id = try movieValues.decode(Int.self, forKey: .id)
        video = try movieValues.decode(Bool.self, forKey: .video)
        vote_average = try movieValues.decode(Float.self, forKey: .vote_average)
        title = try movieValues.decode(String.self, forKey: .title)
        popularity = try movieValues.decode(Float.self, forKey: .popularity)
        poster_path = try movieValues.decode(String.self, forKey: .poster_path)
        original_language = try movieValues.decode(String.self, forKey: .original_language)
        original_title = try movieValues.decode(String.self, forKey: .original_title)
        genre_ids = try movieValues.decode([Int].self, forKey: .genre_ids)
        backdrop_path = try movieValues.decodeIfPresent(String.self, forKey: .backdrop_path)
        adult = try movieValues.decode(Bool.self, forKey: .adult)
        overview = try movieValues.decode(String.self, forKey: .overview)
        release_date = try movieValues.decode(String.self, forKey: .release_date)
    }
}
