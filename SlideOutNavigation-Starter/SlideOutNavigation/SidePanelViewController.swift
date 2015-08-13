//
//  LeftViewController.swift
//  SlideOutNavigation
//
//  Created by Brent Simmons on 8/4/15.
//  Copyright (c) 2015 Brent Simmons. All rights reserved.
//

import UIKit

@objc
protocol SidePanelViewControllerDelegate {
  func menuSelected(mainMenu: MainMenu )
}

class SidePanelViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
    
  var delegate: SidePanelViewControllerDelegate?
  
  var mainMenu: Array<MainMenu >!
  
  struct TableView {
    struct CellIdentifiers {
      static let MainMenuCell = "MainMenuCell"
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.reloadData()
  }
  
}

// MARK: Table View Data Source

extension SidePanelViewController: UITableViewDataSource {
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return mainMenu.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier(TableView.CellIdentifiers.MainMenuCell, forIndexPath: indexPath) as! MainMenuCell
    cell.configureForMenu(mainMenu[indexPath.row])
    return cell
  }
  
}

// Mark: Table View Delegate

extension SidePanelViewController: UITableViewDelegate {

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let selectedItem = mainMenu[indexPath.row]
        delegate?.menuSelected(selectedItem)
    }
  
}

class MainMenuCell: UITableViewCell {
  
  @IBOutlet weak var menuImageView: UIImageView!
  @IBOutlet weak var imageNameLabel: UILabel!
  
  func configureForMenu(items: MainMenu ) {
    menuImageView.image = items.image
    imageNameLabel.text = items.title
  }
  
}