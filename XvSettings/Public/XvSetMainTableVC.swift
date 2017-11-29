//
//  XvSetMainTable.swift
//  XvSettings
//
//  Created by Jason Snell on 6/18/17.
//  Copyright © 2017 Jason J. Snell. All rights reserved.
//

//this is the main settings table, launched from the root view controller

import UIKit
import CoreData

public class XvSetMainTableVC:TableVC {
    
    //ref to midisync cell because it is automatically changed when ABL Link is enabled
    fileprivate var midiSyncCell:DisclosureCell?
    
    //MARK: - BUILD
    override public func viewWillAppear(_ animated: Bool) {
        
        //this fires when main settings panel loads, and it returned to from a sub menu
        //if Ableton Link is on, keep midi sync on None, even if user selected something else
        
        
        
        if let linkEnabled:Bool = xvcdm.getBool(
            forKey: XvSetConstants.kConfigAbletonLinkEnabled,
            forObject: xvcdm.currConfigFile!) {
            
            if (linkEnabled){
                
                if let _midiSyncCell:DisclosureCell = _getMidiSyncCell() {
                    _midiSyncCell.set(label: Labels.MIDI_CLOCK_NONE_LABEL)
                }
            }
            
        } else {
            print("SETTINGS: Error: Unable to get ABL Link enabled bool from Core Data")
        }
        
        
        
        super.viewWillAppear(animated)
        
    }
    
    //MARK: - USER INPUT

    override func disclosureRowSelected(cell:DisclosureCell, key:String){
        
        if (key.range(of:XvSetConstants.kTrackEntity) != nil) {
            
            //MARK: Track & Sample
            let positionString:Substring = key.suffix(1)
            if let position:Int = Int(positionString){
                
                loadTrackTable(position: position)
               
            } else {
                
                print("SETTINGS: Error getting trackPosition during disclosureRowSelected")
            }
           
        } else if (key == XvSetConstants.kConfigMidiSync){
            
            //MARK: MIDI sync
            if let linkEnabled:Bool = xvcdm.getBool(
                forKey: XvSetConstants.kConfigAbletonLinkEnabled,
                forObject: xvcdm.currConfigFile!) {
                
                if (!linkEnabled){
                    
                    loadCheckmarkTable(fromCell:cell)
                    
                } else {
                    
                    _showMidiSyncAblError()
                }
            }
            
        } else if (key == XvSetConstants.kConfigAbletonLinkEnabled){
                
            //MARK: ABL Link
            //launch controller from helper since it needs to grab the VC from the ABL framework
            
            Utils.postNotification(
                name: XvSetConstants.kConfigAbletonLinkViewControllerRequested,
                userInfo: ["parentVC" : self])
            
            
        } else if (key == XvSetConstants.kConfigGlobalMidiDestinations ||
            key == XvSetConstants.kConfigGlobalMidiSources){
            
            //MARK: Global MIDI
            
            if (!xvcdm.audioBusMidiBypass){
                
                loadCheckmarkTable(fromCell:cell)
                
            } else {
                
                _showAudiobusMidiBypassError()
            }
            
        } else if (key == XvSetConstants.kConfigMusicalScale) {
            
            //MARK: Musical scale
            loadMusicalScaleTable()
            
        } else {
            print("SETTINGS: Core data for", key, "not found during disclosureRowSelected")
        }
        
    }

    //MARK: Private
    
    fileprivate func _getMidiSyncCell() -> DisclosureCell? {
        
        if (midiSyncCell == nil){
            midiSyncCell = getCell(fromKey: XvSetConstants.kConfigMidiSync) as? DisclosureCell
            
        }
        
        return midiSyncCell
    }
    
    fileprivate func _showMidiSyncAblError(){
        
        let alert = UIAlertController(
            title: "Alert",
            message: "MIDI Sync cannot be used while Ableton Link is enabled.",
            preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }

    
}
