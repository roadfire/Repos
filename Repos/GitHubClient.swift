//
//  GitHubClient.swift
//  Repos
//
//  Created by Josh Brown on 5/27/15.
//  Copyright (c) 2015 Roadfire Software. All rights reserved.
//

import Foundation

struct GitHubClient {
    let searchURL = "https://api.github.com/search/repositories"
    let createdDaysAgo = 30
    let minimumStars = 10
    
    func getPopularRepositories(completion: [[String: AnyObject]] -> ()) {
        let session = NSURLSession.sharedSession()
        let date = NSCalendar.currentCalendar().dateByAddingUnit(NSCalendarUnit.CalendarUnitDay, value: -createdDaysAgo, toDate: NSDate(), options: nil)!
        let formatter = DateFormatter()
        let urlString = "\(searchURL)?q=created:\">\(formatter.stringFromDate(date))\"+language:swift+stars:\">=\(minimumStars)\"&sort=stars&order=desc".stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
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
                completion(repositoriesJSON)
            }
        }
        
        task.resume()
    }
}