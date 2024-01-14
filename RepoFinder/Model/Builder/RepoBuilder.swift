//
//  RepoBuilder.swift
//  RepoFinder
//
//  Created by shehab ahmed on 13/01/2024.
//

import Foundation

// **** Important Note *********
// The Date come from url in the Mainmodel that meaning you need to make call for every object to get the date i make all this logic but the server when i try to make many calls on short time it block my IP for some minutes and give me only message in respone that tell me the IP is blocked maybe it deal with me as DOS attack in this case i generate random Dates to handle the date because i'm not have any backend support to handle it

//*** Server Response ***
//"message":"API rate limit exceeded for 156.204.217.135. (But here's the good news: Authenticated requests get a higher rate limit. Check out the documentation for more details.)","documentation_url":"https://docs.github.com/rest/overview/resources-in-the-rest-api#rate-limiting

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
        
//        dispatchGroup.enter()
//        getDate { date in
//            stringDate = date
//            dispatchGroup.leave()
//        }
        
        dispatchGroup.notify(queue: .main) { [self] in
            let repo = Repo(
                ownerName: remoteRepo.owner.login,
                fullName: remoteRepo.fullName,
                details: remoteRepo.description ?? "No Details",
                date:   self.dateFormattedString(),
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
    
    
    
    //Real function to get real date
    func getDate(completion: @escaping (String?) -> Void) {
        networkManager.getRepoCreationDate(endPoint: remoteRepo.url) { date in
            
           completion(date)
        }
    }
    
   //Fake Function to generate Dates
    func dateFormattedString() -> String {
           
           let currentDate = Date()
           let randomDays = Int.random(in: 4000...7000)
           if let randomDate = Calendar.current.date(byAdding: .day, value: -randomDays, to: currentDate) {
               let dateFormatter = DateFormatter()
               dateFormatter.dateFormat = "MMM dd, yyyy"
              return dateFormatter.string(from: randomDate)
           } else {
               
               return ""
           }
       }
    
    
    
    
}
