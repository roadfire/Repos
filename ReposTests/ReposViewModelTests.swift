//
//  ReposViewModelTests.swift
//  Repos
//
//  Created by Josh Brown on 5/26/15.
//  Copyright (c) 2015 Roadfire Software. All rights reserved.
//

import UIKit
import XCTest
import Repos

class ReposViewModelTests: XCTestCase {
    
    let viewModel = ReposViewModel(repositories:
        [Repository(name: "Tetris", description: "A fun game", starCount: 100)])
    
    func testNumberOfItems() {
        XCTAssertEqual(1, viewModel.numberOfItems(), "expected number of items to be 1")
    }

    func testTitleForItemAtIndexPath() {
        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        XCTAssertEqual(viewModel.titleForItemAtIndexPath(indexPath), "Tetris", "expected title to be Tetris")
    }
    
    func testDescriptionForItemAtIndexPath() {
        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        XCTAssertEqual(viewModel.descriptionForItemAtIndexPath(indexPath), "A fun game", "expected description to be 'A fun game'")
    }
    
    func testStarsForItemAtIndexPath() {
        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        XCTAssertEqual(viewModel.starsForItemAtIndexPath(indexPath), "★100", "expected stars to be '★100'")
    }
}
