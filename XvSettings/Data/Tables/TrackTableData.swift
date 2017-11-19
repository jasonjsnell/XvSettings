//
//  TrackTableData.swift
//  XvSettings
//
//  Created by Jason Snell on 6/19/17.
//  Copyright © 2017 Jason J. Snell. All rights reserved.
//

import Foundation
import CoreData

public class TrackTableData:TableData {
    
    public init(trackDataObj:NSManagedObject){
        
        super.init()
        
        //save for future ref
        xvcdm.currTrack = trackDataObj
        
        //MARK: Header
        if let trackDisplayName:String = xvcdm.getString(
            forKey: XvSetConstants.kSampleDisplayName,
            forObject: trackDataObj
            ) {
            
            title = trackDisplayName
            
        } else {
            print("SETTINGS: Error getting track display name for track table header")
        }
        
        //MARK: Sample
        if let audioEnabledBool:Bool = xvcdm.getBool(forKey: XvSetConstants.kSampleActive, forObject: trackDataObj) {
            
            let audioEnabled:ToggleCellData = ToggleCellData(
                key: XvSetConstants.kSampleActive,
                value: audioEnabledBool,
                textLabel: Labels.SAMPLE_LABEL,
                levelType: XvSetConstants.LEVEL_TYPE_TRACK,
                isVisible: true
            )
            
            let sampleSection:SectionData = SectionData(
                header: Labels.SAMPLE_HEADER,
                footerType: XvSetConstants.FOOTER_TYPE_NORMAL,
                footerText: ["Activates audio playback for this track."],
                footerLink: nil,
                footerHeight: 50,
                cells: [audioEnabled],
                isVisible: true
            )
            
            sections.append(sampleSection)
            
        } else {
            
            print("SETTINGS: Data is invalid when creating sample section")
            
        }
       
        
        //MARK: Quantization
        if let quantizationData:QuantizationData = QuantizationData(withInstrDataObj: trackDataObj)
            
        {
            
            let quantization:DisclosureCellData = DisclosureCellData(
                withCheckmarkTableDataSource: quantizationData,
                isVisible: true)
            
            let quantizationSection:SectionData = SectionData(
                header: Labels.COMPOSITION_HEADER,
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
        
        //MARK: Loop length
        
        if let loopLengthData:LoopLengthData = LoopLengthData(withInstrDataObj: trackDataObj)
            
        {
            
            let loopLength:DisclosureCellData = DisclosureCellData(
                withCheckmarkTableDataSource: loopLengthData,
                isVisible: true)
            
            let loopLengthSection:SectionData = SectionData(
                header: "",
                footerType: XvSetConstants.FOOTER_TYPE_NORMAL,
                footerText: ["Loop length determines how many times the note will repeat in the 8 measure loop. "],
                footerLink: nil,
                footerHeight: 50,
                cells: [loopLength],
                isVisible: true
            )
            
            sections.append(loopLengthSection)
            
        } else {
            
            print("SETTINGS: Data is invalid when creating composition section")
            
        }
        
        //MARK: Duration
        
        if let ampReleaseData:AmpReleaseData = AmpReleaseData(withInstrDataObj: trackDataObj)
            
            
            {
                
                let ampRelease:DisclosureCellData = DisclosureCellData(
                    withCheckmarkTableDataSource: ampReleaseData,
                    isVisible: true)
                
                let ampReleaseSection:SectionData = SectionData(
                    header: "",
                    footerType: XvSetConstants.FOOTER_TYPE_NORMAL,
                    footerText: ["Release determines how many measures the note will play before fading out and regenerating."],
                    footerLink: nil,
                    footerHeight: 50,
                    cells: [ampRelease],
                    isVisible: true
                )
                
                sections.append(ampReleaseSection)
            
        } else {
            
            print("SETTINGS: Data is invalid when creating release section")
            
        }
        
        //MARK: Volume
        if let volumeFloat:Float = xvcdm.getFloat(
            forKey: XvSetConstants.kTrackVolume,
            forObject: trackDataObj),
            
            let fadeOutBool:Bool = xvcdm.getBool(
                forKey: XvSetConstants.kTrackVolumeLock,
                forObject: trackDataObj)
            
        
        {
            
            let volume:SliderCellData = SliderCellData(
                key: XvSetConstants.kTrackVolume,
                value: volumeFloat,
                valueMin: 0.01,
                valueMax: 1.0,
                textLabel: Labels.VOLUME_LABEL,
                dataType: XvSetConstants.DATA_TYPE_FLOAT,
                levelType: XvSetConstants.LEVEL_TYPE_TRACK,
                isVisible: true)
            
           

            let volumeLock:ToggleCellData = ToggleCellData(
                key: XvSetConstants.kTrackVolumeLock,
                value: fadeOutBool,
                textLabel: "Volume Lock",
                levelType: XvSetConstants.LEVEL_TYPE_TRACK,
                isVisible: true
            )
            
            let soundSection:SectionData = SectionData(
                header: Labels.VOLUME_HEADER,
                footerType: XvSetConstants.FOOTER_TYPE_NORMAL,
                footerText: ["This prevents the track from ever fading out."],
                footerLink: nil,
                footerHeight: 50,
                cells: [volume, volumeLock],
                isVisible: true
            )
            
            sections.append(soundSection)
            
        } else {
            
            print("SETTINGS: Data is invalid when creating sound section")
            
        }
        
        //MARK: Sound: Pitch
        if let tuneInt:Int = xvcdm.getInteger(
            forKey: XvSetConstants.kTrackTune,
            forObject: trackDataObj),
            
            let pitchEnabledBool:Bool = xvcdm.getBool(
                forKey: XvSetConstants.kTrackPitchEnabled,
                forObject: trackDataObj),
            
            let randomizedPitchBool:Bool = xvcdm.getBool(
                forKey: XvSetConstants.kTrackRandomizedPitch,
                forObject: trackDataObj),
            
            let octaveCenterInt:Int = xvcdm.getInteger(
                forKey: XvSetConstants.kTrackOctaveCenter,
                forObject: trackDataObj),
            
            let octaveRangeInt:Int = xvcdm.getInteger(
                forKey: XvSetConstants.kTrackOctaveRange,
                forObject: trackDataObj)
        {
            
            let tune:SliderCellData = SliderCellData(
                key: XvSetConstants.kTrackTune,
                value: Float(tuneInt),
                valueMin: -6,
                valueMax: 6,
                textLabel: Labels.TUNE_LABEL,
                dataType: XvSetConstants.DATA_TYPE_INTEGER,
                levelType: XvSetConstants.LEVEL_TYPE_TRACK,
                isVisible: true)
            
            let pitchEnabled:ToggleCellData = ToggleCellData(
                key: XvSetConstants.kTrackPitchEnabled,
                value: pitchEnabledBool,
                textLabel: Labels.PITCH_ENABLED_LABEL,
                levelType: XvSetConstants.LEVEL_TYPE_TRACK,
                isVisible: true
            )
            
            pitchEnabled.visibilityTargets = [[sections.count, 2, 3, 4]]
            
            let octaveCenter:SliderCellData = SliderCellData(
                key: XvSetConstants.kTrackOctaveCenter,
                value: Float(octaveCenterInt),
                valueMin: -2,
                valueMax: 8,
                textLabel: Labels.OCTAVE_CENTER_LABEL,
                dataType: XvSetConstants.DATA_TYPE_INTEGER,
                levelType: XvSetConstants.LEVEL_TYPE_TRACK,
                isVisible: pitchEnabledBool)
            
            let octaveRange:SliderCellData = SliderCellData(
                key: XvSetConstants.kTrackOctaveRange,
                value: Float(octaveRangeInt),
                valueMin: 1,
                valueMax: 10,
                textLabel: Labels.OCTAVE_RANGE_LABEL,
                dataType: XvSetConstants.DATA_TYPE_INTEGER,
                levelType: XvSetConstants.LEVEL_TYPE_TRACK,
                isVisible: pitchEnabledBool)
            
            //create link between highest and lowest slider cell data objects
            //(when sliders were a high and low value in a range
            //octaveLowest.set(linkedSliderCellData: octaveHighest, asType: XvSetConstants.LISTENER_MAX)
            //octaveHighest.set(linkedSliderCellData: octaveLowest, asType: XvSetConstants.LISTENER_MIN)
            
            
            let randomizedPitch:ToggleCellData = ToggleCellData(
                key: XvSetConstants.kTrackRandomizedPitch,
                value: randomizedPitchBool,
                textLabel: Labels.RANDOMIZED_PITCH_LABEL,
                levelType: XvSetConstants.LEVEL_TYPE_TRACK,
                isVisible: pitchEnabledBool
            )
            
            
            let pitchSection:SectionData = SectionData(
                header: Labels.PITCH_HEADER,
                footerType: XvSetConstants.FOOTER_TYPE_NONE,
                footerText: nil,
                footerLink: nil,
                footerHeight: 10,
                cells: [tune, pitchEnabled, octaveCenter, octaveRange, randomizedPitch],
                isVisible: true
            )
            
            sections.append(pitchSection)
            
        } else {
            
            print("SETTINGS: Data is invalid when creating pitch section")
            
        }
        
        
        //MARK: MIDI send
        //make sure midi core data is valid
        if let midiSendEnabledBool:Bool = xvcdm.getBool(
            forKey: XvSetConstants.kTrackMidiSendEnabled,
            forObject: trackDataObj),
            
            let midiSendChannelData:MidiSendChannelData = MidiSendChannelData(withInstrDataObj: trackDataObj),
            
            let midiDestinationsData:TrackMidiDestinationsData = TrackMidiDestinationsData(withInstrDataObj: trackDataObj)
        {
            
            let midiSendEnabled:ToggleCellData = ToggleCellData(
                key: XvSetConstants.kTrackMidiSendEnabled,
                value: midiSendEnabledBool,
                textLabel: "MIDI Send",
                levelType: XvSetConstants.LEVEL_TYPE_TRACK,
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
            print("SETTINGS: Error: Unable to initialize midiSendSection in track table")
        }
        
        //MARK: MIDI Receive
        //make sure core data is valid
        if let midiReceiveEnabledBool:Bool = xvcdm.getBool(forKey: XvSetConstants.kTrackMidiReceiveEnabled, forObject: trackDataObj),
            let midiReceiveChannelData:MidiReceiveChannelData = MidiReceiveChannelData(withInstrDataObj: trackDataObj)
        {
            
            let midiReceiveEnabled:ToggleCellData = ToggleCellData(
                key: XvSetConstants.kTrackMidiReceiveEnabled,
                value: midiReceiveEnabledBool,
                textLabel: "MIDI Receive",
                levelType: XvSetConstants.LEVEL_TYPE_TRACK,
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
                footerHeight: 100,
                cells: [midiReceiveEnabled, midiReceiveChannel],
                isVisible: true
            )
            
            sections.append(midiReceiveSection)
            
        } else {
            print("SETTINGS: Error: Unable to initialize midiReceiveSection in track table")
        }
        
        
        
    }
}
