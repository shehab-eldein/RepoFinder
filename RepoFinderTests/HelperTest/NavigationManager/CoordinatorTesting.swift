//
//  CoordinatorTesting.swift
//  RepoFinderTests
//
//  Created by shehab ahmed on 13/01/2024.
//

import Foundation

import XCTest
@testable import RepoFinder

class MainCoordinatorTests: XCTestCase {

    var navigationController: UINavigationController!
    var mainCoordinator: MainCoordinator!

    override func setUpWithError() throws {
        try super.setUpWithError()

        navigationController = UINavigationController()
        mainCoordinator = MainCoordinator(navController: navigationController)
        
    }

    override func tearDownWithError() throws {
        mainCoordinator = nil
        navigationController = nil
        try super.tearDownWithError()
    }

    func testStart() {
        mainCoordinator.start()

        XCTAssertTrue(navigationController.viewControllers.count == 1)
        XCTAssertTrue(navigationController.viewControllers.first is SplshViewController)
    }

    func testNavigateToRepos() {
     
        mainCoordinator.navigateToRepos()

        XCTAssertTrue(navigationController.viewControllers.count == 1)
        XCTAssertTrue(navigationController.viewControllers.first is ReposViewController)
    }

    func testNavigateToDetails() {
       
        let gitRepo = Repo(ownerName: "testName", fullName: "testFullName", details: "testDetails", date: "2222", profileUrl: "https://example.com/user/profile", repoUrl: "https://example.com/user/profile", image: Data() )
        
        mainCoordinator.navigateToDetails(gitRepos: gitRepo)

        XCTAssertTrue(navigationController.viewControllers.count == 1)
        XCTAssertTrue(navigationController.viewControllers.first is DetailsViewController)
    }

    

}
