//
//  QueryService.swift
//  MovieApp
//
//  Created by Sami Youssef on 8/18/18.
//  Copyright © 2018 Sami Youssef. All rights reserved.
//

import Foundation

class QueryService {

    typealias QueryResult = ([MovieObj]?, String) -> ()

    private var errorMessage = ""
    private var movieList: [MovieObj] = []
    private let defaultSession = URLSession(configuration: .default)
    private var dataTask: URLSessionDataTask?

    func getMovieList(completion: @escaping QueryResult) {
        dataTask?.cancel()
        if var urlComponents = URLComponents(string: .popular) {
            urlComponents.query = "api_key=\(.apiKey as String)"
            guard let url = urlComponents.url else { return }
            dataTask = defaultSession.dataTask(with: url, completionHandler: { (data, response, error) in
                defer { self.dataTask = nil }
                if let err = error {
                    self.errorMessage = err.localizedDescription
                } else if let data = data,
                    let response = response as? HTTPURLResponse,
                    response.statusCode == 200 {
                    do {
                        let decoder = JSONDecoder()
                        let responseJson = try decoder.decode(MovieResponse.self, from: data)
                        self.movieList = responseJson.results
                    } catch let err {
                        self.errorMessage = err.localizedDescription
                    }

                    DispatchQueue.main.async {
                        completion(self.movieList, self.errorMessage)
                    }

                }
            })
            dataTask?.resume()
        }
    }

}

fileprivate extension String {
    static let popular = .mainURL + "popular"
}
