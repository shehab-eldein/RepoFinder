//
//  RepoFinderUITests.swift
//  RepoFinderUITests
//
//  Created by shehab ahmed on 11/01/2024.
//

import XCTest

final class RepoFinderUITests: XCTestCase {

    override func setUpWithError() throws {
        
        continueAfterFailure = false

      
    }

    override func tearDownWithError() throws {
       
    }

    func testExample() throws {
        
        let app = XCUIApplication()
        app.launch()

        
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
