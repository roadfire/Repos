//
//  DateFormatterTests.swift
//  Repos
//
//  Created by Josh Brown on 5/27/15.
//  Copyright (c) 2015 Roadfire Software. All rights reserved.
//

import Quick
import Nimble

class DateFormatterTests: QuickSpec {
    override func spec() {
        it("formats dates for the server") {
            let components = NSDateComponents()
            components.year = 2015
            components.month = 5
            components.day = 27
            
            let date = NSCalendar.currentCalendar().dateFromComponents(components)!
            let formatter = DateFormatter()
            let formattedDate = formatter.stringFromDate(date)
            
            expect(formattedDate).to(equal("2015-05-27"))
        }
    }
}
