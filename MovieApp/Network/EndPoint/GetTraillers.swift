//
//  GetTraillers.swift
//  MovieApp
//
//  Created by Sami Youssef on 8/24/18.
//  Copyright © 2018 Sami Youssef. All rights reserved.
//

import Foundation

struct GetTraillers: RequestType {
    private var movieId: String
    typealias ResponseType = TraillerResponse
    var data: RequestData

    init(movieId: String) {
        self.movieId = movieId
        let path: String = .mainURL + "\(movieId)/videos?api_key=" + .apiKey
        self.data = RequestData(path: path, method: .get)
    }

}

