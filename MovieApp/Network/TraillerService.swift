//
//  TraillerService.swift
//  MovieApp
//
//  Created by Sami Youssef on 8/21/18.
//  Copyright © 2018 Sami Youssef. All rights reserved.
//

import Foundation

class TraillerService {

    typealias completion = ([TraillerObj]?, String) -> ()

    private var errorMessage = ""
    private var traillerList: [TraillerObj] = []

    private let defaultSession = URLSession(configuration: .default)
    private var dataTask: URLSessionDataTask?

    func getTraillers(movieId: String, completion: @escaping completion) {
        dataTask?.cancel()
        if var urlComponents = URLComponents(string: .mainURL) {
            urlComponents.path.append(movieId + "/videos")
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
                        let responseJson = try decoder.decode(TraillerResponse.self, from: data)
                        self.traillerList = responseJson.traillerList
                    } catch let err {
                        self.errorMessage = err.localizedDescription
                    }

                    DispatchQueue.main.async {
                        completion(self.traillerList, self.errorMessage)
                    }

                }
            })
            dataTask?.resume()
        }

    }

}

fileprivate extension String {
}
