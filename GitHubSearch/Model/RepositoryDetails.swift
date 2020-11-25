//
//  RepositoryDetails.swift
//  GitHubSearch
//
//  Created by Apple on 24/11/20.
//

import Foundation

struct Actor: Codable {
    let id: Int?
    let login,avatar_url,events_url,followers_url,following_url,gists_url,gravatar_id,html_url,node_id,organizations_url,received_events_url,repos_url,starred_url,subscriptions_url,type,url: String?
    
    enum CodingKeys: String, CodingKey {
        case id,login,avatar_url,events_url,followers_url,following_url,gists_url,gravatar_id,html_url,node_id,organizations_url,received_events_url,repos_url,starred_url,subscriptions_url,type,url
    }
}

struct User: Codable {
    let id: Int?
    let avatar_url,events_url,followers_url,following_url,gists_url,gravatar_id,html_url,node_id,organizations_url,received_events_url,repos_url,starred_url,subscriptions_url,url: String?
    
    enum CodingKeys: String, CodingKey {
        case id,avatar_url,events_url,followers_url,following_url,gists_url,gravatar_id,html_url,node_id,organizations_url,received_events_url,repos_url,starred_url,subscriptions_url,url
    }
}

    
struct Issue: Codable {
    let id: Int?
    let author_association,body,closed_at,comments_url,created_at,events_url,html_url,labels_url,node_id,repository_url,title,updated_at,url,subscriptions_url,type: String?
    let user:User?
    
    enum CodingKeys: String, CodingKey {
        case id,author_association,body,closed_at,comments_url,created_at,events_url,html_url,labels_url,node_id,repository_url,title,updated_at,url,subscriptions_url,type,user
    }
}

struct IssueDetails: Codable {
    let id:Int?
    let actor: Actor?
    let issue:Issue?
    let
        commit_id,commit_url,created_at,node_id,performed_via_github_app,url: String?
    
    enum CodingKeys: String, CodingKey {
        case id,actor,issue,commit_id,commit_url,created_at,node_id,performed_via_github_app,url
    }
}

struct Contributor: Codable {
    let id,contributions:Int?
    let avatar_url,login,events_url,followers_url,following_url,gists_url,gravatar_id,html_url,node_id,organizations_url,received_events_url,repos_url,starred_url,subscriptions_url,url: String?
    
    enum CodingKeys: String, CodingKey {
        case id,contributions,avatar_url,login,events_url,followers_url,following_url,gists_url,gravatar_id,html_url,node_id,organizations_url,received_events_url,repos_url,starred_url,subscriptions_url,url
    }
}
