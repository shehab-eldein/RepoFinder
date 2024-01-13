//
//  NetworkManager.swift
//  RepoFinder
//
//  Created by shehab ahmed on 11/01/2024.
//

import Foundation
import Foundation
import UIKit

class NetworkingManager{
    
    var delegate: NetworkDelegate!
    let dbManager = DBManager()
    
    func getAllRepos ()  {
        if let url = URL(string: Constant.REPO_END_POINT) {
            let request = URLRequest(url: url)
            let session = URLSession(configuration: .default)
            
            let task =  session.dataTask   (with: request){ [self]
                (data, response, error) in
                if error != nil{
                    delegate.didFetchError(error?.localizedDescription ?? "Unkown Error")
                    return
                }
                if let safeData = data {
                   if let gitHubRepos =  parseJSON(safeData){
                       dbManager.deleteAllRepos()
                       BuildRepos(gitHubRepos: gitHubRepos)
                    
                    }
                }
            }
            task.resume()
        } else {
            delegate.didFetchError("Invalid URL")
        }
        
    }
    
    private func BuildRepos (gitHubRepos : [GithubRepository]) {
        
        var reposArr : [LocalGitRepo] = []
        let group = DispatchGroup()
        
        
        for singleRepo in gitHubRepos {
            group.enter()
            RepoBuilder(networkManager: self, networkRepoObject: singleRepo).build { repo in
                reposArr.append(repo!)
                group.leave()
            }
        }
        group.notify(queue: .main) {
            self.dbManager.saveReposToDB(repos: reposArr)
            self.delegate.didFetchRepos(reposArr)
                               }
    }
    
    private func parseJSON(_ reposData : Data) -> [GithubRepository]? {
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode([GithubRepository].self, from: reposData)
            return decodedData
            
        } catch {
            delegate.didFetchError("\(error.localizedDescription),JSON")
            return nil
        }
    }
    
    
    func getImageData( imgURL:String , completion: @escaping (Data?) -> Void) {
        guard let url = URL(string: imgURL) else {
            completion(nil)
            return
        }

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
               
                completion(nil)
                return
            }

            if let data = data {
               
                completion(data)
            }
        }

        task.resume()
    }

}
