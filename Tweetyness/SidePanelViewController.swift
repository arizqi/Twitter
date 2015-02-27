//
//  LeftViewController.swift
//  Tweetyness
//
//  Created by Ashar Rizqi on 2/26/15.
//  Copyright (c) 2015 Ashar Rizqi. All rights reserved.
//

import UIKit

protocol SidePanelViewControllerDelegate {
    func menuItemSelected(menuItem: AnyObject)
}

class SidePanelViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    var delegate: SidePanelViewControllerDelegate?
    
    var menuItems: Array<AnyObject>!
    
    struct TableView {
        struct CellIdentifiers {
            static let MenuItemCell = "MenuItemCell"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.reloadData()
    }
    
    // MARK: Table View Data Source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(TableView.CellIdentifiers.MenuItemCell, forIndexPath: indexPath) as MenuItemCell
        
        cell.configureForMenuItem(menuItems[indexPath.row])
        return cell
    }
    
    // Mark: Table View Delegate
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        let selectedMenuItem = menuItems[indexPath.row]
        delegate?.menuItemSelected(selectedMenuItem)
    }
    
}

class MenuItemCell: UITableViewCell {
    
    @IBOutlet weak var menuItemLabel: UILabel!
    func configureForMenuItem(menuItem: AnyObject) {
        menuItemLabel.text = "yoyo"
    }
}