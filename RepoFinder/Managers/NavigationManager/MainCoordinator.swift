//
//  MainCoordinator.swift
//  RepoFinder
//
//  Created by shehab ahmed on 11/01/2024.
//

import Foundation
import UIKit

class MainCoordinator : Coordinator {
    
    var childCoordinator = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navController:UINavigationController) {
        self.navigationController = navController
        
    }
    
    func start() {
        let splashVC = SplshViewController.instantiate()
        splashVC.coordinator = self
        navigationController.pushViewController(splashVC, animated: true)
    }
    func navigateToRepos () {
        
        let reposVC = ReposViewController.instantiate()
        reposVC.coordinator = self
        reposVC.navigationItem.hidesBackButton = true
        reposVC.navigationController?.navigationBar.isHidden = true
        navigationController.pushViewController( reposVC, animated: true)
        
    }
    func navigateToDetails () {
        
        let detailsVC = DetailsViewController.instantiate()
        detailsVC.coordinator = self
        navigationController.pushViewController( detailsVC, animated: true)
        
    }
    
    
}
