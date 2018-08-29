//
//  MovieAppTests.swift
//  MovieAppTests
//
//  Created by imac on 8/29/18.
//  Copyright © 2018 Sami Youssef. All rights reserved.
//

import XCTest
@testable import MovieApp


fileprivate struct MockMovieList: RequestType {
    typealias ResponseType = MovieResponse
    private let path = .mainURL + "popular?api_key=\(.apiKey as String)"
    var data: RequestData {
        return RequestData(path: path, method: .get)
    }
}

class MovieAppTests: XCTestCase {

    var controllerUnderTest: MovieListController?

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        controllerUnderTest = MovieListController(collectionViewLayout: UICollectionViewLayout())
    }
    
    override func tearDown() {
        controllerUnderTest = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testMovieListApi() {
        //given
        let session = URLSession.shared
        let sessionDispatcher = URLSessionNetworkDispatcher(session: session)
        let expect = expectation(description: "Data fetched successfully ...!")

        var movieResponse: MovieResponse?
        var errorResponse: Error?

        //when
        MockMovieList().excute(dispatcher: sessionDispatcher, onSuccess: { (response) in
            movieResponse = response
            expect.fulfill()
        }) { (error) in
            errorResponse = error
            expect.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        //then
        XCTAssertNil(errorResponse, "Request failed ..!")
        XCTAssertNotNil(movieResponse, "Failed to fetch movieResponse ..!")
    }

    func testMockMovieListApi() {
        // given
        guard let popularData = fetchMockData(fileName: "popular", type: .json) else {
            XCTFail("Failed loading data ...!")
            return
        }

        let mockObj = MockMovieList()
        let expect = expectation(description: "Data fetched successfully ...!")
        let dispatcher = generateMockDispatcher(request: mockObj.data, data: popularData)

        var movieResponse: MovieResponse?
        var errorResponse: Error?

        //when
        mockObj.excute(dispatcher: dispatcher, onSuccess: { (response) in
            movieResponse = response
            expect.fulfill()
        }) { (error) in
            errorResponse = error
            expect.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)

        //then
        XCTAssertNil(errorResponse, "Request failed ..!")
        XCTAssertNotNil(movieResponse, "Failed to fetch movieResponse ..!")
        XCTAssertEqual(movieResponse?.results.count, 20)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
