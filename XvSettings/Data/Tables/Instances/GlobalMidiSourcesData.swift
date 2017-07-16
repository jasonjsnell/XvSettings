//
//  GlobalMidiSourcesData.swift
//  XvSettings
//
//  Created by Jason Snell on 7/6/17.
//  Copyright © 2017 Jason J. Snell. All rights reserved.
//

// This is for app level midi destinations, which instruments can default to

import Foundation
import CoreData

public class GlobalMidiSourcesData:CheckmarkTableData {
    
    fileprivate let _xvcdm:XvCoreDataManager = XvCoreDataManager.sharedInstance
    
    public init?(){
        
        let key:String = XvSetConstants.kAppGlobalMidiSources
        
        super.init(
            
            key: key,
            dataType: XvSetConstants.DATA_TYPE_ARRAY,
            defaultValue: [],
            possibleValues: [],
            textLabel: Labels.MIDI_GLOBAL_SOURCE_LABEL,
            detailTextLabels: [],
            levelType: XvSetConstants.LEVEL_TYPE_APP,
            isVisible: true
        )
        
        let section:SectionData = SectionData(
            header: Labels.MIDI_GLOBAL_DESTINATION_HEADER,
            footerType: XvSetConstants.FOOTER_TYPE_NONE,
            footerText: nil,
            footerLink: nil,
            footerHeight: 50,
            cells: getCellDataArray(),
            isVisible: true
        )
        
        sections.append(section)
    }
    
    public func refresh() {
        
        if let userSelectedSources:[String] = _xvcdm.getAppArray(forKey: key) as? [String] {
            
            //reset sections
            sections = []
            
            //grab data from core data manager
            var availableSources:[String] = [XvSetConstants.MIDI_SOURCE_OMNI]
            availableSources.append(contentsOf: _xvcdm.getMidiSourceNames())
            
            //update the values that were missing from init
            self.defaultValue = userSelectedSources
            self.possibleValues = availableSources
            self.detailTextLabels = availableSources
            
            //re-init the data array
            initCellDataArray()
          
            //create a section with the new cell data array
            let section:SectionData = SectionData(
                header: Labels.MIDI_GLOBAL_SOURCE_HEADER,
                footerType: XvSetConstants.FOOTER_TYPE_NONE,
                footerText: nil,
                footerLink: nil,
                footerHeight: 50,
                cells: getCellDataArray(),
                isVisible: true
            )
            
            //append
            sections.append(section)
            
        } else {
            
            print("SETTINGS: Error: Unable to get value from instr data obj in XvGlobalMidiSourcesData")
            
        }
    }
}


