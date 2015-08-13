//
//  ClaimsHistoryController.swift
//  SlideOutNavigation
//
//  Created by Brent Simmons on 8/4/15.
//  Copyright (c) 2015 Brent Simmons. All rights reserved.
//

import Foundation
import UIKit

class ClaimsHistoryController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mainHeader: UIView!
    @IBOutlet weak var main_benefit: UILabel!
    @IBOutlet weak var main_claimant: UILabel!
    @IBOutlet weak var main_coverage: UILabel!
    @IBOutlet weak var main_paid: UILabel!
    
    
    var selectedIndexPath : NSIndexPath?
    var indexPaths : Array<NSIndexPath> = []
    
    let claimList = [
        ClaimHistoryExpandableCell (date: "16 Aug 2014"),
        ClaimHistoryExpandableCell (benefit: "AD&D", claimant: "Janelle Muir", coverage: "Blood Pressure", paid: "200.00", serviceDate: "29 Sep 2014", receivedDate: "09 May 2014", payInfo: "Pharmacy Card"),
        ClaimHistoryExpandableCell (benefit: "AD&D", claimant: "Janelle Muir", coverage: "Blood Pressure", paid: "200.00", serviceDate: "28 Sep 2014", receivedDate: "09 May 2014", payInfo: "Pharmacy Card"),
        ClaimHistoryExpandableCell (date: "01 Aug 2014"),
        ClaimHistoryExpandableCell (benefit: "AD&D", claimant: "Janelle Muir", coverage: "Blood Pressure", paid: "200.00", serviceDate: "27 Sep 2014", receivedDate: "09 May 2014", payInfo: "Pharmacy Card"),
        ClaimHistoryExpandableCell (date: "11 Jun  2014"),
        ClaimHistoryExpandableCell (benefit: "AD&D", claimant: "Janelle Muir", coverage: "Blood Pressure", paid: "200.00", serviceDate: "26 Sep 2014", receivedDate: "09 May 2014", payInfo: "Pharmacy Card"),
       ClaimHistoryExpandableCell (benefit: "AD&D", claimant: "Janelle Muir", coverage: "Blood Pressure", paid: "200.00", serviceDate: "25 Sep 2014", receivedDate: "09 May 2014", payInfo: "Pharmacy Card"),
        ClaimHistoryExpandableCell (date: "02 May 2014"),
        ClaimHistoryExpandableCell (benefit: "AD&D", claimant: "Janelle Muir", coverage: "Blood Pressure", paid: "200.00", serviceDate: "24 Sep 2014", receivedDate: "09 May 2014", payInfo: "Pharmacy Card")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainHeader.backgroundColor = ColorClass.color_LightTealGreen()
        main_benefit.textColor = ColorClass.color_DarkRed()
        main_claimant.textColor = ColorClass.color_DarkRed()
        main_coverage.textColor = ColorClass.color_DarkRed()
        main_paid.textColor = ColorClass.color_DarkRed()

        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
    }
    
    // MARK:  UITextFieldDelegate Methods
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return claimList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if(claimList[indexPath.row].isDateSet){
            let cell = tableView.dequeueReusableCellWithIdentifier("DateRow", forIndexPath: indexPath) as! DateCell
             cell.configureForMenu(claimList[indexPath.row])
            return cell
        }else {
            let cell = tableView.dequeueReusableCellWithIdentifier("ContentRow", forIndexPath: indexPath) as! ClaimCell
            cell.configureForMenu(claimList[indexPath.row])
            return cell
        }
    }
    
    func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        if(claimList[indexPath.row].isDateSet){
            return nil
        }
        return indexPath
    }
    
    // MARK:  UITableViewDelegate Methods
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        // Date - cell height
        if(claimList[indexPath.row].isDateSet){
            //don't expand
            tableView.deselectRowAtIndexPath(indexPath, animated: false)
        } else {
            tableView.deselectRowAtIndexPath(indexPath, animated: false)
            
            if indexPath == selectedIndexPath{
                selectedIndexPath = nil
            } else {
                selectedIndexPath = indexPath
                indexPaths += [selectedIndexPath!]
            }

            if indexPaths.count > 0 {
                tableView.reloadRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
            }
        }
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath){
        // Date - cell height
        if(claimList[indexPath.row].isDateSet){
            //don't expand
            cell.contentView.backgroundColor = ColorClass.color_SubHeader()
        } else {
            (cell as! ClaimCell).watchFrameChanges()
            cell.contentView.backgroundColor = ColorClass.color_ClaimInner()
        }
    }
    
    func tableView(tableView: UITableView, didEndDisplayingCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        // Date - cell height
        if(claimList[indexPath.row].isDateSet){
            //don't expand
            //cell.backgroundColor = ColorClass.color_Header()
        } else {
            (cell as! ClaimCell).ignoreFrameChanges()
            //cell.backgroundColor = ColorClass.color_SubHeader()
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath == selectedIndexPath && !claimList[indexPath.row].isDateSet{
            return 250.0
        } else if claimList[indexPath.row].isDateSet {
            return 30.0
        }
        return 50.0
    }
    

}
class DateCell: UITableViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    
    func configureForMenu(items: ClaimHistoryExpandableCell) {
        dateLabel.text = items.date
    }
    
}
class ClaimCell: UITableViewCell {
    
    @IBOutlet weak var benefitLabel: UILabel!
    @IBOutlet weak var claimantLabel: UILabel!
    @IBOutlet weak var coverageLabel: UILabel!
    @IBOutlet weak var paidLabel: UILabel!
    
    //Expandable Cells
    @IBOutlet weak var exClaimant: UILabel!
    @IBOutlet weak var exService: UILabel!
    @IBOutlet weak var exCoverage: UILabel!
    @IBOutlet weak var exPaid: UILabel!
    @IBOutlet weak var exReceived: UILabel!
    @IBOutlet weak var exPayInfo: UILabel!
    
    @IBOutlet weak var exCell: UIView!
    
    func configureForMenu(items: ClaimHistoryExpandableCell) {
        benefitLabel.text = items.benefit
        claimantLabel.text = items.claimant
        coverageLabel.text = items.coverage
        paidLabel.text = items.paid
        exClaimant.text = items.claimant
        exService.text = items.serviceDate
        exCoverage.text = items.coverage
        exReceived.text = items.receivedDate
        exPaid.text = items.payInfo
    }
    
    func checkHeight() {
        exCell.hidden = (frame.size.height < 250)
    }
    func watchFrameChanges() {
        addObserver(self, forKeyPath: "frame", options: .New, context: nil)
        checkHeight()
    }
    
    func ignoreFrameChanges(){
        removeObserver(self, forKeyPath: "frame")
    }
    override func observeValueForKeyPath(keyPath: String, ofObject object: AnyObject, change: [NSObject : AnyObject], context: UnsafeMutablePointer<Void>) {
        if keyPath == "frame" {
            checkHeight()
        }
    }
    
    
    
}