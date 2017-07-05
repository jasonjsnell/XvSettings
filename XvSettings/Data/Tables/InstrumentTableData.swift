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
        
        
        //MARK: Loop
        
        if let loopLengthData:LoopLengthData = LoopLengthData(withInstrDataObj: instrumentDataObj),
            
            let regenerateBool:Bool = xvcdm.getBool(
                forKey: XvSetConstants.kInstrumentRegenerateAtBeginningOfPattern,
                forObject: instrumentDataObj),
            
            let fadeOutDurationData:FadeOutDurationData = FadeOutDurationData(withInstrDataObj: instrumentDataObj),
            
            let fadeOutBool:Bool = xvcdm.getBool(
                forKey: XvSetConstants.kInstrumentFadeOut,
                forObject: instrumentDataObj)
            
            {
                
               
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
                
                let fadeOut:ToggleCellData = ToggleCellData(
                    key: XvSetConstants.kInstrumentFadeOut,
                    value: fadeOutBool,
                    textLabel: Labels.FADE_OUT_LABEL,
                    levelType: XvSetConstants.LEVEL_TYPE_INSTRUMENT,
                    isVisible: true
                )
                
                fadeOut.visibilityTargets = [[0, 3]]
                
                let fadeOutDuration:DisclosureCellData = DisclosureCellData(
                    withCheckmarkTableDataSource: fadeOutDurationData,
                    isVisible: fadeOutBool)
                
                let loopSection:SectionData = SectionData(
                    header: "Loop",
                    footerType: XvSetConstants.FOOTER_TYPE_NONE,
                    footerText: nil,
                    footerLink: nil,
                    footerHeight: 10,
                    cells: [loopLength, regenerate, fadeOut, fadeOutDuration],
                    isVisible: true
                )
                
                sections.append(loopSection)
            
        } else {
            
            print("SETTINGS: Data is invalid when creating composition section")
            
        }
        
        //MARK: Volume
        if let volumeFloat:Float = xvcdm.getFloat(
            forKey: XvSetConstants.kInstrumentVolume,
            forObject: instrumentDataObj) {
            
            let volume:SliderCellData = SliderCellData(
                key: XvSetConstants.kInstrumentVolume,
                value: volumeFloat,
                valueMin: 0.01,
                valueMax: 1.0,
                textLabel: Labels.VOLUME_LABEL,
                dataType: XvSetConstants.DATA_TYPE_FLOAT,
                levelType: XvSetConstants.LEVEL_TYPE_INSTRUMENT,
                isVisible: true)
            
            let volumeSection:SectionData = SectionData(
                header: Labels.VOLUME_HEADER,
                footerType: XvSetConstants.FOOTER_TYPE_NONE,
                footerText: nil,
                footerLink: nil,
                footerHeight: 10,
                cells: [volume],
                isVisible: true
            )
            
            sections.append(volumeSection)
            
        } else {
            
            print("SETTINGS: Data is invalid when creating volume section")
            
        }
        
        

        
        //MARK: Quantization
        if let quantizationData:QuantizationData = QuantizationData(withInstrDataObj: instrumentDataObj) {
            
            let quantization:DisclosureCellData = DisclosureCellData(
                withCheckmarkTableDataSource: quantizationData,
                isVisible: true)
            
            
            let quantizationSection:SectionData = SectionData(
                header: Labels.QUANTIZATION_HEADER,
                footerType: XvSetConstants.FOOTER_TYPE_NONE,
                footerText: nil,
                footerLink: nil,
                footerHeight: 10,
                cells: [quantization],
                isVisible: true
            )
            
            sections.append(quantizationSection)
            
        } else {
            
            print("SETTINGS: Data is invalid when creating quantization section")
            
        }

        
        
        //MARK: Pitch
        
        if let pitchEnabledBool:Bool = xvcdm.getBool(
            forKey: XvSetConstants.kInstrumentPitchEnabled,
            forObject: instrumentDataObj),
            
            let randomizedPitchBool:Bool = xvcdm.getBool(
                forKey: XvSetConstants.kInstrumentRandomizedPitch,
                forObject: instrumentDataObj),
        
            let octaveHighestInt:Int = xvcdm.getInteger(
                forKey: XvSetConstants.kInstrumentOctaveHighest,
                forObject: instrumentDataObj),
            
            let octaveLowestInt:Int = xvcdm.getInteger(
                forKey: XvSetConstants.kInstrumentOctaveLowest,
                forObject: instrumentDataObj)
            
        {
            
            let pitchEnabled:ToggleCellData = ToggleCellData(
                key: XvSetConstants.kInstrumentPitchEnabled,
                value: pitchEnabledBool,
                textLabel: Labels.PITCH_ENABLED_LABEL,
                levelType: XvSetConstants.LEVEL_TYPE_INSTRUMENT,
                isVisible: true
            )
            
            pitchEnabled.visibilityTargets = [[3, 1, 2, 3]]
            
            let octaveLowest:SliderCellData = SliderCellData(
                key: XvSetConstants.kInstrumentOctaveLowest,
                value: Float(octaveLowestInt),
                valueMin: 0,
                valueMax: 10,
                textLabel: Labels.OCTAVE_LOWEST_LABEL,
                dataType: XvSetConstants.DATA_TYPE_INTEGER,
                levelType: XvSetConstants.LEVEL_TYPE_INSTRUMENT,
                isVisible: pitchEnabledBool)
            
            let octaveHighest:SliderCellData = SliderCellData(
                key: XvSetConstants.kInstrumentOctaveHighest,
                value: Float(octaveHighestInt),
                valueMin: 0,
                valueMax: 10,
                textLabel: Labels.OCTAVE_HIGHEST_LABEL,
                dataType: XvSetConstants.DATA_TYPE_INTEGER,
                levelType: XvSetConstants.LEVEL_TYPE_INSTRUMENT,
                isVisible: pitchEnabledBool)
            
            //create link between highest and lowest slider cell data objects
            octaveLowest.set(linkedSliderCellData: octaveHighest, asType: XvSetConstants.LISTENER_MAX)
            octaveHighest.set(linkedSliderCellData: octaveLowest, asType: XvSetConstants.LISTENER_MIN)
            
            
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
                cells: [pitchEnabled, octaveHighest, octaveLowest, randomizedPitch],
                isVisible: true
            )
            
            sections.append(pitchSection)
            
        } else {
            
            print("SETTINGS: Data is invalid when creating pitch section")
            
        }
        
        //MARK: Pan
        if let panFloat:Float = xvcdm.getFloat(
            forKey: XvSetConstants.kInstrumentPan,
            forObject: instrumentDataObj) {
            
            let pan:SliderCellData = SliderCellData(
                key: XvSetConstants.kInstrumentPan,
                value: panFloat,
                valueMin: -1.0,
                valueMax: 1.0,
                textLabel: Labels.PAN_LABEL,
                dataType: XvSetConstants.DATA_TYPE_FLOAT,
                levelType: XvSetConstants.LEVEL_TYPE_INSTRUMENT,
                isVisible: true)
            
            let panSection:SectionData = SectionData(
                header: Labels.PAN_HEADER,
                footerType: XvSetConstants.FOOTER_TYPE_NONE,
                footerText: nil,
                footerLink: nil,
                footerHeight: 10,
                cells: [pan],
                isVisible: true
            )
            
            sections.append(panSection)
            
        } else {
            
            print("SETTINGS: Data is invalid when creating pan section")
            
        }
        
        
        //MARK: MIDI send
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
            
            midiSendEnabled.visibilityTargets = [[5,1,2]]
            
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
        
        //MARK: MIDI Receive
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
            
            midiReceiveEnabled.visibilityTargets = [[6,1,2]]
            
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
                footerHeight: 10,
                cells: [midiReceiveEnabled, midiReceiveChannel, midiSources],
                isVisible: true
            )
            
            sections.append(midiReceiveSection)
            
        } else {
            print("SETTINGS: Error: Unable to initialize midiReceiveSection in instrument table")
        }
        
        
        //MARK: Audio enabled
        if let audioEnabledBool:Bool = xvcdm.getBool(forKey: XvSetConstants.kInstrumentAudioEnabled, forObject: instrumentDataObj)
        {
            
            let audioEnabled:ToggleCellData = ToggleCellData(
                key: XvSetConstants.kInstrumentAudioEnabled,
                value: audioEnabledBool,
                textLabel: Labels.AUDIO_ENABLED_LABEL,
                levelType: XvSetConstants.LEVEL_TYPE_INSTRUMENT,
                isVisible: true
            )
            
            
            let audioSection:SectionData = SectionData(
                header: Labels.AUDIO_ENABLED_HEADER,
                footerType: XvSetConstants.FOOTER_TYPE_NONE,
                footerText: nil,
                footerLink: nil,
                footerHeight: 50,
                cells: [audioEnabled],
                isVisible: true
            )
            
            sections.append(audioSection)
            
        } else {
            print("SETTINGS: Error: Unable to initialize midiReceiveSection in instrument table")
        }
    }
}
