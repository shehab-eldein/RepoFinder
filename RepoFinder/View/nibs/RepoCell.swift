//
//  RepoCell.swift
//  RepoFinder
//
//  Created by shehab ahmed on 11/01/2024.
//

import UIKit

class RepoCell: UITableViewCell {
    @IBOutlet weak var bacGroundView: UIView!
    
    @IBOutlet weak var ownerImg: UIImageView!
    
    @IBOutlet weak var ownerName: UILabel!
    
    @IBOutlet weak var repoDate: UILabel!
    
    @IBOutlet weak var repoName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        ownerImg.makeRounded()
        bacGroundView.addCornerRadius(12)
        bacGroundView.elevate()
    }
    
    func configureCell (networkManager: NetworkingManager, gitRepo: GithubRepository ){
        
       handelImage(networkManager: networkManager, gitRepo: gitRepo)
        ownerName.text = gitRepo.owner.login
        repoDate.text = getRandomDateFormattedString()
        repoName.text = gitRepo.name
        
    }
    
   private func handelImage(networkManager: NetworkingManager, gitRepo: GithubRepository){
        
       networkManager.getImageData(imgURL: gitRepo.owner.avatarURL){  imgData
           in
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
   

    func getRandomDateFormattedString() -> String {
        
        let currentDate = Date()

        let randomDays = Int.random(in: 1...2000)

        if let randomDate = Calendar.current.date(byAdding: .day, value: -randomDays, to: currentDate) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"

            return dateFormatter.string(from: randomDate)
        } else {
            
            return ""
        }
    }
   


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
