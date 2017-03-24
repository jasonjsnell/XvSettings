//
//  SettingsTableViewController.swift
//  RF Settings
//
//  Created by Jason Snell on 8/30/16.
//  Copyright © 2016 Jason J. Snell. All rights reserved.
//

// basic class for all other table classes

import UIKit

open class XvSetTable: UITableViewController {
    
    //MARK:VARIABLES    
    
    //nav
    internal var nav:UINavigationController?
    
    internal let debug:Bool = false
    
    //MARK:- OPEN API - 
    //can be overriden by objects outside of framework
    
    override open func viewDidLoad() {
        
        super.viewDidLoad()
        
        //init size of view. X is 20 for status bar
        let tableFrame:CGRect = CGRect(x: 0, y: 20, width: self.view.bounds.width, height: self.view.bounds.height)
        tableView = UITableView(frame: tableFrame, style: .grouped)
        
        //set delegate to self
        tableView.delegate = self
        tableView.dataSource = self
        
    }
  
    override open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //override in sub
        return UITableViewCell()
    }
    
    //prevents clicks on rows with toggle switches from firing
    //this fixes errors where toggle switches were getting stuck in one position
    override open func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        
        let cell:XvSetCell = tableView.cellForRow(at: indexPath) as! XvSetCell
        if let cellData:XvSetCellData = cell.data {
            
            //return nil on toggle cells, making their background not clickable
            if (cellData.displayType == XvSetConstants.DISPLAY_TYPE_SWITCH){
                return nil
            }
            
        }
        
        return indexPath
        
    }

    
    //MARK:- INTERNAL -
    
    //user taps link is settings footer
    internal func footerWithLinkWasTapped(sender:UITapGestureRecognizer){
        
        if let footer:SetFooter = sender.view as? SetFooter {
            
            if (debug){
                print("SETTINGS: Launch", footer.url)
            }
            
            let url = URL(string: footer.url)!
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
            
        }
    }
    
    

}
