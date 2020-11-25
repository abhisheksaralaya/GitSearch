//
//  ViewModel.swift
//  GitHubSearch
//
//  Created by Apple on 24/11/20.
//

import Foundation
import Network
import UIKit
import CoreData

class RepositoryViewModel: NSObject {
    @IBOutlet var apiClient: APIClient!
    
    var repositoryData: Repositories?
    var issues: [IssueDetails]?
    var contributors: [Contributor]?
    
    func getData(apiName: String, paramaters: String,completion: @escaping () -> Void) {
        let monitor = NWPathMonitor()
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { [self] path in
            if path.status == .satisfied {
                self.apiClient.fetchRepoList(apiName: apiName, paramaters: paramaters, completion: { (data) in
                    DispatchQueue.main.async {
                        switch apiName {
                        case "Search":
                            self.repositoryData = data as? Repositories
                            break
                        case "Issue":
                            self.issues = data as? [IssueDetails]
                            break
                        case "Contributors":
                            self.contributors = data as? [Contributor]
                            break
                        default:
                            break
                        }
                        monitor.cancel()
                        completion()
                    }
                })
            } else {
                //No Internet
            }
        }
    }
    
    func repoNumbers()-> Int {
        if let repositoryData = repositoryData, let items = repositoryData.items {
            return items.count
        } else {
            return 0
        }
    }
    
    func repoName(indexPath:IndexPath)-> String {
        if let repositoryData = repositoryData, let items = repositoryData.items, let name = items[indexPath.row].name {
            return name
        } else {
            return ""
        }
    }
    
    func fullName(indexPath:IndexPath)-> String {
        if let repositoryData = repositoryData, let items = repositoryData.items, let name = items[indexPath.row].full_name {
            return name
        } else {
            return ""
        }
    }
    
    func description(indexPath:IndexPath)-> String {
        if let repositoryData = repositoryData, let items = repositoryData.items, let description = items[indexPath.row].description {
            return description
        } else {
            return ""
        }
    }
    
    func numberOfContributors() -> Int? {
        return contributors?.count
    }
    
    
    func numberOfIssues() -> Int? {
        return issues?.count
    }
    
    
    func numberOfSections() -> Int? {
        var count = 0
        if issues?.count ?? 0 > 0 {
            count += 1
        }
        if contributors?.count ?? 0 > 0 {
            count += 1
        }
        return count
    }
    
    func issueTitle(indexPath:IndexPath)-> String {
        if let issueData = issues, let issue = issueData[indexPath.row].issue, let title = issue.title {
            return title
        } else {
            return ""
        }
    }
    
    func contributorLogin(indexPath:IndexPath)-> String {
        if let contributorData = contributors, let login = contributorData[indexPath.row].login {
            return login
        } else {
            return ""
        }
    }
    
    
    func issue(indexPath:IndexPath)-> Issue? {
        if let issueData = issues, let issue = issueData[indexPath.row].issue {
            return issue
        } else {
            return nil
        }
    }
    
    func contributor(indexPath:IndexPath)-> Contributor? {
        if let contributorData = contributors {
            return contributorData[indexPath.row]
        } else {
            return nil
        }
    }
    
}
