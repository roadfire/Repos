//
//  GitHubClient.swift
//  Repos
//
//  Created by Josh Brown on 5/27/15.
//  Copyright (c) 2015 Roadfire Software. All rights reserved.
//

import Foundation
import Alamofire

struct GitHubClient {
    let searchURL = "https://api.github.com/search/repositories"
    let createdDaysAgo = 30
    let minimumStars = 10
    
    func getPopularRepositories(completion: [[String: AnyObject]] -> ()) {
        let session = NSURLSession.sharedSession()
        let date = NSCalendar.currentCalendar().dateByAddingUnit(NSCalendarUnit.CalendarUnitDay, value: -createdDaysAgo, toDate: NSDate(), options: nil)!
        let params = [
            "q": "created:\">\(DateFormatter().stringFromDate(date))\" language:swift stars:\">=\(minimumStars)\"",
            "sort": "stars",
            "order": "desc"
        ]
        
        Alamofire.request(.GET, searchURL, parameters: params, encoding: .URL).responseJSON(options: .allZeros) { (request, response, jsonObject, error) -> Void in
            println("request: \(request.URL)")
            println("request params: \(request.URL!.parameterString)")
            println("json: \(jsonObject)")
            println("response: \(response)")
            if let error = error
            {
                println(error.localizedDescription)
                return
            }
            
            var jsonError: NSError?
            if let jsonObject = jsonObject as? [String: AnyObject],
                let repositoriesJSON = jsonObject["items"] as? [[String: AnyObject]]
            {
                if let jsonError = jsonError {
                    println(jsonError.localizedDescription)
                } else {
                    completion(repositoriesJSON)
                }
            }
        }
    }
}