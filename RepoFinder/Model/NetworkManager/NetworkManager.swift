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
    var session: URLSession
       
       init(session: URLSession = URLSession.shared) {
           self.session = session
       }
    
    func fetchData(from url: URL, completion: @escaping (Data?) -> Void) {
        let request = URLRequest(url: url)
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
                return
            }
            
            completion(data)
        }
        
        task.resume()
    }

    func getAllRepos() {
        if let url = URL(string: Constant.REPO_END_POINT) {
            fetchData(from: url) { [weak self] data in
                guard let self = self else { return }
                
                if let safeData = data,
                   let gitHubRepos = self.parseRepo(safeData) {
                    
                    self.BuildRepos(gitHubRepos: gitHubRepos)
                    self.dbManager.deleteAllRepos()
                } else {
                    self.delegate.didFetchError("Failed to fetch data")
                }
            }
        } else {
            delegate.didFetchError("Invalid URL")
        }
    }

    func getRepoCreationDate(endPoint: String,completion: @escaping (String?) -> Void) {
        if let url = URL(string: endPoint) {
            fetchData(from: url) { data in
                if let safeData = data {
                    let stringDate = self.parseDate(safeData)
                    completion(stringDate?.created_at)
                } else {
                    print("Failed to fetch data")
                    completion(nil)
                }
            }
        } else {
            print("Invalid URL")
            completion(nil)
        }
    }
    
    
    func getImageData( imgURL:String , completion: @escaping (Data?) -> Void) {
        guard let url = URL(string: imgURL) else {
            completion(nil)
            return
        }

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
               
                completion(nil)
                return
            }

            if let data = data {
               
                completion(data)
            }
            
        }

        task.resume()
    }
    
    
    private func BuildRepos (gitHubRepos : [RemoteRepo]) {
        
        var reposArr : [Repo] = []
        let group = DispatchGroup()
        
        
        for singleRepo in gitHubRepos {
            group.enter()
            RepoBuilder(networkManager: self, networkRepoObject: singleRepo).build { repo in
                reposArr.append(repo!)
                group.leave()
            }
        }
        group.notify(queue: .main) {
            self.dbManager.cashRepos(repos: reposArr)
            self.delegate.didFetchRepos(reposArr)
                               }
    }
    private func parseData<T: Decodable>(_ data: Data, type: T.Type) -> T? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(type, from: data)
            return decodedData
        } catch {
            delegate.didFetchError("\(error.localizedDescription), JSON")
            return nil
        }
    }

    private func parseRepo(_ reposData: Data) -> [RemoteRepo]? {
        return parseData(reposData, type: [RemoteRepo].self)
    }

    private func parseDate(_ date: Data) -> RepoDate? {
        return parseData(date, type: RepoDate.self)
    }

}
