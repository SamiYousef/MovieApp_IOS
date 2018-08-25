//
//  RequestData.swift
//  MovieApp
//
//  Created by Sami Youssef on 8/23/18.
//  Copyright © 2018 Sami Youssef. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case patch = "PATCH"
}

struct RequestData {
    let path: String
    let method: HTTPMethod
    let params: [String: Any]?
    let headers: [String: String]?

    init(path: String, method: HTTPMethod, params: [String:Any]? = nil, headers: [String: String]? = nil) {
        self.path = path
        self.method = method
        self.params = params
        self.headers = headers
    }

}
