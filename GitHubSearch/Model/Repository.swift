//
//  Repository.swift
//  GitHubSearch
//
//  Created by Apple on 24/11/20.
//

import Foundation

struct Owner : Codable {
    let id: Int?
    let login, node_id, night,avatar_url,url, html_url, followers_url,following_url,gists_url,starred_url,subscriptions_url,organizations_url,repos_url,events_url,received_events_url,type: String?
    let site_admin: Bool?
    
    
    enum CodingKeys: String, CodingKey {
        case id,login, node_id, night,avatar_url,url, html_url, followers_url,following_url,gists_url,starred_url,subscriptions_url,organizations_url,repos_url,events_url,received_events_url,type,site_admin
    }
}

struct Item : Codable {
    let id,size,stargazers_count,watchers_count,forks_count,open_issues_count: Int?
    let node_id,name,full_name,html_url,description,url,forks_url,keys_url,collaborators_url,
        teams_url,hooks_url,issue_events_url,events_url,assignees_url,branches_url,tags_url,blobs_url,git_tags_url,git_refs_url,trees_url,statuses_url,languages_url,stargazers_url,contributors_url,subscribers_url,subscription_url,commits_url,git_commits_url,comments_url,issue_comment_url,contents_url,compare_url,merges_url,archive_url,downloads_url,ssues_url,pulls_url,milestones_url,notifications_url,labels_url,releases_url,deployments_url,created_at,updated_at,pushed_at,git_url,ssh_url,clone_url,svn_url,homepage,language,mirror_url: String?
    let has_issues,has_projects,has_downloads,has_wiki,has_pages,archived,disabled: Bool?
    let owner:Owner?
    
    enum CodingKeys: String, CodingKey {
        case id, node_id,name,full_name,html_url,description,url,forks_url,keys_url,collaborators_url,teams_url,hooks_url,issue_events_url,events_url,assignees_url,branches_url,tags_url,blobs_url,git_tags_url,git_refs_url,trees_url,statuses_url,languages_url,stargazers_url,contributors_url,subscribers_url,subscription_url,commits_url,git_commits_url,comments_url,issue_comment_url,contents_url,compare_url,merges_url,archive_url,downloads_url,ssues_url,pulls_url,milestones_url,notifications_url,labels_url,releases_url,deployments_url,created_at,updated_at,pushed_at,git_url,ssh_url,clone_url,svn_url,homepage,size,stargazers_count,watchers_count,language,has_issues,has_projects,has_downloads,has_wiki,has_pages,forks_count,mirror_url,archived,disabled,open_issues_count,owner
    }
}

struct Repositories: Codable {
    let items: [Item]?
    
    enum CodingKeys: String, CodingKey {
        case items
    }
}
