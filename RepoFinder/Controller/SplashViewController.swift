//
//  ViewController.swift
//  RepoFinder
//
//  Created by shehab ahmed on 11/01/2024.
//

import UIKit

class SplshViewController: UIViewController,StoryBoard {

    weak var coordinator: MainCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
    }
    override func viewDidAppear(_ animated: Bool) {
        performTaskAfterDelay()
    }

    func performTaskAfterDelay() {
        let delayInSeconds: TimeInterval = 1.0
        DispatchQueue.main.asyncAfter(deadline: .now() + delayInSeconds){
            self.coordinator?.navigateToRepos()
        }
        
        
    }

}

