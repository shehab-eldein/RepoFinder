//
//  DBManagerTest.swift
//  RepoFinderTests
//
//  Created by shehab ahmed on 13/01/2024.
//

import Foundation
import XCTest
import CoreData
@testable import RepoFinder

class DBManagerTests: XCTestCase {

    var dbManager: DBManager!

    override func setUpWithError() throws {
        try super.setUpWithError()
        dbManager = DBManager()
    }

    override func tearDownWithError() throws {
        dbManager = nil
        try super.tearDownWithError()
    }

    func testCashRepos() {
        
        let mockRepo1 = Repo(ownerName: "Owner1", fullName: "Repo1", details: "Details1", date: "Date1", profileUrl: "ProfileUrl1", repoUrl: "RepoUrl1", image: nil)
        
        let mockRepo2 = Repo(ownerName: "Owner2", fullName: "Repo2", details: "Details2", date: "Date2", profileUrl: "ProfileUrl2", repoUrl: "RepoUrl2", image: nil)

        //Test Saving and retrive
        dbManager.cashRepos(repos: [mockRepo1, mockRepo2])

        
        var cachedRepos = dbManager.getProductsCash()

        XCTAssertEqual(cachedRepos.count, 2)

        
       
        
        // Test Delete
        dbManager.deleteAllRepos()
        cachedRepos = dbManager.getProductsCash()
        
        XCTAssertEqual(cachedRepos.count, 0)
    }

   

}
