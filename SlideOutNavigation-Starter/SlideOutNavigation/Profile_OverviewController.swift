//
//  Profile_OverviewController.swift
//  SlideOutNavigation
//
//  Created by Brent Simmons on 8/10/15.
//  Copyright (c) 2015 Brent Simmons. All rights reserved.
//

import Foundation
import UIKit

class Profile_OverviewController: UIViewController {
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var subHeaderView: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerView.backgroundColor = ColorClass.color_SubHeader()
        subHeaderView.backgroundColor = ColorClass.color_SubHeader()
    }
}