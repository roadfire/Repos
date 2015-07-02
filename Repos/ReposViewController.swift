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
    var viewModel = ReposViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100.0

        viewModel.fetchRepos { [unowned self] (repos) -> () in
            dispatch_async(dispatch_get_main_queue()) {
                self.viewModel = ReposViewModel(repositories: repos)
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.reloadData()
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! RepoCell
        configureCell(cell, forRowAtIndexPath: indexPath)
        return cell
    }
    
    func configureCell(cell: RepoCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.titleLabel.text = viewModel.titleForItemAtIndexPath(indexPath)
        cell.descriptionLabel.text = viewModel.descriptionForItemAtIndexPath(indexPath)
        cell.starsLabel.text = viewModel.starsForItemAtIndexPath(indexPath)

        if (cell.descriptionLabel.text!).characters.count > 0 {
            cell.descriptionBottomConstraint.constant = 8
        }
        else {
            cell.descriptionBottomConstraint.constant = 0
        }
    }
}

