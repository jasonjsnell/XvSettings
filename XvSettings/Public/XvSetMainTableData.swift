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
        
        //TODO: when kits are taken from getKits, they may be randomly ordered, each time. Go into get kits and have them order alphabetically or something
        
        if let kits:[NSManagedObject] = xvcdm.getKits() {
            
            for kit in kits {
                
                if let id:String = xvcdm.getString(forKey: XvSetConstants.kKitID, forObject: kit),
                    let name:String = xvcdm.getString(forKey: XvSetConstants.kKitName, forObject: kit) {
                    
                    var isSelected:Bool = false
                    
                    
                    if (xvcdm.getAppString(forKey: XvSetConstants.kSelectedKit) == id){
                        isSelected = true
                    }
                    
                    let instrumentKitCheckmarkCellData:CheckmarkCellData = CheckmarkCellData(
                        key: XvSetConstants.kSelectedKit,
                        value: id,
                        textLabel: name,
                        dataType: XvSetConstants.DATA_TYPE_STRING,
                        selected: isSelected,
                        multi: false,
                        levelType: XvSetConstants.LEVEL_TYPE_APP,
                        isVisible: true
                    )
                    
                    kitCheckmarkCellDataArray.append(instrumentKitCheckmarkCellData)
                    
                    let instrumentKitDisclosureCellData:DisclosureCellData = DisclosureCellData(
                        key: id,
                        textLabel: name,
                        isVisible: true
                    )
                    
                    kitDisclosureCellDataArray.append(instrumentKitDisclosureCellData)
                    
                } else {
                    print("SETTINGS: Error getting kit id and name during main table init")
                }
            }
            
            let instrumentKitSelection:SectionData = SectionData(
                header: "Selected Kit",
                footerType: XvSetConstants.FOOTER_TYPE_NONE,
                footerText: nil,
                footerLink: nil,
                footerHeight: 10,
                cells: kitCheckmarkCellDataArray,
                isVisible: true
            )
            
            sections.append(instrumentKitSelection)
            
            //MARK: Customize
            
            let customizeSection:SectionData = SectionData(
                header: "Kit Customization",
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
        
        
        
        //TODO: delete?
        //MARK: MIDI Destinations
        /*
         let midiInitialVisibility:Bool = dm.getBool(forKey: XvMidiConstants.kMidiSendEnabled)
         
         let midiDestinations:DisclosureMultiCellData = DisclosureMultiCellData(
         key: XvMidiConstants.kMidiDestinations,
         label: "MIDI Destinations",
         dataType: XvSetConstants.TYPE_ARRAY,
         displayType: XvSetConstants.DISPLAY_TYPE_DISCLOSURE_MULTI,
         defaultValue: dm.getArray(forKey: XvMidiConstants.kMidiDestinations)
         )
         
         //sub array for midi destinations gets init when the table is about to load in SetMain so it's the most current data
         
         let midiDestinationsSection:SectionData = SectionData(
         header: "MIDI Destinations",
         footerType: XvSetConstants.FOOTER_TYPE_NONE,
         footerText: nil,
         footerLink: nil,
         footerHeight: 10,
         cells: [midiDestinations],
         isVisible: midiInitialVisibility
         )
         
         sections.append(midiDestinationsSection)
         */
        
        /*
         //MARK: Instrument Outs
         
         //run loops to create the 16 MIDI channel options for each of the 7 instruments
         
         //loop through and populate MIDI channels and labels
         var midiOutChannels:[Int] = []
         var midiOutLabels:[String] = []
         
         for i in 0...15 {
         midiOutChannels.append(i)
         midiOutLabels.append("MIDI Channel " + String(i + 1))
         }
         
         //loop through and create 7 midi outs, one for each instrument
         
         var instrumentOuts:[DisclosureCellData] = []
         
         for i in 0..<XvMidiConstants.kMidiOuts.count {
         
         let midiOut:DisclosureCellData = DisclosureCellData(
         
         key: XvMidiConstants.kMidiOuts[i],
         label: "Instrument " + String(i + 1),
         dataType: XvSetConstants.TYPE_INTEGER,
         displayType: XvSetConstants.DISPLAY_TYPE_DISCLOSURE,
         defaultValue: dm.getInteger(forKey: XvMidiConstants.kMidiOuts[i])
         )
         
         midiOut.initSubArrays(values: midiOutChannels, labels: midiOutLabels)
         
         //add to instrument outs array
         instrumentOuts.append(midiOut)
         }
         
         let instrumentOutsSection:SectionData = SectionData(
         header: "Instrument Routing",
         footerType: XvSetConstants.FOOTER_TYPE_NONE,
         footerText: nil,
         footerLink: nil,
         footerHeight: 10,
         cells: instrumentOuts,
         isVisible: midiInitialVisibility
         )
         
         sections.append(instrumentOutsSection)
         */
        
        
        
        
        
        //MARK: Musical scale
        
        if let musicalScaleData:MusicalScaleData = MusicalScaleData() {
            
            let musicalScale:DisclosureCellData = DisclosureCellData(
                withCheckmarkTableDataSource: musicalScaleData,
                isVisible: true
            )
            
            let musicalScaleSection:SectionData = SectionData(
                header: XvSetConstants.MUSIC_SCALE_LABEL,
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
        
        
        
        
        //MARK: Modes
        
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
                footerType: XvSetConstants.FOOTER_TYPE_LINK,
                footerText: ["Background mode keeps the app running in the background. MIDI Mode mutes app audio and activates MIDI Out. For help, see the ", "user's manual", "."],
                footerLink: "http://app.jasonjsnell.com/refraktions/manual/",
                footerHeight: 70,
                cells: [bgMode],
                isVisible: true
            )
            
            sections.append(modesSection)
            
        } else {
            print("SETTINGS: Error: Unable to get bg mode bool in main table")
        }
    
    }
    
}
