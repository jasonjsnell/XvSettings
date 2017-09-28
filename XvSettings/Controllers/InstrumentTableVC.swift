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
        
        if (
            key == XvSetConstants.kInstrumentMidiSendChannel      ||
            key == XvSetConstants.kInstrumentMidiReceiveChannel   ||
            key == XvSetConstants.kInstrumentLoopLength           ||
            key == XvSetConstants.kInstrumentAmpRelease ||
            key == XvSetConstants.kInstrumentQuantization ){
            
            loadCheckmarkTable(fromCell:cell)
            
        } else if (key == XvSetConstants.kInstrumentMidiDestinations){
            
            if (!xvcdm.audioBusMidiBypass){
                loadCheckmarkTable(fromCell:cell)
            } else {
                _showAudiobusMidiBypassError()
            }
        }
    }

}
