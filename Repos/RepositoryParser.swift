//
//  RepositoryParser.swift
//  Repos
//
//  Created by Josh Brown on 5/27/15.
//  Copyright (c) 2015 Roadfire Software. All rights reserved.
//

import Foundation

func parseRepository(repository: [String: AnyObject]) -> Repository? {
    if let name = repository["name"] as? String,
        description = repository["description"] as? String,
        starCount = repository["stargazers_count"] as? Int
    {
        return Repository(name: name, description: description, starCount: starCount)
    }
    return nil
}

func parseRepositories(repositoriesDicts: [[String: AnyObject]]) -> [Repository]? {
    var repositories = [Repository]()
    for repositoryDict in repositoriesDicts {
        if let repository = parseRepository(repositoryDict) {
            repositories.append(repository)
        }
    }
    return repositories.count > 0 ? repositories : nil
}