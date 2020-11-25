//
//  APIClient.swift
//  GitHubSearch
//
//  Created by Apple on 24/11/20.
//

import Foundation
import CoreData
import UIKit

class APIClient: NSObject {
    func fetchRepoList(apiName: String, paramaters: String, completion: @escaping (Any?) -> Void) {
        var urlStr = ""
        switch apiName {
        case "Search":
            urlStr = "https://api.github.com/search/repositories?q=topic:\(paramaters)"
            break
        case "Issue":
            urlStr = "https://api.github.com/repos/\(paramaters)/issues/events"
            break
        case "Contributors":
            urlStr = "https://api.github.com/repos/\(paramaters)/contributors?q=contributions&order=desc"
            break
        default:
            break
        }
        let headers = [
            "Content-Type":"application/json",
            "Accept":"application/json"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: urlStr)! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { [self] (data, response, error) -> Void in
            if (error != nil) {
                print(error)
            } else {
                let httpResponse = response as? HTTPURLResponse
                do {
                    let data1 = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                    print("augsuygdugauygduya",urlStr,data1)
                    switch apiName {
                    case "Search":
                        let jsonData = try  JSONDecoder().decode(Repositories.self
                                                                 , from: data!)
                        
                        completion(jsonData)
                        break
                    case "Issue":
                        let jsonData = try  JSONDecoder().decode([IssueDetails].self
                                                                 , from: data!)
                        
                        completion(jsonData)
                        break
                    case "Contributors":
                        let jsonData = try  JSONDecoder().decode([Contributor].self
                                                                 , from: data!)
                        
                        completion(jsonData)
                        break
                    default:
                        break
                    }
                    
                    
                } catch let error {
                    print(error)
                }
            }
        })

        dataTask.resume()
    }
        
}
