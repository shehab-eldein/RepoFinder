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
    
   
    var repo: GithubRepository!
    
    override func awakeFromNib() {
        super.awakeFromNib()
      
        ownerImg.makeRounded()
        bacGroundView.addCornerRadius(12)
        bacGroundView.elevate()
        
    }
    
    func configureCell (gitRepo: LocalGitRepo ){
        
        //ownerImg.fromURL(url: URL(string: gitRepo.owner.avatarURL)! )
        //handelImage(networkManager: NetworkingManager(), gitRepo: gitRepo)
        ownerName.text = gitRepo.ownerName
        repoDate.text =  gitRepo.date
        repoName.text = gitRepo.fullName
        handelImage(imageData: gitRepo.image)
        //self.repo = gitRepo
        
        }
    
    func configureCashedRepo (cahsedRepo :LocalGitRepo) {
        ownerName.text = cahsedRepo.ownerName
        repoDate.text = cahsedRepo.date
        repoName.text = cahsedRepo.fullName
        ownerImg.image = UIImage(data: cahsedRepo.image!)
        
    }
    
  
//    func saveRepoToDB () {
//        DBManager().saveRepoToDB(repo: LocalGitRepo(ownerName: repo.owner.login, fullName: repo.fullName, details: repo.description ?? " No Details", date: getRandomDateFormattedString(), profileUrl: repo.owner.htmlURL, repoUrl: repo.htmlURL, image: ownerImg.image!.pngData()!))
//    }
    private func handelImage(imageData: Data?){
        if let safeData = imageData {
            ownerImg.image = UIImage(data: safeData)
        } else {
            ownerImg.image = UIImage(named: "gitLogo")
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
