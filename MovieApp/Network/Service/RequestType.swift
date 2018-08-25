//
//  RequestType.swift
//  MovieApp
//
//  Created by Sami Youssef on 8/24/18.
//  Copyright © 2018 Sami Youssef. All rights reserved.
//

import Foundation

protocol RequestType {
    associatedtype ResponseType: Codable
    var data: RequestData { get }
}

extension RequestType {
    func excute(dispatcher: NetworkDispatcher = URLSessionNetworkDispatcher.instance,
                onSuccess: @escaping (ResponseType) -> Void,
                onError: @escaping (Error) -> Void) {
        dispatcher.dispatch(request: data, onSuccess: { (responseData: Data) in
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(ResponseType.self, from: responseData)
                DispatchQueue.main.async {
                    onSuccess(result)
                }
            } catch let error {
                DispatchQueue.main.async {
                    onError(error)
                }
            }
        }) { (error: Error) in
            DispatchQueue.main.async {
                onError(error)
            }
        }
    }
}

