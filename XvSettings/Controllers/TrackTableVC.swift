//
//  TrackTableVC.swift
//  XvSettings
//
//  Created by Jason Snell on 6/18/17.
//  Copyright © 2017 Jason J. Snell. All rights reserved.
//

import UIKit
import CoreData

class TrackTableVC:TableVC {


    override func disclosureRowSelected(cell:DisclosureCell, key:String){
        
        
        if (
            key == XvSetConstants.kTrackPatternLength           ||
            key == XvSetConstants.kTrackCompositionRelease ||
            key == XvSetConstants.kTrackQuantization ){
            
            //default cells
            loadCheckmarkTable(fromCell:cell)
            
        } else if (
            key == XvSetConstants.kTrackMidiSendChannel      ||
            key == XvSetConstants.kTrackMidiReceiveChannel   ||
            key == XvSetConstants.kTrackMidiDestinations){
            
            //midi cells
            
            if (!xvcdm.audioBusMidiBypass){
             
                loadCheckmarkTable(fromCell:cell)
            
            } else {
            
                //block loading of MIDI tables if audiobus is active
                _showAudiobusMidiBypassError()
            }
        }
    }

}
