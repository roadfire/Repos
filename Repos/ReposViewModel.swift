//
//  ReposViewModel.swift
//  Repos
//
//  Created by Josh Brown on 5/26/15.
//  Copyright (c) 2015 Roadfire Software. All rights reserved.
//

import Foundation

struct ReposViewModel {
    let repositories: [Repository]
    
    init() {
        repositories = [Repository]()
    }
    
    init(repositories: [Repository]?) {
        if let repositories = repositories {
            self.repositories = repositories
        } else {
            self.repositories = [Repository]()
        }
    }

    func fetchRepos(completion: ([Repository]?) -> ()) {
        let client = GitHubClient()
        client.getPopularRepositories { popularRepositories in
            completion(parseRepositories(popularRepositories))
        }
    }
    
    func numberOfItems() -> Int {
        return repositories.count
    }
    
    func titleForItemAtIndexPath(indexPath: NSIndexPath) -> String {
        let repo = repoAtIndexPath(indexPath)
        return repo.name
    }
    
    func descriptionForItemAtIndexPath(indexPath: NSIndexPath) -> String {
        let repo = repoAtIndexPath(indexPath)
        return repo.description
    }
    
    func starsForItemAtIndexPath(indexPath: NSIndexPath) -> String {
        let repo = repoAtIndexPath(indexPath)
        return "★\(repo.starCount)"
    }
    
    private func repoAtIndexPath(indexPath: NSIndexPath) -> Repository {
        return repositories[indexPath.row]
    }
}