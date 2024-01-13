//
//  ReposViewController.swift
//  RepoFinder
//
//  Created by shehab ahmed on 11/01/2024.
//

import UIKit


class ReposViewController: UIViewController,StoryBoard,NetworkDelegate {
    
// MARK: - Outlets
    
    @IBOutlet weak var indecator: UIActivityIndicatorView!
    
   
    
    
    @IBOutlet weak var reposTabel: UITableView!
    @IBOutlet weak var findRepoSearchBar: UISearchBar!
    
// MARK: - Var
    weak var coordinator: MainCoordinator?
    let netWorkManager = NetworkingManager()
    let dbManager = DBManager()
    var reposArr : [Repo] = []
    var filteredRepos: [Repo] = []
    var isLoading = true
    var searchText = ""
    var isOffline = false
    var loadedItemCount = 10 {
        didSet{
            isLoading = true
        }
    };

// MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        indecator.startAnimating()
        initRepoTabelView()
        getRepos()
       
       
        
        }
// MARK: - Functions
    func filterRepos(with searchText: String) {
        
        filteredRepos = reposArr.filter { $0.fullName.lowercased().contains(searchText.lowercased()) }
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
// MARK: - Call Back functions
   func didFetchRepos(_ GitRepo: [Repo]) {
       
        print(GitRepo.count)
        reposArr = GitRepo
        DispatchQueue.main.async { [self] in
          
            indecatorHandler(work: false)
            reposTabel.reloadData()
            }
        }
    
    func didFetchError(_ error: String) {
       
        isOffline = true
        reposArr = dbManager.getProductsCash()
       
        DispatchQueue.main.async { [self] in
            
            indecatorHandler(work: false)
            reposTabel.reloadData()
            showInfoPopup(title: "Error", message: error + "This is Last Cashed Data.")
            
          }
        
    }
    
}

// MARK: - Search Bar Extension
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

// MARK: -  Table View Extension
extension ReposViewController : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        isLoading = false
        
        return min(loadedItemCount, searchText.isEmpty ? reposArr.count : filteredRepos.count)
        
                }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.REPO_CELL_ID, for: indexPath) as! RepoCell
        cell.configureCell(gitRepo: searchText.isEmpty ?  reposArr[indexPath.row] : filteredRepos[indexPath.row] )
            return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 120
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
