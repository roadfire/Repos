//
//  DateFormatter.swift
//  Repos
//
//  Created by Josh Brown on 5/27/15.
//  Copyright (c) 2015 Roadfire Software. All rights reserved.
//

import Foundation

struct DateFormatter {
    static let formatter: NSDateFormatter = {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "YYYY-MM-dd"
        return formatter
    }()
    
    func stringFromDate(date: NSDate) -> String {
        return DateFormatter.formatter.stringFromDate(date)
    }
}