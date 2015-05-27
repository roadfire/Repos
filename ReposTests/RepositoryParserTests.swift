//
//  RepositoryParserTests.swift
//  Repos
//
//  Created by Josh Brown on 5/27/15.
//  Copyright (c) 2015 Roadfire Software. All rights reserved.
//

import UIKit
import XCTest

class RepositoryParserTests: XCTestCase {
    let repositoryDict: [String: AnyObject] = ["name": "Quick", "description": "A testing tool", "stargazers_count": 10]

    func testParseValidRepository() {
        if let repository = parseRepository(repositoryDict) {
            // do assertions
            XCTAssertEqual(repository.name, "Quick", "name should be 'Quick'")
            XCTAssertEqual(repository.description, "A testing tool", "description should be 'A testing tool'")
            XCTAssertEqual(repository.starCount, 10, "star count should be 10")
        } else {
            XCTFail("repository should not be nil")
        }
    }
    
    func testParseRepositories() {
        let repositoriesDicts = [repositoryDict]
        if let repositories = parseRepositories(repositoriesDicts) {
            XCTAssertEqual(repositories.count, 1, "count should be 1")
        } else {
            XCTFail("repositories should not be nil")
        }
    }
}
