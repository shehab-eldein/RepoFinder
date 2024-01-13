//
//  NetworkManagerTest.swift
//  RepoFinderTests
//
//  Created by shehab ahmed on 13/01/2024.
//

import Foundation
import XCTest
@testable import RepoFinder

import XCTest
@testable import RepoFinder

class NetworkingManagerTests: XCTestCase {

    var networkingManager: NetworkingManager!

    override func setUpWithError() throws {
        try super.setUpWithError()
        networkingManager = NetworkingManager()
    }

    override func tearDownWithError() throws {
        networkingManager = nil
        try super.tearDownWithError()
    }

    class MockURLSession: URLSession {
        var data: Data?
        var error: Error?
        var dataTaskHandler: ((Data?, URLResponse?, Error?) -> Void)?

        override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
            let mockDataTask = MockURLSessionDataTask()
            mockDataTask.completionHandler = {
                self.dataTaskHandler?(self.data, nil, self.error)
            }
            return mockDataTask
        }
    }

    class MockURLSessionDataTask: URLSessionDataTask {
        var completionHandler: (() -> Void)?

        override func resume() {
            completionHandler?()
        }
    }

   
    func testFetchData_Successful() {
        let mockSession = MockURLSession()
        networkingManager.session = mockSession

        let expectation = XCTestExpectation(description: "Data fetched successfully")

        networkingManager.fetchData(from: URL(string: "https://example.com")!) { data in
            XCTAssertNotNil(data)
            expectation.fulfill()
        }

        mockSession.data = Data()
        mockSession.dataTaskHandler?(nil, nil, nil)

        wait(for: [expectation], timeout: 1.0)
    }

  
    func testFetchData_Failure() {
        let mockSession = MockURLSession()
        networkingManager.session = mockSession

        let expectation = XCTestExpectation(description: "Failed to fetch data")

        networkingManager.fetchData(from: URL(string: "https://example.com")!) { data in
            XCTAssert((data != nil))
            expectation.fulfill()
        }

        mockSession.error = NSError(domain: "TestErrorDomain", code: 42, userInfo: nil)
        mockSession.dataTaskHandler?(nil, nil, nil)

        wait(for: [expectation], timeout: 1.0)
    }

   
}
