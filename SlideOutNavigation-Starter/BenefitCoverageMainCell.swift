//
//  BenefitCoverageMainCell.swift
//  SlideOutNavigation
//
//  Created by Brent Simmons on 8/5/15.
//  Copyright (c) 2015 Brent Simmons. All rights reserved.
//

import Foundation
import UIKit

class BenefitCoverageMainCell {
    
    let benefit, carrier, policy, date, coverage: String
    
    init(benefit: String, carrier: String, policy: String, date: String, coverage: String){
        self.benefit = benefit
        self.carrier = carrier
        self.policy = policy
        self.date = date
        self.coverage = coverage
    }
}