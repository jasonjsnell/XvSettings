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

class GlobalMidiSourcesData:CheckmarkTableData {
    
    fileprivate let _xvcdm:XvCoreDataManager = XvCoreDataManager.sharedInstance
    
    public init?(){
        
        let key:String = XvSetConstants.kAppGlobalMidiSources
        
        if let userSelectedSources:[String] = _xvcdm.getAppArray(forKey: key) as? [String] {
            
            let availableSources:[String] = _xvcdm.getMidiSourceNames()
            
            super.init(
                
                key: key,
                dataType: XvSetConstants.DATA_TYPE_ARRAY,
                defaultValue: userSelectedSources,
                possibleValues: availableSources,
                textLabel: Labels.MIDI_GLOBAL_SOURCE_LABEL,
                detailTextLabels: availableSources,
                levelType: XvSetConstants.LEVEL_TYPE_APP,
                isVisible: true
            )
            
            let section:SectionData = SectionData(
                header: Labels.MIDI_GLOBAL_SOURCE_HEADER,
                footerType: XvSetConstants.FOOTER_TYPE_NONE,
                footerText: nil,
                footerLink: nil,
                footerHeight: 50,
                cells: getCellDataArray(),
                isVisible: true
            )
            
            sections.append(section)
            
        } else {
            
            print("SETTINGS: Error: Unable to get value from instr data obj in GlobalMidiSourcesData")
            
            return nil
        }
        
        
    }
    
}


