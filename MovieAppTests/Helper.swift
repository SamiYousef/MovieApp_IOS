//
//  Helper.swift
//  MovieAppTests
//
//  Created by imac on 8/29/18.
//  Copyright © 2018 Sami Youssef. All rights reserved.
//

import XCTest
@testable import MovieApp

public enum FileType: String {
    case json = "json"
}

extension XCTestCase {
    func generateMockDispatcher(request: RequestData, data: Data) -> NetworkDispatcher {
        let urlResponse = HTTPURLResponse(url: URL(string: request.path)!, statusCode: 200, httpVersion: nil, headerFields: nil)
        let sessionMock = URLSessionMock(data: data, response: urlResponse, error: nil)
        return URLSessionNetworkDispatcher(session: sessionMock)
    }

    func fetchMockData(fileName: String, type: FileType) -> Data? {
        if let path = Bundle.main.url(forResource: fileName, withExtension: type.rawValue) {
            return try? Data(contentsOf: path)
        }
        return nil
    }

    func testNetworkApi<T: RequestType>(session: DHURLSession, mockObj: T,
                                        completion: @escaping (T.ResponseType?, Error?) -> Void) {
        //given
        let sessionDispatcher = URLSessionNetworkDispatcher(session: session)
        let expect = expectation(description: "Data fetched successfully ...!")

        //when
        mockObj.excute(dispatcher: sessionDispatcher, onSuccess: { (response) in
            completion(response, nil)
            expect.fulfill()
        }) { (error) in
            completion(nil, error)
            expect.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
}
