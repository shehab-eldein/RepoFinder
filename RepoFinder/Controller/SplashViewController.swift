//
//  ViewController.swift
//  RepoFinder
//
//  Created by shehab ahmed on 11/01/2024.
//

import UIKit

class SplshViewController: UIViewController,StoryBoard {

    weak var coordinator: MainCoordinator?
    let netWorkManager = NetworkingManager()

    @IBOutlet weak var gitLogo: UIImageView!
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
       
        netWorkManager.getImageData(imgURL: "https://cdn4.iconfinder.com/data/icons/iconsimple-logotypes/512/github-1024.png"){ imgData in
            
            DispatchQueue.main.async {
                self.gitLogo.image = UIImage(data: imgData!)
                self.performTaskAfterDelay()
            }
        }
       
        
    }
    override func viewDidAppear(_ animated: Bool) {
       
    }

    func performTaskAfterDelay() {
        let delayInSeconds: TimeInterval = 1.0
        DispatchQueue.main.asyncAfter(deadline: .now() + delayInSeconds){
            self.coordinator?.navigateToRepos()
        }
        
        
    }

}

