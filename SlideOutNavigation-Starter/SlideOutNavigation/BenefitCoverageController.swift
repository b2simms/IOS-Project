//
//  BenefitCoverageController.swift
//  SlideOutNavigation
//
//  Created by Brent Simmons on 8/4/15.
//  Copyright (c) 2015 Brent Simmons. All rights reserved.
//

import Foundation
import UIKit

class BenefitCoverageController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    let TEXTCELLIDENTIFIER = "TextCell"
    let benefitList = [
        BenefitCoverageMainCell(benefit: "A-BC", carrier: "La Capitale Financial Group", policy: "2305", date: "16 Aug 2009", coverage: "$3,000.00"),
        BenefitCoverageMainCell(benefit: "AD&D", carrier: "Financial Group", policy: "25-005", date: "17 Aug 2009", coverage: "$385,500.00"),
        BenefitCoverageMainCell(benefit: "EEINSURE", carrier: "ENSURE Financial Group", policy: "255305", date: "18 Aug 2009", coverage: "$38,000.00"),
        BenefitCoverageMainCell(benefit: "AD&C", carrier: "Group de Financial", policy: "278", date: "19 Aug 2009", coverage: "$8,500.00"),
        BenefitCoverageMainCell(benefit: "YM-D", carrier: "Toronto Bank", policy: "905", date: "20 Aug 2009", coverage: "$44,000.00"),
        BenefitCoverageMainCell(benefit: "UNION", carrier: "Union United", policy: "789-987", date: "21 Aug 2009", coverage: "$19,500.00")]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
    }
    
    // MARK:  UITextFieldDelegate Methods
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return benefitList.count+2
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if(indexPath.row == 0){
            let cell = tableView.dequeueReusableCellWithIdentifier("HeaderCell", forIndexPath: indexPath) as! BenefitCoverageCell
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            return cell
            
        }else if(indexPath.row == benefitList.count+1){
            let cell = tableView.dequeueReusableCellWithIdentifier("FooterCell", forIndexPath: indexPath) as! BenefitCoverageCell
             cell.selectionStyle = UITableViewCellSelectionStyle.None
            return cell
            
        }else {
            let cell = tableView.dequeueReusableCellWithIdentifier(TEXTCELLIDENTIFIER, forIndexPath: indexPath) as! BenefitCoverageCell
            cell.configureForMenu(benefitList[indexPath.row-1])
             cell.selectionStyle = UITableViewCellSelectionStyle.None
            return cell
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        // Header - cell height
        if(indexPath.row == 0){
            return 222.0
        }
        // Footer - cell height
        else if(indexPath.row == benefitList.count+1){
             return 75.0
        }
        // TextCell - cell height
        else {
            return 150.0
        }
    }
    
    func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        return nil
    }
    
//    // MARK:  UITableViewDelegate Methods
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        tableView.deselectRowAtIndexPath(indexPath, animated: true)
//    }
}
class BenefitCoverageCell: UITableViewCell {
    
    @IBOutlet weak var benefitLabel: UILabel!
    @IBOutlet weak var carrierLabel: UILabel!
    @IBOutlet weak var policyLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var coverageLabel: UILabel!
    
    
    func configureForMenu(items: BenefitCoverageMainCell) {
        benefitLabel.text = items.benefit
        carrierLabel.text = items.carrier
        policyLabel.text = items.policy
        dateLabel.text = items.date
        coverageLabel.text = items.coverage
    }
    
}