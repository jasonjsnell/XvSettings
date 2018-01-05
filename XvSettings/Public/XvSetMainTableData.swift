//
//  SetData.swift
//  RF Settings
//
//  Created by Jason Snell on 10/22/16.
//  Copyright © 2016 Jason J. Snell. All rights reserved.
//


//this is the main table data class, launched from the root view controller

/*
 Basic data flow:
 1. At launch, pull info from core data to track classes
 2. During play, info is grabbed from track classes
 3. Settings panel loads the core data info
 4. Settings panel changes core data info
 4. When settings panel is closed, push core data to track classes
 */

import Foundation
import CoreData

public class XvSetMainTableData:TableData {
    
    
    //MARK:- INIT -
    //build cells and put them into sections
    
    override public func refresh() {
        
        super.refresh()
        
        title = "Settings"
        
        //MARK: Tracks section
        
        //try to get sample bank data array from core data
        if let currConfigFile:NSManagedObject = xvcdm.currConfigFile,
            let sampleBankDataObjs:[NSManagedObject] = xvcdm.sampleBanks as? [NSManagedObject],
            let trackDataObjs:[NSManagedObject] = xvcdm.tracks as? [NSManagedObject] {
            
            //this builds the tracks disclosure cells, but using the names from the sample banks because they are more user friendly
            var trackDisclosureCellDataArray:[DisclosureCellData] = []
            
            // loop through each sample bank
            
            for i in 0..<sampleBankDataObjs.count {
                
                let sampleBankDataObj:NSManagedObject = sampleBankDataObjs[i]
                let trackDataObj:NSManagedObject = trackDataObjs[i]
                
                if let sampleDisplayName:String = xvcdm.getString(
                    forKey: XvSetConstants.kSampleBankDisplayName,
                    forObject: sampleBankDataObj
                    ),
                    
                    //is the sample active
                    let sampleActive:Bool = xvcdm.getBool(
                        forKey: XvSetConstants.kSampleBankActive,
                        forObject: sampleBankDataObj
                    ),
                    
                    let midiActive:Bool = xvcdm.getBool(
                        forKey: XvSetConstants.kTrackMidiSendEnabled,
                        forObject: trackDataObj
                    ),
                    
                    //get global midi destinations
                    let globalMidiDestinations:[String] = xvcdm.getArray(
                        forKey: XvSetConstants.kConfigGlobalMidiDestinations,
                        forObject: currConfigFile
                        ) as? [String],
                    
                    //get track midi destinations
                    let trackMidiDestinations:[String] = xvcdm.getArray(
                        forKey: XvSetConstants.kTrackMidiDestinations,
                        forObject: trackDataObj
                        ) as? [String],
            
                    //use position as the key, it is unique
                    let position:Int = xvcdm.getInteger(
                        forKey: XvSetConstants.kSampleBankPosition,
                        forObject: sampleBankDataObj
                    ) {
                    
                    let key:String = XvSetConstants.kTrackEntity + String(describing: position)
                    
                    //create base of text string ("Track 1")
                    var textLabel:String = "T" + String(describing: (position+1)) + ": "
                    
                    //prep vars
                    var midiText:String = ""
                    var isTrackGlobal:Bool = false
                    var isGlobalOmni:Bool = false
                    
                    if (trackMidiDestinations.contains(XvSetConstants.MIDI_DESTINATION_GLOBAL)) {
                        isTrackGlobal = true
                    }
                    
                    if (globalMidiDestinations.contains(XvSetConstants.MIDI_DESTINATION_OMNI)) {
                        isGlobalOmni = true
                    }
                    
                    //if midi is active
                    if (midiActive){
                        
                        //determine midi string
                        midiText = "MIDI: "
                        
                        //grab the track destinations no matter what
                        var selectedDestinations:[String] = trackMidiDestinations
                        
                        //if track has global, then grab those
                        if (isTrackGlobal) {
                            
                            selectedDestinations = Array(Set(selectedDestinations + globalMidiDestinations))
                            
                            //if global has omni, then include all available
                            if (isGlobalOmni) {
                                
                                selectedDestinations = Array(Set(selectedDestinations + xvcdm.midiDestinationNames))
                            }
                        }
                        
                        let selectedAndAvailableDestinations:[String] = selectedDestinations.filter(xvcdm.midiDestinationNames.contains)
                        
                        if (selectedAndAvailableDestinations.count == 1) {
                            
                            midiText += selectedAndAvailableDestinations[0]
                            
                        } else if (selectedAndAvailableDestinations.count > 1) {
                            
                            if (isTrackGlobal && isGlobalOmni) {
                                
                                midiText += "Omni"
                            } else {
                                midiText += "Multiple"
                            }
                            
                        } else if (selectedAndAvailableDestinations.count == 0) {
                            
                            midiText += "None"
                        }
                        
                    }
                    
                    //if the sample is active, put sample name, then midi
                    var sampleText:String = ""
                    
                    if (sampleActive){
                        
                        sampleText += sampleDisplayName
                    
                    }
                    
                    var connector:String = ""
                    if (sampleText != "" && midiText != "") {
                        connector = " | "
                    }
                    
                    if (sampleText == "" && midiText == ""){
                        textLabel += "None"
                    } else {
                        textLabel += sampleText + connector + midiText
                    }
                   
                
                    let trackDisclosureCellData:DisclosureCellData = DisclosureCellData(
                        key: key,
                        textLabel: textLabel,
                        isVisible: true
                    )
                    
                    trackDisclosureCellDataArray.append(trackDisclosureCellData)
                    
                } else {
                    print("SETTINGS: Error getting sample bank display name during track table init")
                }
                
            }
            
            let tracksSection:SectionData = SectionData(
                header: "Tracks",
                footerType: XvSetConstants.FOOTER_TYPE_NONE,
                footerText: nil,
                footerLink: nil,
                footerHeight: 10,
                cells: trackDisclosureCellDataArray,
                isVisible: true
            )
            
            sections.append(tracksSection)
            
        } else {
            print("SETTINGS: Unable to find tracks data array during XvSetMainTableData init")
        }
        
        
        //MARK: Musical scale
        
        let musicalScale:DisclosureCellData = DisclosureCellData(
            key: XvSetConstants.kConfigMusicalScale,
            textLabel: Labels.MUSIC_SCALE_LABEL,
            isVisible: true
        )
        
        let musicalScaleSection:SectionData = SectionData(
            header: "Musical Scale",
            footerType: XvSetConstants.FOOTER_TYPE_NONE,
            footerText: nil,
            footerLink: nil,
            footerHeight: 10,
            cells: [musicalScale],
            isVisible: true
        )
        
        sections.append(musicalScaleSection)

        
    
        //MARK: Tempo
        
        /*
        if let currConfigFile:NSManagedObject = xvcdm.currConfigFile {
            
            if let tempoInt:Int = xvcdm.getInteger(forKey: XvSetConstants.kConfigTempo, forObject: currConfigFile) {
                
                let tempo:SliderCellData = SliderCellData(
                    key: XvSetConstants.kConfigTempo,
                    value: tempoInt,
                    valueMin: 50,
                    valueMax: 200,
                    textLabel: Labels.TEMPO_LABEL,
                    dataType: XvSetConstants.DATA_TYPE_INTEGER,
                    levelType: XvSetConstants.LEVEL_TYPE_CONFIG,
                    isVisible: true)
                
                let tempoSection:SectionData = SectionData(
                    header: Labels.TEMPO_LABEL,
                    footerType: XvSetConstants.FOOTER_TYPE_NONE,
                    footerText: nil,
                    footerLink: nil,
                    footerHeight: 10,
                    cells: [tempo],
                    isVisible: true
                )
                
                sections.append(tempoSection)
                
            } else {
                
                print("SETTINGS: Error getting tempo during main table init")
            }
            
        } else {
            
            print("SETTINGS: Error getting currConfigFile when making tempo slider")
        }
        */

        
        //MARK: Sync
        
        //link bool is set by ABLink framework, not user pref
        
        //what do we need when a disclosure cell shows a non checkmark table?
        //key (for id purposes in table class)
        //label for visual name
        
        //only show if audiobus is off
        if (!xvcdm.audioBusMidiBypass){
            
            let abletonLink:DisclosureCellData = DisclosureCellData(
                key: XvSetConstants.kConfigAbletonLinkEnabled,
                textLabel: "Ableton Link",
                isVisible: true
            )
            
            if let midiSyncData:MidiSyncData = MidiSyncData(){
                
                let midiSync:DisclosureCellData = DisclosureCellData(
                    withCheckmarkTableDataSource: midiSyncData,
                    isVisible: true
                )
                
                let syncSection:SectionData = SectionData(
                    header: "Sync",
                    footerType: XvSetConstants.FOOTER_TYPE_NORMAL,
                    footerText: ["MIDI sync cannot be used if Ableton Link is active."],
                    footerLink: nil,
                    footerHeight: 50,
                    cells: [abletonLink, midiSync],
                    isVisible: true
                )
                
                sections.append(syncSection)
                
            } else {
                print("SETTINGS: Error: Unable to get midiSyncData in main table")
            }
            
        }
        
        
        
        
        //MARK: MIDI
       //only show if audiobus is off
        if (!xvcdm.audioBusMidiBypass){
            
            if let midiDestinationsData:GlobalMidiDestinationsData = GlobalMidiDestinationsData(),
                let midiSourcesData:GlobalMidiSourcesData = GlobalMidiSourcesData(){
                
                let midiDestinations:DisclosureCellData = DisclosureCellData(
                    withCheckmarkTableDataSource: midiDestinationsData,
                    isVisible: true
                )
                
                let midiSources:DisclosureCellData = DisclosureCellData(
                    withCheckmarkTableDataSource: midiSourcesData,
                    isVisible: true
                )
                
                let midiRoutingSection:SectionData = SectionData(
                    header: "Global MIDI Routing",
                    footerType: XvSetConstants.FOOTER_TYPE_NORMAL,
                    footerText: ["These set the default MIDI destinations and sources."],
                    footerLink: nil,
                    footerHeight: 50,
                    cells: [midiDestinations, midiSources],
                    isVisible: true
                )
                
                sections.append(midiRoutingSection)
                
            } else {
                
                print("SETTINGS: Error get midi routing data from core data in main table data")
            }
            
        }
        
        
        
        //MARK: BG Mode
        //only show if audiobus is off
        if (!xvcdm.audioBusMidiBypass){
            
            if let currConfigFile:NSManagedObject = xvcdm.currConfigFile,
                let bgModeBool:Bool = xvcdm.getBool(
                    forKey: XvSetConstants.kConfigBackgroundModeEnabled,
                    forObject: currConfigFile) {
                
                let bgMode:ToggleCellData = ToggleCellData(
                    key: XvSetConstants.kConfigBackgroundModeEnabled,
                    value: bgModeBool,
                    textLabel: "Background Mode",
                    levelType: XvSetConstants.LEVEL_TYPE_CONFIG,
                    isVisible: true
                )
                
                let modesSection:SectionData = SectionData(
                    header: "Background Mode",
                    footerType: XvSetConstants.FOOTER_TYPE_NORMAL,
                    footerText: ["Activate this to keep the app running in the background."],
                    footerLink: nil,
                    footerHeight: 60,
                    cells: [bgMode],
                    isVisible: true
                )
                
               sections.append(modesSection)
                
            } else {
                print("SETTINGS: Error: Unable to get bg mode bool in main table")
            }
            
        }
        
        
        
        
        
        //MARK: Artificial Intelligence
        let artificialIntelligence:ButtonCellData = ButtonCellData(
            key: XvSetConstants.kConfigArtificialIntelligence,
            textLabel: "Reset AI Memory",
            levelType: XvSetConstants.LEVEL_TYPE_NONE,
            isVisible: true
        )
        
        let artificialIntelligenceSection:SectionData = SectionData(
            header: "Artificial Intelligence",
            footerType: XvSetConstants.FOOTER_TYPE_NORMAL,
            footerText: ["This clears the AI memory and resets it to the factory state."],
            footerLink: nil,
            footerHeight: 60,
            cells: [artificialIntelligence],
            isVisible: true
        )
        
        sections.append(artificialIntelligenceSection)
        
        
        
        
        //MARK: Rearrange
        
        /*
        let rearrangeButton:ButtonCellData = ButtonCellData(
            key: XvSetConstants.kAppRearrange,
            textLabel: "Rearrange",
            levelType: XvSetConstants.LEVEL_TYPE_NONE,
            isVisible: true
        )
        
        let rearrangeSection:SectionData = SectionData(
            header: "Composition",
            footerType: XvSetConstants.FOOTER_TYPE_LINK,
            footerText: ["This rearranges the current composition into a new, randomized one. You can also execute this by shaking your device. For more information, see the ", "user's manual", "."],
            footerLink: "http://app.jasonjsnell.com/repercussion/manual/",
            footerHeight: 75,
            cells: [rearrangeButton],
            isVisible: true
        )
        
        sections.append(rearrangeSection)
        */
        
        //MARK: Factory settings
        
        let factorySettings:ButtonCellData = ButtonCellData(
            key: XvSetConstants.kTracksFactorySettings,
            textLabel: "Reset Tracks to Default",
            levelType: XvSetConstants.LEVEL_TYPE_NONE,
            isVisible: true
        )
        
        let factorySettingsSection:SectionData = SectionData(
            header: "Factory Settings",
            footerType: XvSetConstants.FOOTER_TYPE_NORMAL,
            footerText: ["This resets the tracks back to their factory settings."],
            footerLink: nil,
            footerHeight: 70,
            cells: [factorySettings],
            isVisible: true
        )
        
        sections.append(factorySettingsSection)
        
        //MARK: Support
        
        let userManualButton:ButtonCellData = ButtonCellData(
            key: XvSetConstants.kAppUserManual,
            textLabel: "User Manual",
            levelType: XvSetConstants.LEVEL_TYPE_NONE,
            isVisible: true
        )
        
        let emailDeveloperButton:ButtonCellData = ButtonCellData(
            key: XvSetConstants.kAppEmailDeveloper,
            textLabel: "Email Developer",
            levelType: XvSetConstants.LEVEL_TYPE_NONE,
            isVisible: true
        )
        
        let supportSection:SectionData = SectionData(
            header: "Support",
            footerType: XvSetConstants.FOOTER_TYPE_NONE,
            footerText: nil,
            footerLink: nil,
            footerHeight: 70,
            cells: [userManualButton, emailDeveloperButton],
            isVisible: true
        )
        
        sections.append(supportSection)
        
    }
    
}
