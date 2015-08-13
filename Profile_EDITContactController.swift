//
//  Profile_EDITContactController.swift
//  SlideOutNavigation
//
//  Created by Brent Simmons on 8/11/15.
//  Copyright (c) 2015 Brent Simmons. All rights reserved.
//

import Foundation
import UIKit

class Profile_EDITContactController: UIViewController {
    
    @IBOutlet weak var street: UITextField!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var province: UITextField!
    @IBOutlet weak var postal: UITextField!
//    @IBOutlet weak var phone: UITextField!    //remove phone and email vars when using these two fields
//    @IBOutlet weak var email: UITextField!
    var phone = "(706) 578-9090"
    var email = "carolyn.muir@gmail.com"
    
    
    @IBOutlet weak var editHeader: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
   
    var delegate : ProfileViewControllerDelegate?
    
    var databasePath = NSString()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        editHeader.backgroundColor = ColorClass.color_SubHeader()
        saveButton.backgroundColor = ColorClass.color_Header()
        cancelButton.backgroundColor = ColorClass.color_Header()
        
        createOrCheckForExistingDatabase()
        
        loadData()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        street.resignFirstResponder()
        city.resignFirstResponder()
        province.resignFirstResponder()
        postal.resignFirstResponder()
//        phone.resignFirstResponder()
//        email.resignFirstResponder()
        self.setEditing(false, animated: true)
    }
    
    @IBAction func saveData(sender: AnyObject) {
        saveToDB()
        delegate?.changeContainerToContactController()
    }
    
    @IBAction func cancelButton(sender: AnyObject) {
        delegate?.changeContainerToContactController()
    }
    
    func loadData(){
        let contactDB = FMDatabase(path: databasePath as String)
        
        if contactDB.open() {
            let querySQL = "SELECT street, city, province, postal, phone, email FROM CONTACTS WHERE ID = 1 "
            
            let results:FMResultSet? = contactDB.executeQuery(querySQL,
                withArgumentsInArray: nil)
            
            if results?.next() == true {
                street.text = results?.stringForColumn("street")
                city.text = results?.stringForColumn("city")
                province.text = results?.stringForColumn("province")
                postal.text = results?.stringForColumn("postal")
//                phone.text = results?.stringForColumn("phone")
//                email.text = results?.stringForColumn("email")
                //println("Results found")
            } else {
                println("Results NOT found...")
            }
            contactDB.close()
        } else {
            println("Error: \(contactDB.lastErrorMessage())")
        }
    }
    func saveToDB(){
        let contactDB = FMDatabase(path: databasePath as String)
        
        if contactDB.open() {
            
            let insertSQL = "UPDATE contacts SET street = '\(street.text)', city = '\(city.text)', province = '\(province.text)', postal = '\(postal.text)', phone = '\(phone)', email = '\(email)' WHERE ID = 1 "
            
            let result = contactDB.executeUpdate(insertSQL,
                withArgumentsInArray: nil)
            
            if !result {
                println("Error: \(contactDB.lastErrorMessage())")
            }
        } else {
            println("Error: \(contactDB.lastErrorMessage())")
        }
    }
    
    func createOrCheckForExistingDatabase(){
        let filemgr = NSFileManager.defaultManager()
        let dirPaths =
        NSSearchPathForDirectoriesInDomains(.DocumentDirectory,
            .UserDomainMask, true)
        
        let docsDir = dirPaths[0] as! String
        
        databasePath = docsDir.stringByAppendingPathComponent(
            "contacts.db")
        
        if !filemgr.fileExistsAtPath(databasePath as String) {
            
            let contactDB = FMDatabase(path: databasePath as String)
            
            if contactDB == nil {
                println("Error: \(contactDB.lastErrorMessage())")
            }
            
            if contactDB.open() {
                let sql_stmt = "CREATE TABLE IF NOT EXISTS CONTACTS (ID INTEGER PRIMARY KEY AUTOINCREMENT, STREET TEXT, CITY TEXT, PROVINCE TEXT, POSTAL TEXT, PHONE TEXT, EMAIL TEXT )"
                if !contactDB.executeStatements(sql_stmt) {
                    println("Error: \(contactDB.lastErrorMessage())")
                }
                contactDB.close()
            } else {
                println("Error: \(contactDB.lastErrorMessage())")
            }
        }
    }
    
}