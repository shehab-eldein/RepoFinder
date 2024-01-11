//
//  ReposViewController.swift
//  RepoFinder
//
//  Created by shehab ahmed on 11/01/2024.
//

import UIKit

class ReposViewController: UIViewController,StoryBoard,NetworkDelegate,UITableViewDelegate,UITableViewDataSource {
    
    
    @IBOutlet weak var ReposTabel: UITableView!
    
    
    weak var coordinator: MainCoordinator?
    let netWorkManager = NetworkingManager()
    var reposArr : [GithubRepository] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        netWorkManager.delegate = self
        netWorkManager.getAllRepos()
        // Do any additional setup after loading the view.
    }
    
    func didFetchRepos(_ GitRepo: [GithubRepository]) {
        reposArr = GitRepo
        print(reposArr[10].description ?? "No Description")
        
    }
    
    func didFetchError(_ error: String) {
        //show pop up
        print("Error Enter")
        print(error)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        reposArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }

   

}
