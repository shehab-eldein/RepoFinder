//
//  RepoBuilder.swift
//  RepoFinder
//
//  Created by shehab ahmed on 13/01/2024.
//

import Foundation

class RepoBuilder {
    
     var networkManager: NetworkingManager!
     var remoteRepo: RemoteRepo!
    
    init(networkManager: NetworkingManager , networkRepoObject: RemoteRepo) {
        self.networkManager = networkManager
        self.remoteRepo = networkRepoObject
    }
    
    
    func build(completion: @escaping (Repo?) -> Void) {
        
        let dispatchGroup = DispatchGroup()
        var imageData: Data?
       
        dispatchGroup.enter()
        getImg { data in
            imageData = data
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) { [self] in
            let repo = Repo(
                ownerName: remoteRepo.owner.login,
                fullName: remoteRepo.fullName,
                details: remoteRepo.description ?? "No Details",
                date: dateFormattedString(),
                profileUrl: remoteRepo.owner.htmlURL,
                repoUrl: remoteRepo.htmlURL,
                image: imageData
            )
           
            completion(repo)
        }
    }

    
    func getImg(completion: @escaping (Data?) -> Void) {
       networkManager.getImageData(imgURL: remoteRepo.owner.avatarURL) { imgData in

           
            completion(imgData)
        }
    }
    
    
    func getDate(completion: @escaping (String?) -> Void) {
        networkManager.getRepoCreationDate(endPoint: remoteRepo.url) { date in
            
           completion(date)
        }
    }
    
    func dateFormattedString() -> String {
           
           let currentDate = Date()
           let randomDays = Int.random(in: 2000...5000)
           if let randomDate = Calendar.current.date(byAdding: .day, value: -randomDays, to: currentDate) {
               let dateFormatter = DateFormatter()
               dateFormatter.dateFormat = "yyyy-MM-dd"

               return dateFormatter.string(from: randomDate)
           } else {
               
               return ""
           }
       }
    
    
    
    
}
