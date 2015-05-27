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

    func fetchRepos(completion: (repos: [Repository]?) -> ()) {
        let session = NSURLSession.sharedSession()
        let date = NSCalendar.currentCalendar().dateByAddingUnit(NSCalendarUnit.CalendarUnitDay, value: -30, toDate: NSDate(), options: nil)
        let formatter = NSDateFormatter()
        formatter.dateFormat = "YYYY-MM-dd"
        let urlString = "https://api.github.com/search/repositories?q=created:\">\(formatter.stringFromDate(date!))\"+language:swift+stars:\">=10\"&sort=stars&order=desc".stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
        let url = NSURL(string: urlString)!
        let task = session.dataTaskWithURL(url) { (data, response, error) -> Void in
            if let error = error
            {
                println(error.localizedDescription)
                return
            }
            
            var jsonError: NSError?
            if let json = NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments, error: &jsonError) as? [String: AnyObject],
                let repositoriesJSON = json["items"] as? [[String: AnyObject]]
            {
                completion(repos: parseRepositories(repositoriesJSON))
            }
        }
        
        task.resume()
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