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
    
   
    var repo: RemoteRepo!
    
    override func awakeFromNib() {
        super.awakeFromNib()
      
      
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    
    func configureCell (gitRepo: Repo ){
        
        
        ownerName.text = gitRepo.ownerName
        repoDate.text =  gitRepo.date
        repoName.text = gitRepo.fullName
        handelImage(imageData: gitRepo.image)
       
        
        }
    
  
    
  

    private func handelImage(imageData: Data?){
        ownerImg.makeRounded()
        bacGroundView.addCornerRadius(12)
        bacGroundView.elevate()
        if let safeData = imageData {
            ownerImg.image = UIImage(data: safeData)
        } else {
            ownerImg.image = UIImage(named: "gitLogo")
        }
        }

   
   


   
}
