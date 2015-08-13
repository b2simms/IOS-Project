//
//  Profile_ContactANDEmployerController.swift
//  SlideOutNavigation
//
//  Created by Brent Simmons on 8/10/15.
//  Copyright (c) 2015 Brent Simmons. All rights reserved.
//

import Foundation
import UIKit

class Profile_ContactANDEmployerController: UIViewController{
    
    var delegate : ProfileViewControllerDelegate?
    
    @IBOutlet weak var street: UILabel!
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var province: UILabel!
    @IBOutlet weak var postal: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var email: UILabel!
    
    @IBOutlet weak var contactHeader: UILabel!
    @IBOutlet weak var employerHeader: UILabel!
    @IBOutlet weak var editButton: UIButton!
    
    var databasePath = NSString()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contactHeader.backgroundColor = ColorClass.color_SubHeader()
        employerHeader.backgroundColor = ColorClass.color_SubHeader()
        editButton.backgroundColor = ColorClass.color_Header()
        
        
        createOrCheckForExistingDatabase()
        
        //UNCOMMENT TO CREATE DATABASE AND TABLE FOR THE FIRST TIME
        //saveToDB()
        
        loadData()
    }
    
    
    @IBAction func editButton(sender: AnyObject) {
        delegate?.changeContainerToEditController()
    }
    
    func loadData(){
        let contactDB = FMDatabase(path: databasePath as String)
        
        if contactDB.open() {
            let querySQL = "SELECT street, city, province, postal, phone, email FROM CONTACTS WHERE ID = 1"
            
            let results:FMResultSet? = contactDB.executeQuery(querySQL,
                withArgumentsInArray: nil)
            
            if results?.next() == true {
                street.text = results?.stringForColumn("street")
                city.text = results?.stringForColumn("city")
                province.text = results?.stringForColumn("province")
                postal.text = results?.stringForColumn("postal")
                phone.text = results?.stringForColumn("phone")
                email.text = results?.stringForColumn("email")
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
            
            let insertSQL = "INSERT INTO CONTACTS (street, city, province, postal, phone, email) VALUES('\(street.text)', '\(city.text)', '\(province.text)', '\(postal.text)', '\(phone.text)', '\(email.text)')"
            
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