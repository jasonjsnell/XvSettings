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
            key == XvSetConstants.kTrackMidiSendChannel      ||
            key == XvSetConstants.kTrackMidiReceiveChannel   ||
            key == XvSetConstants.kTrackLoopLength           ||
            key == XvSetConstants.kTrackAmpRelease ||
            key == XvSetConstants.kTrackQuantization ){
            
            loadCheckmarkTable(fromCell:cell)
            
        } else if (key == XvSetConstants.kTrackMidiDestinations){
            
            if (!xvcdm.audioBusMidiBypass){
                loadCheckmarkTable(fromCell:cell)
            } else {
                _showAudiobusMidiBypassError()
            }
        }
    }

}
