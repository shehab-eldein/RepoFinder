# RepoFinder

App to find different Repos come from GitHub you can visit the repo owner profile and the repo itself on GitHub from the details page 
You can also use the app in offline mode the app has interactive search and  the repos list is paginated (shows 10 by 10 ) 

Architectural pattern: MVC 

Patterns Use: 
 Delegate to transfer data between two classes 
 Coordinator to separate the Navigation Logic 
 Builder to create the repo object because it has an image and date out of the Main Model

Local data:  CoreData

Network Calls: URL Session

FetchImage: Natively without using any pod

Unit Testing For:
  Network Manager 
  Database Manager 
  Coordinator 
  Builder

Naming conventions: All Caps for Constants and Camel Case for the rest
