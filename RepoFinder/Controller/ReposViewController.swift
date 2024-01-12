//
//  ReposViewController.swift
//  RepoFinder
//
//  Created by shehab ahmed on 11/01/2024.
//

import UIKit

class ReposViewController: UIViewController,StoryBoard,NetworkDelegate {
    
    @IBOutlet weak var indecator: UIActivityIndicatorView!
    @IBOutlet weak var reposTabel: UITableView!
    @IBOutlet weak var findRepoSearchBar: UISearchBar!
    
    
    weak var coordinator: MainCoordinator?
    let netWorkManager = NetworkingManager()
    var reposArr : [GithubRepository] = []
    var filteredRepos: [GithubRepository] = []
    var isLoading = true
    var searchText = ""
    var loadedItemCount = 10 {
        didSet{
            isLoading = true
        }
    };


    override func viewDidLoad() {
        super.viewDidLoad()
        
        indecator.startAnimating()
        initRepoTabelView()
        getRepos()
        
        
        
    }
    
    func filterRepos(with searchText: String) {
        
        filteredRepos = reposArr.filter { $0.name.lowercased().contains(searchText.lowercased()) }
           reposTabel.reloadData()
       }
    func getRepos() {
        
        netWorkManager.delegate = self
        netWorkManager.getAllRepos()
    }
    
    func initRepoTabelView() {
        reposTabel.register(UINib(nibName: Constant.REPO_NIB_NAME, bundle: nil), forCellReuseIdentifier:Constant.REPO_CELL_ID )
        reposTabel.delegate = self
        reposTabel.dataSource = self
        
    }
    
    func indecatorHandler(work: Bool) {
        
        if(work) {
            indecator.startAnimating()
            indecator.isHidden = false
            isLoading = true
        }else{
            indecator.stopAnimating()
            indecator.isHidden = true
            isLoading = false
        }
    }
    
    func didFetchRepos(_ GitRepo: [GithubRepository]) {
        reposArr = GitRepo
        DispatchQueue.main.async { [self] in
          
            indecatorHandler(work: false)
            reposTabel.reloadData()
            }
        }
    
    func didFetchError(_ error: String) {
        //show pop up
        print("Error Enter")
        print(error)
    }
    
   

   

}

extension ReposViewController: UISearchBarDelegate {
    
    
   func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchText = searchText
        filterRepos(with: searchText)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
        filterRepos(with: "")
        self.searchText = ""
    }
}

extension ReposViewController : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        isLoading = false
        
        return min(loadedItemCount, searchText.isEmpty ? reposArr.count : filteredRepos.count)
        
                
        
      }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.REPO_CELL_ID, for: indexPath) as! RepoCell
        cell.configureCell(networkManager: netWorkManager, gitRepo: searchText.isEmpty ?  reposArr[indexPath.row] : filteredRepos[indexPath.row] )

            return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let screenHeight = UIScreen.main.bounds.height
        let rowHeight = screenHeight / 8
        return rowHeight
    }
     func scrollViewDidScroll(_ scrollView: UIScrollView) {
         
         let height = scrollView.frame.size.height
             let contentYoffset = scrollView.contentOffset.y
             let distanceFromBottom = scrollView.contentSize.height - contentYoffset
         if (distanceFromBottom < height && !isLoading) {
               indecatorHandler(work: true)
                loadedItemCount+=10
                delay(seconds: 2){ [self] in
                    indecatorHandler(work: false)
                    reposTabel.reloadData()
                    
                }
            
               
            }
        }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
      
        
        coordinator?.navigateToDetails(gitRepos: searchText.isEmpty ? reposArr[indexPath.row]:filteredRepos[indexPath.row])
    }
    
    
}
