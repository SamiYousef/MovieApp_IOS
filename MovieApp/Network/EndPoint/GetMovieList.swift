//
//  GetMovieList.swift
//  MovieApp
//
//  Created by Sami Youssef on 8/24/18.
//  Copyright © 2018 Sami Youssef. All rights reserved.
//

import Foundation

struct GetMovieList: RequestType {
    typealias ResponseType = MovieResponse
    var data: RequestData {
        return RequestData(path: .popular, method: .get)
    }
}

fileprivate extension String {
    static let popular = .mainURL + "popular?api_key=\(.apiKey as String)"
}
