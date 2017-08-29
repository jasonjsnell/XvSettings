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
 1. At launch, pull info from core data to instrument classes
 2. During play, info is grabbed from instrument classes
 3. Settings panel loads the core data info
 4. Settings panel changes core data info
 4. When settings panel is closed, push core data to instrument classes
 */

import Foundation
import CoreData

public class XvSetMainTableData:TableData {
    
    
    //MARK:- INIT -
    //build cells and put them into sections
    
    override public init() {
        
        super.init()
        
        title = "Settings"
        
        
        
        //MARK: Kits
        
        var kitCheckmarkCellDataArray:[CheckmarkCellData] = []
        var kitDisclosureCellDataArray:[DisclosureCellData] = []
        
        // Loop through the instrument kits and prep two sections
        // 1. Section to select the current kit
        // 2. Section to customize any kit
        
        if let kits:[NSManagedObject] = xvcdm.getKits() {
            
            for i in 0..<kits.count {
                
                let kit:NSManagedObject = kits[i]
                
                if let id:String = xvcdm.getString(forKey: XvSetConstants.kKitID, forObject: kit),
                    let name:String = xvcdm.getString(forKey: XvSetConstants.kKitName, forObject: kit) {
                    
                    var isSelected:Bool = false
                    
                    if (xvcdm.getAppString(forKey: XvSetConstants.kAppSelectedKit) == id){
                        isSelected = true
                    }
                    
                    
                    let instrumentKitCheckmarkCellData:CheckmarkCellData = CheckmarkCellData(
                        key: XvSetConstants.kAppSelectedKit,
                        value: id,
                        textLabel: name,
                        selected: isSelected,
                        multi: false,
                        levelType: XvSetConstants.LEVEL_TYPE_APP,
                        isVisible: true
                    )
                    
        
                    instrumentKitCheckmarkCellData.set(visibilityTargets: [[1, i]])
                    
                    kitCheckmarkCellDataArray.append(instrumentKitCheckmarkCellData)
                  
                    let instrumentKitDisclosureCellData:DisclosureCellData = DisclosureCellData(
                        key: id,
                        textLabel: name,
                        isVisible: isSelected
                    )
                    
                    kitDisclosureCellDataArray.append(instrumentKitDisclosureCellData)
                    
                } else {
                    print("SETTINGS: Error getting kit id and name during main table init")
                }
            }
            
            //MARK: Customize
            
            
            let instrumentKitSelection:SectionData = SectionData(
                header: Labels.KIT_SELECTION_HEADER,
                footerType: XvSetConstants.FOOTER_TYPE_NONE,
                footerText: nil,
                footerLink: nil,
                footerHeight: 10,
                cells: kitCheckmarkCellDataArray,
                isVisible: true
            )
            
            sections.append(instrumentKitSelection)
 
            
            let customizeSection:SectionData = SectionData(
                header: Labels.KIT_CUSTOMIZATION_HEADER,
                footerType: XvSetConstants.FOOTER_TYPE_NONE,
                footerText: nil,
                footerLink: nil,
                footerHeight: 10,
                cells: kitDisclosureCellDataArray,
                isVisible: true
            )
            
            sections.append(customizeSection)
            
        
        } else {
            print("SETTINGS: Error getting kits during XvSetMainTableData init")
        }
        
        
        //MARK: Musical scale
        
        if let musicalScaleData:MusicalScaleData = MusicalScaleData() {
            
            let musicalScale:DisclosureCellData = DisclosureCellData(
                withCheckmarkTableDataSource: musicalScaleData,
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
            
        } else {
            
            print("SETTINGS: Error get musical scale data from core data in main table data")
        }
        
    
        /*
        if let tempoInt:Int = xvcdm.getAppInteger(forKey: XvSetConstants.kAppTempo) {
            
            let tempo:SliderCellData = SliderCellData(
                key: XvSetConstants.kAppTempo,
                value: tempoInt,
                valueMin: 40,
                valueMax: 200,
                textLabel: Labels.TEMPO_LABEL,
                dataType: XvSetConstants.DATA_TYPE_INTEGER,
                levelType: XvSetConstants.LEVEL_TYPE_APP,
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
        */
        
        //MARK: Sync
        
        //link bool is set by ABLink framework, not user pref
        
        //what do we need when a disclosure cell shows a non checkmark table?
        //key (for id purposes in table class)
        //label for visual name
        
        
        let abletonLink:DisclosureCellData = DisclosureCellData(
            key: XvSetConstants.kAppAbletonLinkEnabled,
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
        
        
        //MARK: MIDI
       
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
        
        
        //MARK: Artificial Intelligence
        
        let artificialIntelligence:ButtonCellData = ButtonCellData(
            key: XvSetConstants.kKitArtificialIntelligence,
            textLabel: "Reset AI Memory",
            levelType: XvSetConstants.LEVEL_TYPE_KIT,
            isVisible: true
        )
        
        let artificialIntelligenceSection:SectionData = SectionData(
            header: "Artificial Intelligence",
            footerType: XvSetConstants.FOOTER_TYPE_NORMAL,
            footerText: ["This clears the AI memory and resets it to the factory state."],
            footerLink: nil,
            footerHeight: 80,
            cells: [artificialIntelligence],
            isVisible: true
        )
        
        sections.append(artificialIntelligenceSection)
        
        
        //MARK: BG Mode
        
        if let bgModeBool:Bool = xvcdm.getAppBool(forKey: XvSetConstants.kAppBackgroundModeEnabled) {
            
            let bgMode:ToggleCellData = ToggleCellData(
                key: XvSetConstants.kAppBackgroundModeEnabled,
                value: bgModeBool,
                textLabel: "Background Mode",
                levelType: XvSetConstants.LEVEL_TYPE_APP,
                isVisible: true
            )
            
            let modesSection:SectionData = SectionData(
                header: "Background Mode",
                footerType: XvSetConstants.FOOTER_TYPE_NORMAL,
                footerText: ["Activate this to keep the app running in the background."],
                footerLink: nil,
                footerHeight: 80,
                cells: [bgMode],
                isVisible: true
            )
            
            sections.append(modesSection)
            
        } else {
            print("SETTINGS: Error: Unable to get bg mode bool in main table")
        }
        
        //MARK: Rearrange
        
        /*
        let rearrangeButton:ButtonCellData = ButtonCellData(
            key: XvSetConstants.kAppRearrange,
            textLabel: "Rearrange",
            levelType: XvSetConstants.LEVEL_TYPE_APP,
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
        
    }
    
}
