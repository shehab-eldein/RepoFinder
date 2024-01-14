//
//  ViewController.swift
//  RepoFinder
//
//  Created by shehab ahmed on 11/01/2024.
//

import UIKit

class SplshViewController: UIViewController,StoryBoard {
    
   
    // MARK: - Outlets

    @IBOutlet weak var gitLogo: UIImageView!
    
    @IBOutlet weak var appTitleLabel: UILabel!
    
    // MARK: - Variables

    weak var coordinator: MainCoordinator?
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        gitLogo.image = UIImage(named: Constant.LOGO_IMAGE_NAME)
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        animateTitle(label: appTitleLabel, text: Constant.APP_NAME){
            self.navigateHome()
        }
        
    }
    // MARK: - Functions

    func animateTitle(label: UILabel, text: String, completion: @escaping () -> Void) {
        var animatedText = ""
        let characters = Array(text)
        
        for (index, character) in characters.enumerated() {
            
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) * 0.1) {
                animatedText.append(character)
                label.text = animatedText
                
                if index == characters.count - 1 {
                    UIView.transition(with: label, duration: 0.3, options: .transitionCrossDissolve, animations: {
                        label.text = text
                    }, completion: { _ in
                        completion()
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
