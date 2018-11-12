//
//  ListMoviesModels.swift
//  MovieApp
//
//  Created by Sami Youssef on 11/12/18.
//  Copyright (c) 2018 Sami Youssef. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

enum ListMovies {
    // MARK: Use cases

    enum FetchMovieList {
        struct Request: RequestType {
            typealias ResponseType = MovieResponse
            var data: RequestData {
                return RequestData(path: .popular, method: .get)
            }
        }
        struct Response {
            var movieLits: [MovieObj]
        }
        struct ViewModel {
            var movieLits: [MovieObj]
        }
    }

    enum Something {
        struct Request {}
        struct Response {}
        struct ViewModel {}
    }
}

fileprivate extension String {
    static let popular = .mainURL + "popular?api_key=\(.apiKey as String)"
}