//
//  DetailsViewController.swift
//  RepoFinder
//
//  Created by shehab ahmed on 11/01/2024.
//

import UIKit

class DetailsViewController: UIViewController,StoryBoard {
    
    
    @IBOutlet weak var ownerNameLabel: UILabel!
    
    @IBOutlet weak var fullNameLabel: UILabel!
   
    @IBOutlet weak var detailsLabel: UILabel!
    
    @IBOutlet weak var ownerImgBackroundView: UIView!
    
    @IBOutlet weak var ownerImg: UIImageView!
    
    
    
    var repoObject: GithubRepository!
    let networkManager = NetworkingManager();
    
    
    
    
    weak var coordinator: MainCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()

        ownerImgBackroundView.addCornerRadius(16)
        ownerImgBackroundView.elevate()
        
       setupDetails()
        
    }
    
    func setupDetails() {
        ownerNameLabel.text = repoObject.owner.login
        fullNameLabel.text = repoObject.fullName
        detailsLabel.text = repoObject.description ?? "There are no Details!"
        fetchImg(imgUrl: repoObject.owner.avatarURL)
        
    }
    func fetchImg(imgUrl: String){
        networkManager.getImageData(imgURL: imgUrl) { imgData in
            if (imgData == nil) {
                DispatchQueue.main.async {
                    self.ownerImg.image =  UIImage(named: "gitLogo")
                }
                
            }else {
                DispatchQueue.main.async {
                    self.ownerImg.image = UIImage(data: imgData!)
                }
               
            }
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
    
    @IBAction func visitLinkTapped(_ sender: UIButton) {
        
        sender.tag == 0 ? openLink(link: repoObject.htmlURL) : openLink(link: repoObject.owner.htmlURL)
        
    }
    
}
