//
//  DBManager.swift
//  RepoFinder
//
//  Created by shehab ahmed on 12/01/2024.
//

import Foundation
import UIKit
import CoreData

class DBManager {
    
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
   func cashRepos(repos: [Repo]) {
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext

        for repo in repos {
            let entity = NSEntityDescription.entity(forEntityName: Constant.REPO_ENTITY_NAME, in: context)!
            let repoObj = NSManagedObject(entity: entity, insertInto: context)

            repoObj.setValue(repo.ownerName, forKey: "ownerName")
            repoObj.setValue(repo.fullName, forKey: "fullName")
            repoObj.setValue(repo.details, forKey: "details")
            repoObj.setValue(repo.date, forKey: "date")
            repoObj.setValue(repo.profileUrl, forKey: "profileUrl")
            repoObj.setValue(repo.repoUrl, forKey: "repoUrl")
            repoObj.setValue(repo.image, forKey: "image")
        }

        do {
            try context.save()
            print("Successful Cashed")
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
        
    
    func getProductsCash() -> [Repo]  {

        var repoObject:[NSManagedObject]!
        let context:NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        var repos : [Repo] = []
        let fetchReq = NSFetchRequest<NSManagedObject>(entityName: Constant.REPO_ENTITY_NAME)
        do{
            repoObject = try context.fetch(fetchReq)
            for fav in repoObject{
               
                
    repos.append(Repo(
                    ownerName: fav.value( forKey: "ownerName") as? String ?? "no Name",
                    fullName: fav.value( forKey: "fullName")as? String ?? "no Name",
                    details: fav.value( forKey: "details")as! String ,
                    date: fav.value( forKey: "date")as? String  ?? "no Date",
                    profileUrl: fav.value( forKey: "profileUrl")as? String ?? "",
                    repoUrl:fav.value( forKey: "repoUrl")as? String ?? ""
,
                    image:  (fav.value( forKey: "image")as? Data)))
            }
        }catch let error as NSError{
            print(error.localizedDescription)
            
        }
        
           return repos
        
        
      
    }
    
    
    func deleteAllRepos() {
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext

        let fetchReq = NSFetchRequest<NSFetchRequestResult>(entityName: Constant.REPO_ENTITY_NAME)
        let deleteReq = NSBatchDeleteRequest(fetchRequest: fetchReq)

        do {
            try context.execute(deleteReq)
            print("Successfully deleted all repos")
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
}
