//
//  GithubRepo.swift
//  RepoFinder
//
//  Created by shehab ahmed on 11/01/2024.
//

import Foundation

struct RemoteRepo: Codable {
    let id: Int
    let nodeID: String
    let name: String
    let fullName: String
    let isPrivate: Bool
    let owner: Owner
    let htmlURL: String
    let description: String?
    let isFork: Bool
    let url: String
    let forksURL: String
    
    enum CodingKeys: String, CodingKey {
        case id, nodeID = "node_id",
             name,
             fullName = "full_name",
             isPrivate = "private",
             owner
        case htmlURL = "html_url",
             description ,
             isFork = "fork" ,
             url,
             forksURL = "forks_url"
    }
}
struct RepoDate: Codable {
    let created_at: String
    
}

