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
    let createdDaysAgo = -30
    let minimumStars = 0
    
    func getPopularRepositories(completion: [[String: AnyObject]] -> ()) {
        let date = NSCalendar.currentCalendar().dateByAddingUnit(NSCalendarUnit.Day, value: createdDaysAgo, toDate: NSDate(), options: NSCalendarOptions(rawValue:0))!
        let params = [
            "q": "created:\">\(DateFormatter().stringFromDate(date))\" language:swift stars:\">=\(minimumStars)\"",
            "sort": "stars",
            "order": "desc"
        ]
        
        Alamofire.request(.GET, URLString: searchURL, parameters: params, encoding: .URL).responseJSON(options: NSJSONReadingOptions.AllowFragments) { (request, response, jsonObject, error) -> Void in
            print("request: \(request!.URL)")
            print("request params: \(request!.URL!.parameterString)")
            print("json: \(jsonObject)")
            print("response: \(response)")
            if let error = error
            {
                print(error.localizedDescription)
                return
            }
            
            if let jsonObject = jsonObject as? [String: AnyObject],
                let repositoriesJSON = jsonObject["items"] as? [[String: AnyObject]]
            {
                completion(repositoriesJSON)
            }
        }
    }
}