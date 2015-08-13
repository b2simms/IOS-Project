//
//  ClaimHistoryExpandableCell.swift
//  SlideOutNavigation
//
//  Created by Brent Simmons on 8/6/15.
//  Copyright (c) 2015 Brent Simmons. All rights reserved.
//

import Foundation
import UIKit

class ClaimHistoryExpandableCell {
    
    var benefit, claimant, coverage, paid : String?
    
    var serviceDate, receivedDate, payInfo : String?
    
    var date : String?
    
    var isDateSet : Bool = false
    
    init(benefit: String, claimant: String, coverage: String, paid: String, serviceDate: String, receivedDate: String, payInfo: String){
        self.benefit = benefit
        self.claimant = claimant
        self.coverage = coverage
        self.paid = paid
        self.serviceDate = serviceDate
        self.receivedDate = receivedDate
        self.payInfo = payInfo
    }
    
    init(date: String){
        self.date = date
        self.isDateSet = true
    }
}