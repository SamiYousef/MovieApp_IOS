//
//  NetworkError.swift
//  MovieApp
//
//  Created by Sami Youssef on 8/24/18.
//  Copyright © 2018 Sami Youssef. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case noData
    case unableToDecode
    case timeOut
    case authnticationError
    case invalidURL
}
