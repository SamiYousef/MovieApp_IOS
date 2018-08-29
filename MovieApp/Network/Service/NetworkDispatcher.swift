//
//  NetworkDispatcher.swift
//  MovieApp
//
//  Created by Sami Youssef on 8/24/18.
//  Copyright © 2018 Sami Youssef. All rights reserved.
//

import Foundation

protocol NetworkDispatcher {
    func dispatch(request: RequestData, onSuccess: @escaping (Data) -> Void, onError: @escaping (Error) -> Void)
}

struct URLSessionNetworkDispatcher: NetworkDispatcher {

    private let session: DHURLSession
    init(session: DHURLSession) {
        self.session = session
    }

    func dispatch(request: RequestData, onSuccess: @escaping (Data) -> Void, onError: @escaping (Error) -> Void) {
        guard let url = URL(string: request.path) else {
            onError(NetworkError.invalidURL)
            return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue

        do {
            if let params = request.params {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: params, options: [])
            }
        } catch let error {
            onError(error)
            return
        }

        session.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                onError(error)
                return
            }
            guard let _data = data else {
                onError(NetworkError.noData)
                return
            }
            onSuccess(_data)
        }.resume()
    }
}
