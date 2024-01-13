//
//  RepoBuilderTest.swift
//  RepoFinderTests
//
//  Created by shehab ahmed on 13/01/2024.
//

import XCTest
@testable import RepoFinder

class RepoBuilderTests: XCTestCase {
    
    var networkManager: NetworkingManager!
    var remoteRepo: RemoteRepo!
    var repoBuilder: RepoBuilder!
   
    var owner: Owner!
    
    override func setUpWithError() throws {
        networkManager = NetworkingManager()
        
         owner = Owner(
            login: "Test login",
            id: 123,
            nodeID: "abc123",
            avatarURL: "https://example.com/avatar",
            gravatarID: "def456",
            url: "https://example.com/user",
            htmlURL: "https://example.com/user/profile",
            followersURL: "https://example.com/user/followers",
            followingURL: "https://example.com/user/following",
            gistsURL: "https://example.com/user/gists",
            starredURL: "https://example.com/user/starred",
            subscriptionsURL: "https://example.com/user/subscriptions",
            organizationsURL: "https://example.com/user/orgs",
            reposURL: "https://example.com/user/repos",
            eventsURL: "https://example.com/user/events",
            receivedEventsURL: "https://example.com/user/received_events",
            type: "User",
            siteAdmin: false
        )
        
        
        
        remoteRepo = RemoteRepo(
            id: 1,
            nodeID: "abc123",
            name: "test_repo",
            fullName: "Test Repo",
            isPrivate: false,
            owner: owner,
            htmlURL: "https://example.com/repo",
            description: "Test repo",
            isFork: false,
            url: "https://example.com/repo",
            forksURL: "https://example.com/repo/forks"
        )
        repoBuilder = RepoBuilder(networkManager: networkManager, networkRepoObject: remoteRepo)
    }
    
    func testBuild_WithValidData_ReturnsRepoObject() {
        let expectation = XCTestExpectation(description: "Completion called with repoBuilder object")
        
        repoBuilder.build { repo in
            XCTAssertNotNil(repo)
            XCTAssertEqual(repo?.ownerName, "Test login")
            XCTAssertEqual(repo?.fullName, "Test Repo")
            XCTAssertEqual(repo?.details, "Test repo")
            XCTAssertEqual(repo?.profileUrl, "https://example.com/user/profile")
            XCTAssertEqual(repo?.repoUrl, "https://example.com/repo")
            XCTAssertNotNil(repo?.image)
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testBuild_WithEmptyData_ReturnEmptyObject() {
        let expectation = XCTestExpectation(description: "Completion called with emptyData")
        
        owner = Owner(
            login: "",
            id: 3,
            nodeID: "",
            avatarURL: "",
            gravatarID: "",
            url: "",
            htmlURL: "",
            followersURL: "",
            followingURL: "",
            gistsURL: "",
            starredURL: "",
            subscriptionsURL: "",
            organizationsURL: "",
            reposURL: "",
            eventsURL: "",
            receivedEventsURL: "",
            type: "",
            siteAdmin: false
        )
        
        remoteRepo = RemoteRepo(
            id: 0,
            nodeID: "abc123",
            name: "",
            fullName: "Test Repo",
            isPrivate: false,
            owner: owner,
            htmlURL: "",
            description: "",
            isFork: false,
            url: "",
            forksURL: ""
        )
        repoBuilder = RepoBuilder(networkManager: networkManager, networkRepoObject: remoteRepo)
        
        repoBuilder.build { [self] repo in
            XCTAssertNotNil(repo)
            XCTAssertEqual(remoteRepo.name, "")
            XCTAssertEqual(remoteRepo.nodeID, "abc123")
            XCTAssertEqual(owner.login, "")
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    
    
}
