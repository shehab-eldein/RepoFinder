//
//  DBDelegate.swift
//  RepoFinder
//
//  Created by shehab ahmed on 12/01/2024.
//

import Foundation
protocol DBprotocol{
    func saveRepoToDB(product : LocalGitRepo)
    func getRepos() -> [LocalGitRepo]
}
