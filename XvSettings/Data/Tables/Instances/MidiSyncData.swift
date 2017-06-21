//
//  XvSetMidiSyncData.swift
//  Repercussion
//
//  Created by Jason Snell on 6/4/17.
//  Copyright © 2017 Jason J. Snell. All rights reserved.




class MidiSyncData:CheckmarkTableData {
    
    fileprivate let _xvcdm:XvCoreDataManager = XvCoreDataManager.sharedInstance
    
    public init?(){
        
        let key:String = XvSetConstants.kAppMidiSync
        
        if let defaultValue:String = _xvcdm.getAppString(forKey: key) {
            
            super.init(
                
                key: key,
                dataType: XvSetConstants.DATA_TYPE_STRING,
                defaultValue: defaultValue,
                possibleValues: [
                    XvSetConstants.MIDI_CLOCK_RECEIVE,
                    XvSetConstants.MIDI_CLOCK_SEND,
                    XvSetConstants.MIDI_CLOCK_NONE
                ],
                textLabel: XvSetConstants.MIDI_SYNC_LABEL,
                detailTextLabels: [
                    XvSetConstants.MIDI_CLOCK_RECEIVE_LABEL,
                    XvSetConstants.MIDI_CLOCK_SEND_LABEL,
                    XvSetConstants.MIDI_CLOCK_NONE_LABEL
                ],
                
                levelType: XvSetConstants.LEVEL_TYPE_APP,
                isVisible: true
            )
            
            let section:SectionData = SectionData(
                header: XvSetConstants.MIDI_SYNC_LABEL,
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
