//
//  MidiDestinationsData.swift
//  XvSettings
//
//  Created by Jason Snell on 6/19/17.
//  Copyright © 2017 Jason J. Snell. All rights reserved.
//
// This is for track level midi destinations

import Foundation
import CoreData

class TrackMidiDestinationsData:CheckmarkTableData {
    
    fileprivate let _xvcdm:XvCoreDataManager = XvCoreDataManager.sharedInstance
    
    fileprivate let footerText:[String] = ["Pull to refresh MIDI destinations."]
    
    fileprivate let trackDataObj:NSManagedObject
    
    public init?(withTrackDataObj:NSManagedObject){
        
        self.trackDataObj = withTrackDataObj
        let key:String = XvSetConstants.kTrackMidiDestinations
        
        super.init(
            
            key: key,
            dataType: XvSetConstants.DATA_TYPE_ARRAY,
            defaultValue: [],
            possibleValues: [],
            textLabel: Labels.MIDI_DESTINATION_LABEL,
            detailTextLabels: [],
            levelType: XvSetConstants.LEVEL_TYPE_TRACK,
            isVisible: true
        )
        
        sections.append(_getSection())
        
    }
    
    public func refresh() {
        
        if let userSelectedDestinations:[String] = _xvcdm.getArray(forKey: key, forObject: trackDataObj) as? [String] {
            
            //reset sections
            sections = []
            
            //grab data from core data manager
            var availableDestinations:[String] = [XvSetConstants.MIDI_DESTINATION_GLOBAL]
            availableDestinations.append(contentsOf: _xvcdm.getMidiDestinationNames())
            
            
            //update the values that were missing from init
            self.defaultValue = userSelectedDestinations
            self.possibleValues = availableDestinations
            self.detailTextLabels = availableDestinations
            
            //re-init the data array
            initCellDataArray()
            
            //append
            sections.append(_getSection())
            
        } else {
            
            print("SETTINGS: Error: Unable to get value from track data obj in GlobalMidiDestinationsData")
            
        }
    }
    
    fileprivate func _getSection() -> SectionData{
        
        //create a section with the new cell data array
        return SectionData(
            header: Labels.MIDI_DESTINATION_HEADER,
            footerType: XvSetConstants.FOOTER_TYPE_NORMAL,
            footerText: footerText,
            footerLink: nil,
            footerHeight: 50,
            cells: getCellDataArray(),
            isVisible: true
        )
    }
    
}

