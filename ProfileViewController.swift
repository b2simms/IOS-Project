//
//  ProfileViewController.swift
//  SlideOutNavigation
//
//  Created by Brent Simmons on 8/4/15.
//  Copyright (c) 2015 Brent Simmons. All rights reserved.
//

import Foundation
import UIKit

@objc
protocol ProfileViewControllerDelegate {
    func changeContainerToContactController()
    func changeContainerToEditController()
}

class ProfileViewController: UIViewController {
    @IBOutlet weak var greenSpacer: UILabel!
    
    @IBOutlet weak var segmentedController: UISegmentedControl!
    @IBOutlet weak var profileContainerView: UIView!
    
    let OVERVIEW = "Overview"
    let CONTACT = "Contact/Employer"
    let DEPENDENTS = "Dependents/Beneficiaries"
    let PARSEDOVER = "Overview"
    let PARSEDCON = "Con/Emp"
    let PARSEDDEP = "Dep/Ben"
    let STORYBOARDID_OVERVIEW = "Profile_OverviewController"
    let STORYBOARDID_CONTACT = "Profile_ContactsANDEmployerController"
    let STORYBOARDID_EDIT = "Profile_EDITContactController"
    let STORYBOARDID_DEPENDENT = "Profile_DependentsANDBeneficiariesController"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        segmentedController.setTitle(PARSEDDEP, forSegmentAtIndex: 0)
        segmentedController.setTitle(OVERVIEW, forSegmentAtIndex: 1)
        segmentedController.setTitle(PARSEDCON, forSegmentAtIndex: 2)
        
        segmentedController.selectedSegmentIndex = 1
        
        segmentedController.tintColor = ColorClass.color_LightTealGreen()
        
        greenSpacer.backgroundColor = ColorClass.color_TealGreen()
        
        let att : [NSObject : AnyObject]? = [NSFontAttributeName: UIFont.boldSystemFontOfSize(15.0), NSForegroundColorAttributeName: ColorClass.color_DarkRed()]
        
        segmentedController.setTitleTextAttributes([NSForegroundColorAttributeName: ColorClass.color_DarkRed()], forState: UIControlState.Normal)
        segmentedController.setTitleTextAttributes([NSForegroundColorAttributeName:ColorClass.color_DarkRed(), NSFontAttributeName: UIFont.boldSystemFontOfSize(15.0)], forState: UIControlState.Selected)
        
    }
    
    @IBAction func segmentedControllerAction(sender: AnyObject) {

        var input = segmentedController.titleForSegmentAtIndex(segmentedController.selectedSegmentIndex)!
        
        if input == OVERVIEW || input == PARSEDOVER {
        
                segmentedController.selectedSegmentIndex = 1
                segmentedController.setTitle(PARSEDDEP, forSegmentAtIndex: 0)
            
                segmentedController.setTitle(OVERVIEW, forSegmentAtIndex: 1)
                segmentedController.setTitle(PARSEDCON, forSegmentAtIndex: 2)
            
                clearSubviews()
    
                var newView: UIViewController = storyboard!.instantiateViewControllerWithIdentifier(STORYBOARDID_OVERVIEW) as! UIViewController
                profileContainerView.addSubview(newView.view)
                self.addChildViewController(newView)
        } else if input == CONTACT || input == PARSEDCON {

                segmentedController.selectedSegmentIndex = 1
                segmentedController.setTitle(PARSEDOVER, forSegmentAtIndex: 0)
                segmentedController.setTitle(CONTACT, forSegmentAtIndex: 1)
                segmentedController.setTitle(PARSEDDEP, forSegmentAtIndex: 2)
            
                clearSubviews()
                
                var newView: Profile_ContactANDEmployerController  = storyboard!.instantiateViewControllerWithIdentifier(STORYBOARDID_CONTACT) as! Profile_ContactANDEmployerController
                profileContainerView.addSubview(newView.view)
                newView.delegate = self
                self.addChildViewController(newView)

        } else if input == DEPENDENTS || input == PARSEDDEP {
            
                segmentedController.selectedSegmentIndex = 1
                segmentedController.setTitle(PARSEDCON, forSegmentAtIndex: 0)
                segmentedController.setTitle(DEPENDENTS, forSegmentAtIndex: 1)
                segmentedController.setTitle(PARSEDOVER, forSegmentAtIndex: 2)
            
                clearSubviews()
                
                var newView: UIViewController = storyboard!.instantiateViewControllerWithIdentifier(STORYBOARDID_DEPENDENT) as! UIViewController
                profileContainerView.addSubview(newView.view)
                self.addChildViewController(newView)
        }
    }
    
    func clearSubviews(){
        //CLEAR existing subviews in container
        for subView in profileContainerView.subviews as! [UIView] {
            subView.removeFromSuperview()
        }
    }
}

extension ProfileViewController : ProfileViewControllerDelegate {
    
    func changeContainerToContactController() {
        
        
        clearSubviews()
        
        
        var newView: Profile_ContactANDEmployerController = storyboard!.instantiateViewControllerWithIdentifier(STORYBOARDID_CONTACT) as! Profile_ContactANDEmployerController
        profileContainerView.addSubview(newView.view)
        newView.delegate = self
        self.addChildViewController(newView)
    }
    
    func changeContainerToEditController() {
        
        clearSubviews()
        
        var newView: Profile_EDITContactController  = storyboard!.instantiateViewControllerWithIdentifier(STORYBOARDID_EDIT) as! Profile_EDITContactController
        profileContainerView.addSubview(newView.view)
        newView.delegate = self
        self.addChildViewController(newView)
    }
}

