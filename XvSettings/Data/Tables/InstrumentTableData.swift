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
        
        if let quantizationData:QuantizationData = QuantizationData(withInstrDataObj: instrumentDataObj),
            
            let loopLengthData:LoopLengthData = LoopLengthData(withInstrDataObj: instrumentDataObj),
            
            let regenerateBool:Bool = xvcdm.getBool(
                forKey: XvSetConstants.kInstrumentRegenerateAtBeginningOfPattern,
                forObject: instrumentDataObj),
            
            let fadeOutDurationData:FadeOutDurationData = FadeOutDurationData(withInstrDataObj: instrumentDataObj),
            
            let fadeOutBool:Bool = xvcdm.getBool(
                forKey: XvSetConstants.kInstrumentFadeOut,
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
                
                let fadeOut:ToggleCellData = ToggleCellData(
                    key: XvSetConstants.kInstrumentFadeOut,
                    value: fadeOutBool,
                    textLabel: Labels.FADE_OUT_LABEL,
                    levelType: XvSetConstants.LEVEL_TYPE_INSTRUMENT,
                    isVisible: true
                )
                
                fadeOut.visibilityTargets = [[sections.count, 4]]
                
                let fadeOutDuration:DisclosureCellData = DisclosureCellData(
                    withCheckmarkTableDataSource: fadeOutDurationData,
                    isVisible: fadeOutBool)
                
                let compositionSection:SectionData = SectionData(
                    header: Labels.COMPOSITION_HEADER,
                    footerType: XvSetConstants.FOOTER_TYPE_NONE,
                    footerText: nil,
                    footerLink: nil,
                    footerHeight: 10,
                    cells: [quantization, loopLength, regenerate, fadeOut, fadeOutDuration],
                    isVisible: true
                )
                
                sections.append(compositionSection)
            
        } else {
            
            print("SETTINGS: Data is invalid when creating composition section")
            
        }
        
        //MARK: Sound
        if let volumeFloat:Float = xvcdm.getFloat(
            forKey: XvSetConstants.kInstrumentVolume,
            forObject: instrumentDataObj),
            
            let panFloat:Float = xvcdm.getFloat(
                forKey: XvSetConstants.kInstrumentPan,
                forObject: instrumentDataObj),
            
            let audioEnabledBool:Bool = xvcdm.getBool(forKey: XvSetConstants.kInstrumentAudioEnabled, forObject: instrumentDataObj)
        
        {
            
            let volume:SliderCellData = SliderCellData(
                key: XvSetConstants.kInstrumentVolume,
                value: volumeFloat,
                valueMin: 0.01,
                valueMax: 1.0,
                textLabel: Labels.VOLUME_LABEL,
                dataType: XvSetConstants.DATA_TYPE_FLOAT,
                levelType: XvSetConstants.LEVEL_TYPE_INSTRUMENT,
                isVisible: true)
            
            let pan:SliderCellData = SliderCellData(
                key: XvSetConstants.kInstrumentPan,
                value: panFloat,
                valueMin: -1.0,
                valueMax: 1.0,
                textLabel: Labels.PAN_LABEL,
                dataType: XvSetConstants.DATA_TYPE_FLOAT,
                levelType: XvSetConstants.LEVEL_TYPE_INSTRUMENT,
                isVisible: true)


            let audioEnabled:ToggleCellData = ToggleCellData(
                key: XvSetConstants.kInstrumentAudioEnabled,
                value: audioEnabledBool,
                textLabel: Labels.AUDIO_ENABLED_LABEL,
                levelType: XvSetConstants.LEVEL_TYPE_INSTRUMENT,
                isVisible: true
            )
            
            
            let soundSection:SectionData = SectionData(
                header: Labels.SOUND_HEADER,
                footerType: XvSetConstants.FOOTER_TYPE_NONE,
                footerText: nil,
                footerLink: nil,
                footerHeight: 10,
                cells: [audioEnabled, volume, pan],
                isVisible: true
            )
            
            sections.append(soundSection)
            
        } else {
            
            print("SETTINGS: Data is invalid when creating sound section")
            
        }
        
        //MARK: Sound: Pitch
        if let pitchEnabledBool:Bool = xvcdm.getBool(
                forKey: XvSetConstants.kInstrumentPitchEnabled,
                forObject: instrumentDataObj),
            
            let randomizedPitchBool:Bool = xvcdm.getBool(
                forKey: XvSetConstants.kInstrumentRandomizedPitch,
                forObject: instrumentDataObj),
            
            let octaveCenterInt:Int = xvcdm.getInteger(
                forKey: XvSetConstants.kInstrumentOctaveCenter,
                forObject: instrumentDataObj),
            
            let octaveRangeInt:Int = xvcdm.getInteger(
                forKey: XvSetConstants.kInstrumentOctaveRange,
                forObject: instrumentDataObj)
        {
            
            
            let pitchEnabled:ToggleCellData = ToggleCellData(
                key: XvSetConstants.kInstrumentPitchEnabled,
                value: pitchEnabledBool,
                textLabel: Labels.PITCH_ENABLED_LABEL,
                levelType: XvSetConstants.LEVEL_TYPE_INSTRUMENT,
                isVisible: true
            )
            
            pitchEnabled.visibilityTargets = [[sections.count, 1, 2, 3]]
            
            let octaveCenter:SliderCellData = SliderCellData(
                key: XvSetConstants.kInstrumentOctaveCenter,
                value: Float(octaveCenterInt),
                valueMin: -2,
                valueMax: 8,
                textLabel: Labels.OCTAVE_CENTER_LABEL,
                dataType: XvSetConstants.DATA_TYPE_INTEGER,
                levelType: XvSetConstants.LEVEL_TYPE_INSTRUMENT,
                isVisible: pitchEnabledBool)
            
            let octaveRange:SliderCellData = SliderCellData(
                key: XvSetConstants.kInstrumentOctaveRange,
                value: Float(octaveRangeInt),
                valueMin: 1,
                valueMax: 10,
                textLabel: Labels.OCTAVE_RANGE_LABEL,
                dataType: XvSetConstants.DATA_TYPE_INTEGER,
                levelType: XvSetConstants.LEVEL_TYPE_INSTRUMENT,
                isVisible: pitchEnabledBool)
            
            //create link between highest and lowest slider cell data objects
            //(when sliders were a high and low value in a range
            //octaveLowest.set(linkedSliderCellData: octaveHighest, asType: XvSetConstants.LISTENER_MAX)
            //octaveHighest.set(linkedSliderCellData: octaveLowest, asType: XvSetConstants.LISTENER_MIN)
            
            
            let randomizedPitch:ToggleCellData = ToggleCellData(
                key: XvSetConstants.kInstrumentRandomizedPitch,
                value: randomizedPitchBool,
                textLabel: Labels.RANDOMIZED_PITCH_LABEL,
                levelType: XvSetConstants.LEVEL_TYPE_INSTRUMENT,
                isVisible: pitchEnabledBool
            )
            
            
            let pitchSection:SectionData = SectionData(
                header: "",
                footerType: XvSetConstants.FOOTER_TYPE_NONE,
                footerText: nil,
                footerLink: nil,
                footerHeight: 10,
                cells: [pitchEnabled, octaveCenter, octaveRange, randomizedPitch],
                isVisible: true
            )
            
            sections.append(pitchSection)
            
        } else {
            
            print("SETTINGS: Data is invalid when creating pitch section")
            
        }
        
        

        

        
        
       
       
        
        //MARK: MIDI send
        //make sure midi core data is valid
        if let midiSendEnabledBool:Bool = xvcdm.getBool(
            forKey: XvSetConstants.kInstrumentMidiSendEnabled,
            forObject: instrumentDataObj),
            
            let midiSendChannelData:MidiSendChannelData = MidiSendChannelData(withInstrDataObj: instrumentDataObj),
            
            let midiDestinationsData:InstrumentMidiDestinationsData = InstrumentMidiDestinationsData(withInstrDataObj: instrumentDataObj)
        {
            
            let midiSendEnabled:ToggleCellData = ToggleCellData(
                key: XvSetConstants.kInstrumentMidiSendEnabled,
                value: midiSendEnabledBool,
                textLabel: "MIDI Send",
                levelType: XvSetConstants.LEVEL_TYPE_INSTRUMENT,
                isVisible: true
            )
            
            midiSendEnabled.visibilityTargets = [[sections.count,1,2]]
            
            let midiSendChannel:DisclosureCellData = DisclosureCellData(
                withCheckmarkTableDataSource: midiSendChannelData,
                isVisible: midiSendEnabledBool
            )
            
            let midiDestinations:DisclosureCellData = DisclosureCellData(
                withCheckmarkTableDataSource: midiDestinationsData,
                isVisible: midiSendEnabledBool
            )

            let midiSendSection:SectionData = SectionData(
                header: "MIDI",
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
            let midiReceiveChannelData:MidiReceiveChannelData = MidiReceiveChannelData(withInstrDataObj: instrumentDataObj)
        {
            
            let midiReceiveEnabled:ToggleCellData = ToggleCellData(
                key: XvSetConstants.kInstrumentMidiReceiveEnabled,
                value: midiReceiveEnabledBool,
                textLabel: "MIDI Receive",
                levelType: XvSetConstants.LEVEL_TYPE_INSTRUMENT,
                isVisible: true
            )
            
            midiReceiveEnabled.visibilityTargets = [[sections.count,1]]
            
            let midiReceiveChannel:DisclosureCellData = DisclosureCellData(
                withCheckmarkTableDataSource: midiReceiveChannelData,
                isVisible: midiReceiveEnabledBool
            )
            
            let midiReceiveSection:SectionData = SectionData(
                header: "",
                footerType: XvSetConstants.FOOTER_TYPE_NONE,
                footerText: nil,
                footerLink: nil,
                footerHeight: 10,
                cells: [midiReceiveEnabled, midiReceiveChannel],
                isVisible: true
            )
            
            sections.append(midiReceiveSection)
            
        } else {
            print("SETTINGS: Error: Unable to initialize midiReceiveSection in instrument table")
        }
        
        
        
    }
}
