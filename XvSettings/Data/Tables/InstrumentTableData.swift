//
//  InstrumentTableData.swift
//  XvSettings
//
//  Created by Jason Snell on 6/19/17.
//  Copyright © 2017 Jason J. Snell. All rights reserved.
//

import Foundation
import CoreData

public class InstrumentTableData:TableData {
    
    public init(instrumentDataObj:NSManagedObject){
        
        super.init()
        
        //save for future ref
        xvcdm.set(currInstrument: instrumentDataObj)
        
        //MARK: Header
        if let instrumentName:String = xvcdm.getString(
            forKey: XvSetConstants.kInstrumentName,
            forObject: instrumentDataObj
            ) {
            
            title = instrumentName
            
        } else {
            print("SETTINGS: Error getting instrument name for instrument table header")
        }
        
        //make sure core data is valid
        if let midiSendEnabledBool:Bool = xvcdm.getAppBool(forKey: XvSetConstants.kInstrumentMidiSendEnabled),
            let midiSendChannelData:MidiSendChannelData = MidiSendChannelData(withInstrDataObj: instrumentDataObj),
            let midiDestinationsData:MidiDestinationsData = MidiDestinationsData(withInstrDataObj: instrumentDataObj)
        {
            
            let midiSendEnabled:ToggleCellData = ToggleCellData(
                key: XvSetConstants.kInstrumentMidiSendEnabled,
                value: midiSendEnabledBool,
                textLabel: "MIDI Send",
                levelType: XvSetConstants.LEVEL_TYPE_INSTRUMENT,
                isVisible: true
            )
            
            midiSendEnabled.visibilityTargets = [[0,1,2]]
            
            let midiSendChannel:DisclosureCellData = DisclosureCellData(
                withCheckmarkTableDataSource: midiSendChannelData,
                isVisible: false
            )
            
            let midiDestinations:DisclosureCellData = DisclosureCellData(
                withCheckmarkTableDataSource: midiDestinationsData,
                isVisible: false
            )

            let midiSendSection:SectionData = SectionData(
                header: "MIDI Send",
                footerType: XvSetConstants.FOOTER_TYPE_NONE,
                footerText: nil,
                footerLink: nil,
                footerHeight: 10,
                cells: [midiSendEnabled, midiSendChannel, midiDestinations],
                isVisible: true
            )
            
            sections.append(midiSendSection)
    
        } else {
            print("SETTINGS: Error: Unable to initialize midiSendSection in instrument table")
        }
        
        //make sure core data is valid
        if let midiReceiveEnabledBool:Bool = xvcdm.getAppBool(forKey: XvSetConstants.kInstrumentMidiReceiveEnabled),
            let midiReceiveChannelData:MidiReceiveChannelData = MidiReceiveChannelData(withInstrDataObj: instrumentDataObj),
            let midiSourcesData:MidiSourcesData = MidiSourcesData(withInstrDataObj: instrumentDataObj)
        {
            
            let midiReceiveEnabled:ToggleCellData = ToggleCellData(
                key: XvSetConstants.kInstrumentMidiReceiveEnabled,
                value: midiReceiveEnabledBool,
                textLabel: "MIDI Receive",
                levelType: XvSetConstants.LEVEL_TYPE_INSTRUMENT,
                isVisible: true
            )
            
            midiReceiveEnabled.visibilityTargets = [[1,1,2]]
            
            let midiReceiveChannel:DisclosureCellData = DisclosureCellData(
                withCheckmarkTableDataSource: midiReceiveChannelData,
                isVisible: false
            )
            
            let midiSources:DisclosureCellData = DisclosureCellData(
                withCheckmarkTableDataSource: midiSourcesData,
                isVisible: false
            )
            
            let midiReceiveSection:SectionData = SectionData(
                header: "MIDI Receive",
                footerType: XvSetConstants.FOOTER_TYPE_NONE,
                footerText: nil,
                footerLink: nil,
                footerHeight: 10,
                cells: [midiReceiveEnabled, midiReceiveChannel, midiSources],
                isVisible: true
            )
            
            sections.append(midiReceiveSection)
            
        } else {
            print("SETTINGS: Error: Unable to initialize midiReceiveSection in instrument table")
        }
        
        
        
        
       
    }
}
