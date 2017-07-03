//
//  MidiDestinationsData.swift
//  XvSettings
//
//  Created by Jason Snell on 6/19/17.
//  Copyright © 2017 Jason J. Snell. All rights reserved.
//

import Foundation
import CoreData

class MidiDestinationsData:CheckmarkTableData {
    
    fileprivate let _xvcdm:XvCoreDataManager = XvCoreDataManager.sharedInstance
    
    public init?(withInstrDataObj:NSManagedObject){
        
        let key:String = XvSetConstants.kInstrumentMidiDestinations
        
        if let userSelectedDestinations:[String] = _xvcdm.getArray(forKey: key, forObject: withInstrDataObj) as? [String] {
            
            let availableDestinations:[String] = _xvcdm.getMidiDestinationNames()
            
            super.init(
                
                key: key,
                dataType: XvSetConstants.DATA_TYPE_ARRAY,
                defaultValue: userSelectedDestinations,
                possibleValues: availableDestinations,
                textLabel: Labels.MIDI_DESTINATION_LABEL,
                detailTextLabels: availableDestinations,
                levelType: XvSetConstants.LEVEL_TYPE_INSTRUMENT,
                isVisible: true
            )
            
            let section:SectionData = SectionData(
                header: Labels.MIDI_DESTINATION_HEADER,
                footerType: XvSetConstants.FOOTER_TYPE_NONE,
                footerText: nil,
                footerLink: nil,
                footerHeight: 50,
                cells: getCellDataArray(),
                isVisible: true
            )
            
            sections.append(section)
            
        } else {
            
            print("SETTINGS: Error: Unable to get value from instr data obj in MidiDestinationsData")
            
            return nil
        }
        
        
    }
    
}

