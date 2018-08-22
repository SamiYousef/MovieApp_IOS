//
//  ReviewService.swift
//  MovieApp
//
//  Created by Sami Youssef on 8/21/18.
//  Copyright © 2018 Sami Youssef. All rights reserved.
//

import Foundation

class ReviewService {

    typealias  completion = ([ReviewObj]?, String) -> ()

    private var errorMessage: String = ""
    private var reviewList: [ReviewObj] = []

    private let defaultSession = URLSession(configuration: .default)
    private var dataTask: URLSessionDataTask?

    func getReviews(movieId: String, completion: @escaping completion) {
        dataTask?.cancel()
        if var urlComponents = URLComponents(string: .mainURL) {
            urlComponents.path.append(movieId + "/reviews")
            urlComponents.query = "api_key=\(.apiKey as String)"
            guard let url = urlComponents.url else { return }
            dataTask = defaultSession.dataTask(with: url, completionHandler: { (data, response, error) in
                if let err = error {
                    self.errorMessage = err.localizedDescription
                } else if let data = data,
                    let response = response as? HTTPURLResponse,
                    response.statusCode == 200 {
                    do {
                        let decoder = JSONDecoder()
                        let reviewResponse = try decoder.decode(ReviewResponse.self, from: data)
                        self.reviewList = reviewResponse.results
                    } catch let err {
                        self.errorMessage = err.localizedDescription
                    }

                    DispatchQueue.main.async {
                        completion(self.reviewList, self.errorMessage)
                    }

                }
            })
            dataTask?.resume()
        }
    }
    

}
