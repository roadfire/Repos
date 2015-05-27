//
//  DateFormatterTests.swift
//  Repos
//
//  Created by Josh Brown on 5/27/15.
//  Copyright (c) 2015 Roadfire Software. All rights reserved.
//

import UIKit
import XCTest

class DateFormatterTests: XCTestCase {

    func testExample() {
        let components = NSDateComponents()
        components.year = 2015
        components.month = 5
        components.day = 27
        
        let date = NSCalendar.currentCalendar().dateFromComponents(components)!
        let formatter = DateFormatter()
        let formattedDate = formatter.stringFromDate(date)
        
        XCTAssertEqual(formattedDate, "2015-05-27", "expected date to be '2015-05-27'")
    }
}
