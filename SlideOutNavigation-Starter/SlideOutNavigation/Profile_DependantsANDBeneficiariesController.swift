//
//  Profile_DependantsANDBeneficiariesController.swift
//  SlideOutNavigation
//
//  Created by Brent Simmons on 8/10/15.
//  Copyright (c) 2015 Brent Simmons. All rights reserved.
//

import Foundation
import UIKit

class Profile_DependentsANDBeneficiariesController: UIViewController {
    
    @IBOutlet weak var dependentHeader: UILabel!
    @IBOutlet weak var beneficiaryHeader: UILabel!
    @IBOutlet weak var benefitSubHeader: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dependentHeader.backgroundColor = ColorClass.color_SubHeader()
        beneficiaryHeader.backgroundColor = ColorClass.color_SubHeader()
        benefitSubHeader.backgroundColor = ColorClass.color_SubHeader()
    }
}