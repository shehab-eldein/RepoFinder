//
//  DetailsViewController.swift
//  RepoFinder
//
//  Created by shehab ahmed on 11/01/2024.
//

import UIKit

class DetailsViewController: UIViewController,StoryBoard {
    
// MARK: - Outlets

    @IBOutlet weak var ownerNameLabel: UILabel!
    
    @IBOutlet weak var fullNameLabel: UILabel!
   
    @IBOutlet weak var detailsLabel: UILabel!
    
    @IBOutlet weak var ownerImgBackroundView: UIView!
    
    @IBOutlet weak var ownerImg: UIImageView!
    
    
// MARK: - Var

    var repoObject: LocalGitRepo!
    weak var coordinator: MainCoordinator?

// MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()

        ownerImgBackroundView.addCornerRadius(16)
        ownerImgBackroundView.elevate()
        
       setupDetails()
        
    }
    
// MARK: - Functions

    func setupDetails() {
        ownerNameLabel.text = repoObject.ownerName
        fullNameLabel.text = repoObject.fullName
        detailsLabel.text = repoObject.details
        handelImage(imageData: repoObject.image)
        
    }
    
    private func handelImage(imageData: Data?){
        if let safeData = imageData {
            ownerImg.image = UIImage(data: safeData)
        } else {
            ownerImg.image = UIImage(named: "gitLogo")
        }
        }

    
    
    
    func openLink(link:String){
        if let url = URL(string: link) {
                    UIApplication.shared.open(url, options: [:]) { success in
                        if success {
                            print("Link opened successfully.")
                        } else {
                            //pop up
                            print("Unable to open the link.")
                        }
                    }
                }
    }
    
// MARK: - Actions

    @IBAction func visitLinkTapped(_ sender: UIButton) {
        
        sender.tag == 0 ? openLink(link: repoObject.repoUrl) : openLink(link: repoObject.profileUrl)
        
    }
    
}
