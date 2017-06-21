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
    
    override func disclosureRowSelected(cell:DisclosureCell, key:String){
        
        //search the kit data object for an instrument data object using the incoming key
        if let instrDataObj:NSManagedObject = xvcdm.getInstrumentInCurrKit(forID: key) {
            
            //if found, load the instrument table
            loadInstrumentTable(fromDataObj: instrDataObj)
            
        } else {
            print("SETTINGS: Core data for", key, "not found during disclosureRowSelected")
        }
    }
}
