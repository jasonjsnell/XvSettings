//
//  InstrumentTableVC.swift
//  XvSettings
//
//  Created by Jason Snell on 6/18/17.
//  Copyright © 2017 Jason J. Snell. All rights reserved.
//

import UIKit
import CoreData

class InstrumentTableVC:TableVC {


    override func disclosureRowSelected(cell:DisclosureCell, key:String){
        
        print("InstrumentTableVC: Row tap, key", key)
        
        
        if (key == XvSetConstants.kInstrumentMidiDestinations   ||
            key == XvSetConstants.kInstrumentMidiSendChannel    ||
            key == XvSetConstants.kInstrumentMidiSources        ||
            key == XvSetConstants.kInstrumentMidiReceiveChannel ){
            
            loadCheckmarkTable(fromCell:cell)
            
        }
    }

}
