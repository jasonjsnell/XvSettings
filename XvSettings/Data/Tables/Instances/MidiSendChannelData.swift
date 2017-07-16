//
//  MidiSendChannels.swift
//  XvSettings
//
//  Created by Jason Snell on 6/19/17.
//  Copyright © 2017 Jason J. Snell. All rights reserved.
//

import Foundation
import CoreData

class MidiSendChannelData:CheckmarkTableData {
    
    fileprivate let _xvcdm:XvCoreDataManager = XvCoreDataManager.sharedInstance
    
    public init?(withInstrDataObj:NSManagedObject){
        
        let key:String = XvSetConstants.kInstrumentMidiSendChannel
        
        if let defaultValue:Int = _xvcdm.getInteger(forKey: key, forObject: withInstrDataObj) {
            
            var possibleValues:[Int] = []
            var labels:[String] = []
            
            
            for i in 0..<16 {
                
                possibleValues.append(i)
                labels.append("Channel " + String(i + 1))
            }
            
            
            super.init(
                
                key: key,
                dataType: XvSetConstants.DATA_TYPE_INTEGER,
                defaultValue: defaultValue,
                possibleValues: possibleValues,
                textLabel: Labels.MIDI_SEND_LABEL,
                detailTextLabels: labels,
                levelType: XvSetConstants.LEVEL_TYPE_INSTRUMENT,
                isVisible: true
            )
            
            let section:SectionData = SectionData(
                header: Labels.MIDI_SEND_HEADER,
                footerType: XvSetConstants.FOOTER_TYPE_NONE,
                footerText: nil,
                footerLink: nil,
                footerHeight: 50,
                cells: getCellDataArray(),
                isVisible: true
            )
            
            sections.append(section)
            
        } else {
            
            print("SETTINGS: Error: Unable to get value from instr data obj in MidiSendChannelData")
            
            return nil
        }
        
        
    }
    
}
