//
//  CenterViewController.swift
//  SlideOutNavigation
//
//  Created by Brent Simmons on 8/4/15.
//  Copyright (c) 2015 Brent Simmons. All rights reserved.
//

import UIKit

enum SlideOutState {
    case BothCollapsed
    case LeftPanelExpanded
}

@objc
protocol CenterViewControllerDelegate {
  optional func toggleLeftPanel()
  optional func collapseSidePanels()
}




class CenterViewController: UIViewController {
    
    let PROFILE = "Profile"
    let CLAIMSHISTORY = "Claims History"
    let BENEFITCOVERAGE = "Benefit Coverage"
    let DOCUMENTS = "Documents"
    let STORYBOARDID_PROFILE = "ProfileViewController"
    let STORYBOARDID_CLAIMSHISTORY = "ClaimsHistoryController"
    let STORYBOARDID_BENEFITCOVERAGE = "BenefitCoverageController"
    let STORYBOARDID_DOCUMENTS = "DocumentsController"
  
    @IBOutlet weak var titleLabel: UINavigationItem!

    var delegate: CenterViewControllerDelegate?

    @IBOutlet weak var containerView: CenterViewContainer!

    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: ColorClass.color_Purple()]
        self.navigationController?.navigationBar.barTintColor = ColorClass.color_TealGreen()
        
        menuButton.tintColor = ColorClass.color_Purple()
    }

    @IBAction func menuTapped(sender: AnyObject) {
    delegate?.toggleLeftPanel!()
    }
    
    func clearSubviews(){
        //CLEAR existing subviews in container
        for subView in containerView.subviews as! [UIView] {
            subView.removeFromSuperview()
        }
    }
    
    func setInnerContainerView(containerName : String) {
        clearSubviews()
        var newView: UIViewController = storyboard!.instantiateViewControllerWithIdentifier(containerName) as! UIViewController
        containerView.addSubview(newView.view)
        self.addChildViewController(newView)
    }
  
}


extension CenterViewController: SidePanelViewControllerDelegate {
    
    func menuSelected(items: MainMenu) {
        
        delegate?.collapseSidePanels?()
        
        switch items.title {
        case PROFILE:
            titleLabel.title = PROFILE
            setInnerContainerView(STORYBOARDID_PROFILE)
        case CLAIMSHISTORY:
            titleLabel.title = CLAIMSHISTORY
            setInnerContainerView(STORYBOARDID_CLAIMSHISTORY)
        case BENEFITCOVERAGE:
            titleLabel.title = BENEFITCOVERAGE
            setInnerContainerView(STORYBOARDID_BENEFITCOVERAGE)
        case DOCUMENTS:
            titleLabel.title = DOCUMENTS
            setInnerContainerView(STORYBOARDID_DOCUMENTS)
        default:
            break
        }
        
    }
        
}