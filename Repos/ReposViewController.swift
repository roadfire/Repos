//
//  ViewController.swift
//  Repos
//
//  Created by Josh Brown on 5/15/15.
//  Copyright (c) 2015 Roadfire Software. All rights reserved.
//

import UIKit

class ReposViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var tableView: UITableView!
    var repos = [[String: AnyObject]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension

        let session = NSURLSession.sharedSession()
        
        let date = NSCalendar.currentCalendar().dateByAddingUnit(NSCalendarUnit.CalendarUnitDay, value: -30, toDate: NSDate(), options: nil)
        let formatter = NSDateFormatter()
        formatter.dateFormat = "YYYY-MM-dd"
        let urlString = "https://api.github.com/search/repositories?q=created:\">\(formatter.stringFromDate(date!))\"+language:swift+stars:\">=10\"&sort=stars&order=desc".stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
        let url = NSURL(string: urlString)!
        let task = session.dataTaskWithURL(url, completionHandler: { [unowned self] (data, response, error) -> Void in
            if let error = error
            {
                println(error.localizedDescription)
                return
            }
            
            var jsonError: NSError?
            if let json = NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments, error: &jsonError) as? [String: AnyObject],
            let repositories = json["items"] as? [[String: AnyObject]]
            {
                self.repos = repositories
                dispatch_async(dispatch_get_main_queue()) {
                    self.tableView.reloadData()
                }
            }
        })
        
        task.resume()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.reloadData()
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repos.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! RepoCell
        configureCell(cell, forRowAtIndexPath: indexPath)
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") as! RepoCell
        configureCell(cell, forRowAtIndexPath: indexPath)
        cell.bounds = CGRectMake(0.0, 0.0, CGRectGetWidth(self.tableView.bounds), CGRectGetHeight(cell.bounds));
        cell.layoutIfNeeded()
        let height = cell.contentView.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize).height + 1
        return height
    }
    
    func configureCell(cell: RepoCell, forRowAtIndexPath indexPath: NSIndexPath) {
        let repo = repos[indexPath.row]
        cell.titleLabel.text = repo["name"] as? String
        cell.descriptionLabel.text = repo["description"] as? String
        
        if let stars = repo["stargazers_count"] as? Int {
            cell.starsLabel.text = "\(stars) stars"
        }
        else {
            cell.starsLabel.text = ""
        }
        
        if count(cell.descriptionLabel.text!) > 0 {
            cell.descriptionBottomConstraint.constant = 8
        }
        else {
            cell.descriptionBottomConstraint.constant = 0
        }
    }
}

