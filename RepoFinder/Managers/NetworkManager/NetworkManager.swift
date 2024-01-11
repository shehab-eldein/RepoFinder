//
//  NetworkManager.swift
//  RepoFinder
//
//  Created by shehab ahmed on 11/01/2024.
//

import Foundation
import Foundation

class NetworkingManager{
    
    var delegate: NetworkDelegate!
    
    func getAllRepos ()  {
        if let url = URL(string: Constant.repoEndPoint) {
            let request = URLRequest(url: url)
            let session = URLSession(configuration: .default)
            let task =  session.dataTask   (with: request){
                (data, response, error) in
                if error != nil{
                    self.delegate.didFetchError(error?.localizedDescription ?? "Unkown Error")
                    return
                }
                if let safeData = data {
                    print("SAFE DATA")
                   if let gitHubRepos =  self.parseJSON(safeData){
                        self.delegate.didFetchRepos(gitHubRepos)
                    }
                }
            }
            task.resume()
        } else {
            delegate.didFetchError("Invalid URL")
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
}