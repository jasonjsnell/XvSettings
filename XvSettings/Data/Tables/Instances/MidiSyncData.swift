//
//  XvSetMidiSyncData.swift
//  Repercussion
//
//  Created by Jason Snell on 6/4/17.
//  Copyright © 2017 Jason J. Snell. All rights reserved.


class MidiSyncData:CheckmarkTableData {
    
    fileprivate let _xvcdm:XvCoreDataManager = XvCoreDataManager.sharedInstance
    
    public init(){
        
        let key:String = XvSetConstants.kAppMidiSync
        
        super.init(
            
            key: key,
            dataType: XvSetConstants.DATA_TYPE_STRING,
            value: _xvcdm.getAppString(forKey: key),
            values: [
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
            
            multi: false,
            levelType: XvSetConstants.LEVEL_TYPE_APP
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
    }
    
}
