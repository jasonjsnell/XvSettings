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
        
        
        //MARK: Composition
        
        if let loopLengthData:LoopLengthData = LoopLengthData(withInstrDataObj: instrumentDataObj),
            
            let quantizationData:QuantizationData = QuantizationData(withInstrDataObj: instrumentDataObj),
            
            let regenerateBool:Bool = xvcdm.getBool(
                forKey: XvSetConstants.kInstrumentRegenerateAtBeginningOfPattern,
                forObject: instrumentDataObj)
            
            {
                
                let quantization:DisclosureCellData = DisclosureCellData(
                    withCheckmarkTableDataSource: quantizationData,
                    isVisible: true)
                
                let loopLength:DisclosureCellData = DisclosureCellData(
                    withCheckmarkTableDataSource: loopLengthData,
                    isVisible: true)
                
                let regenerate:ToggleCellData = ToggleCellData(
                    key: XvSetConstants.kInstrumentRegenerateAtBeginningOfPattern,
                    value: regenerateBool,
                    textLabel: Labels.REGENERATE_LABEL,
                    levelType: XvSetConstants.LEVEL_TYPE_INSTRUMENT,
                    isVisible: true
                )
                
                let compositionSection:SectionData = SectionData(
                    header: "Composition",
                    footerType: XvSetConstants.FOOTER_TYPE_NONE,
                    footerText: nil,
                    footerLink: nil,
                    footerHeight: 10,
                    cells: [quantization, loopLength, regenerate],
                    isVisible: true
                )
                
                sections.append(compositionSection)
            
        } else {
            
            print("SETTINGS: Data is invalid when creating composition section")
            
        }
        
        if let fadeOutDurationData:FadeOutDurationData = FadeOutDurationData(withInstrDataObj: instrumentDataObj),
            
            let fadeOutBool:Bool = xvcdm.getBool(
                forKey: XvSetConstants.kInstrumentFadeOut,
                forObject: instrumentDataObj)
            
            
        {
            
            let fadeOut:ToggleCellData = ToggleCellData(
                key: XvSetConstants.kInstrumentFadeOut,
                value: fadeOutBool,
                textLabel: Labels.FADE_OUT_LABEL,
                levelType: XvSetConstants.LEVEL_TYPE_INSTRUMENT,
                isVisible: true
            )
            
            fadeOut.visibilityTargets = [[1, 1]]
            
            let fadeOutDuration:DisclosureCellData = DisclosureCellData(
                withCheckmarkTableDataSource: fadeOutDurationData,
                isVisible: fadeOutBool)
            
            
            
            let fadeOutSection:SectionData = SectionData(
                header: Labels.FADE_OUT_HEADER,
                footerType: XvSetConstants.FOOTER_TYPE_NONE,
                footerText: nil,
                footerLink: nil,
                footerHeight: 10,
                cells: [fadeOut, fadeOutDuration],
                isVisible: true
            )
            
            sections.append(fadeOutSection)
            
        } else {
            
            print("SETTINGS: Data is invalid when creating fade out section")
            
        }

        
        if let pitchEnabledBool:Bool = xvcdm.getBool(
            forKey: XvSetConstants.kInstrumentPitchEnabled,
            forObject: instrumentDataObj),
            let randomizedPitchBool:Bool = xvcdm.getBool(
                forKey: XvSetConstants.kInstrumentRandomizedPitch,
                forObject: instrumentDataObj) {
            
            let pitchEnabled:ToggleCellData = ToggleCellData(
                key: XvSetConstants.kInstrumentPitchEnabled,
                value: pitchEnabledBool,
                textLabel: Labels.PITCH_ENABLED_LABEL,
                levelType: XvSetConstants.LEVEL_TYPE_INSTRUMENT,
                isVisible: true
            )
            
            pitchEnabled.visibilityTargets = [[2, 1]]
            
            let randomizedPitch:ToggleCellData = ToggleCellData(
                key: XvSetConstants.kInstrumentRandomizedPitch,
                value: randomizedPitchBool,
                textLabel: Labels.RANDOMIZED_PITCH_LABEL,
                levelType: XvSetConstants.LEVEL_TYPE_INSTRUMENT,
                isVisible: pitchEnabledBool
            )

            
            
            let pitchSection:SectionData = SectionData(
                header: Labels.PITCH_HEADER,
                footerType: XvSetConstants.FOOTER_TYPE_NONE,
                footerText: nil,
                footerLink: nil,
                footerHeight: 10,
                cells: [pitchEnabled, randomizedPitch],
                isVisible: true
            )
            
            sections.append(pitchSection)
            
        } else {
            
            print("SETTINGS: Data is invalid when creating pitch section")
            
        }
        
        
        //make sure midi core data is valid
        if let midiSendEnabledBool:Bool = xvcdm.getBool(
            forKey: XvSetConstants.kInstrumentMidiSendEnabled,
            forObject: instrumentDataObj),
            
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
            
            midiSendEnabled.visibilityTargets = [[3,1,2]]
            
            let midiSendChannel:DisclosureCellData = DisclosureCellData(
                withCheckmarkTableDataSource: midiSendChannelData,
                isVisible: midiSendEnabledBool
            )
            
            let midiDestinations:DisclosureCellData = DisclosureCellData(
                withCheckmarkTableDataSource: midiDestinationsData,
                isVisible: midiSendEnabledBool
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
        if let midiReceiveEnabledBool:Bool = xvcdm.getBool(forKey: XvSetConstants.kInstrumentMidiReceiveEnabled, forObject: instrumentDataObj),
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
            
            midiReceiveEnabled.visibilityTargets = [[4,1,2]]
            
            let midiReceiveChannel:DisclosureCellData = DisclosureCellData(
                withCheckmarkTableDataSource: midiReceiveChannelData,
                isVisible: midiReceiveEnabledBool
            )
            
            let midiSources:DisclosureCellData = DisclosureCellData(
                withCheckmarkTableDataSource: midiSourcesData,
                isVisible: midiReceiveEnabledBool
            )
            
            let midiReceiveSection:SectionData = SectionData(
                header: "MIDI Receive",
                footerType: XvSetConstants.FOOTER_TYPE_NONE,
                footerText: nil,
                footerLink: nil,
                footerHeight: 50,
                cells: [midiReceiveEnabled, midiReceiveChannel, midiSources],
                isVisible: true
            )
            
            sections.append(midiReceiveSection)
            
        } else {
            print("SETTINGS: Error: Unable to initialize midiReceiveSection in instrument table")
        }
    }
}
