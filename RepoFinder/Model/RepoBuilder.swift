//
//  RepoBuilder.swift
//  RepoFinder
//
//  Created by shehab ahmed on 13/01/2024.
//

import Foundation

class RepoBuilder {
    
     var networkManager: NetworkingManager!
     var networkRepoObject: GithubRepository!
    
    init(networkManager: NetworkingManager , networkRepoObject: GithubRepository) {
        self.networkManager = networkManager
        self.networkRepoObject = networkRepoObject
    }
    
    
    func build (completion: @escaping (LocalGitRepo?) -> Void) {
        
        
        getImg { [self]  data in
            
          var  repo = LocalGitRepo(
            ownerName: networkRepoObject.owner.login,
                fullName: networkRepoObject.fullName,
                details: networkRepoObject.description ?? "No Details",
                date: "Date",
                profileUrl: networkRepoObject.owner.htmlURL,
                repoUrl: networkRepoObject.htmlURL,
                image: data)
            completion(repo)
        }
        
    }
    
    
    func getImg(completion: @escaping (Data?) -> Void) {
       networkManager.getImageData(imgURL: networkRepoObject.owner.avatarURL) { imgData in

            completion(imgData)
        }
    }
    
    
}
