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
        let url = NSURL(string: "https://api.github.com/orgs/researchkit/repos")!
        let task = session.dataTaskWithURL(url, completionHandler: { [unowned self] (data, response, error) -> Void in
            if let error = error
            {
                println(error.localizedDescription)
                return
            }
            
            var jsonError: NSError?
            if let jsonArray = NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments, error: &jsonError) as? [[String: AnyObject]]
            {
                self.repos = jsonArray
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
        
        cell.titleLabel.text = repos[indexPath.row]["name"] as? String
        cell.descriptionLabel.text = repos[indexPath.row]["description"] as? String
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") as! RepoCell
        cell.titleLabel.text = repos[indexPath.row]["name"] as? String
        cell.descriptionLabel.text = repos[indexPath.row]["description"] as? String
        cell.bounds = CGRectMake(0.0, 0.0, CGRectGetWidth(self.tableView.bounds), CGRectGetHeight(cell.bounds));
        cell.layoutIfNeeded()
        let height = cell.contentView.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize).height + 1
        return height
    }
}

