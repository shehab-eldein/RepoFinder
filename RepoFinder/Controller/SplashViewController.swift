//
//  ViewController.swift
//  RepoFinder
//
//  Created by shehab ahmed on 11/01/2024.
//

import UIKit

class SplshViewController: UIViewController,StoryBoard {
    
    weak var coordinator: MainCoordinator?
    
    @IBOutlet weak var gitLogo: UIImageView!
    
    @IBOutlet weak var appTitleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gitLogo.image = UIImage(named: "gitLogo")
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        animateTitle(label: appTitleLabel, text: "Repo Finder")
        
    }
    
    func animateTitle(label: UILabel, text: String) {
        var animatedText = ""
        let characters = Array(text)
        
        for (index, character) in characters.enumerated() {
            
        DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) * 0.1) {
                animatedText.append(character)
                label.text = animatedText
                
                if index == characters.count - 1 {
                    UIView.transition(with: label, duration: 0.3, options: .transitionCrossDissolve, animations: {
                        label.text = text
                    }, completion:{_ in
                        
                        self.navigateHome()
                    })
                }
            }
        }
    }
    
    
    func navigateHome() {
        delay(seconds: 1.2) {
            self.coordinator?.navigateToRepos()
        }
        
        
    }
}
