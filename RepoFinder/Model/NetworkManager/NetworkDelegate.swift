//
//  NetworkDelegate.swift
//  RepoFinder
//
//  Created by shehab ahmed on 11/01/2024.
//

import Foundation
protocol NetworkDelegate {
    func didFetchRepos(_ Repos: [Repo])
    func didFetchError (_ error: String)
}
