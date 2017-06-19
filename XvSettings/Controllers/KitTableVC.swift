//
//  KitTableVC.swift
//  XvSettings
//
//  Created by Jason Snell on 6/18/17.
//  Copyright © 2017 Jason J. Snell. All rights reserved.
//

import Foundation

import UIKit
import CoreData

class KitTableVC:TableVC {
    
    //override by app settings classes, which check for app specific keys and execute app specific commands
    override func disclosureRowSelected(cell:DisclosureCell, key:String){
        
        //get this table's data object
        if let kitDataObj:NSManagedObject = (dataSource as? KitTableData)?.kitDataObj {
            
            //search the kit data object for an instrument data object using the incoming key
            if let instrDataObj:NSManagedObject = xvcdm.getInstrument(forID: key, inKitObject: kitDataObj) {
                
                //if found, load the instrument table
                loadInstrumentTable(fromDataObj: instrDataObj)
                
            } else {
                print("SETTINGS: Core data for", key, "not found during disclosureRowSelected")
            }
            
        } else {
            print("SETTINGS: Error getting kit data obj during disclosureRowSelected on kit table")
        }
    }
}
