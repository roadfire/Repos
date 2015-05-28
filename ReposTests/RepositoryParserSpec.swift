//
//  RepositoryParserTests.swift
//  Repos
//
//  Created by Josh Brown on 5/27/15.
//  Copyright (c) 2015 Roadfire Software. All rights reserved.
//

import Quick
import Nimble

class RepositoryParserSpec: QuickSpec {
    override func spec() {
        describe("parse repository") {
            context("given a dictionary representing a repository") {
                let repositoryDict = self.createNewRepository()
                
                let repository = parseRepository(repositoryDict)
                
                it("should have the correct name") {
                    expect(repository!.name).to(equal("Quick"))
                }
                
                it("should have the correct description") {
                    expect(repository!.description).to(equal("A testing tool"))
                }
                
                it("should have the correct star count") {
                    expect(repository!.starCount).to(equal(10))
                }
            }
        }
        
        describe("parse repositories") {
            context("given a list of repository dictionaries") {
                let repositoriesDicts = [self.createNewRepository()]
                let repositories = parseRepositories(repositoriesDicts)
                it("should produce an array of the proper size") {
                    expect(repositories!.count).to(equal(1))
                }
            }
        }
    }
    
    func createNewRepository() -> [String: AnyObject] {
        return ["name": "Quick", "description": "A testing tool", "stargazers_count": 10]
    }
}
