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
    
    override public func viewWillAppear(_ animated: Bool) {
        
        //this fires when main settings panel loads, and it returned to from a sub menu
        //if Ableton Link is on, keep midi sync on None, even if user selected something else
        
        if (xvcdm.getAppBool(forKey: XvSetConstants.kAppAbletonLinkEnabled)){
            
            if let _midiSyncCell:DisclosureCell = _getMidiSyncCell() {
                _midiSyncCell.set(label: XvSetConstants.MIDI_CLOCK_NONE_LABEL)
            }
        }
        
        super.viewWillAppear(animated)
        
    }
    
    //override by app settings classes, which check for app specific keys and execute app specific commands
    override func disclosureRowSelected(cell:DisclosureCell, key:String){
        
        if (key == XvSetConstants.kAppMidiSync){
            
            //MARK: MIDI sync
            
            if (xvcdm.getAppBool(forKey: XvSetConstants.kAppAbletonLinkEnabled)){
                
                _showMidiSyncAblError()
                
            } else {
                
                loadCheckmarkTable(fromCell:cell)
                
            }
            
        } else if (key == XvSetConstants.kAppAbletonLinkEnabled){
                
            //MARK: ABL Link
            //launch controller from helper since it needs to grab the VC from the ABL framework
            Utils.postNotification(
                name: XvSetConstants.kAppAbletonLinkViewControllerRequested,
                userInfo: ["parentVC" : self])
            
        } else if (key == XvSetConstants.kMusicalScale){
            
            //TODO: move framework
            //MARK: Musical scale
            
            loadCheckmarkTable(fromCell:cell)
            
        } else if (key.lowercased().range(of:"kit") != nil) {
            
            //MARK: Instrument kit
            
            if let kitDataObj:NSManagedObject = xvcdm.getKit(withID: key) {
                
                loadKitTable(fromDataObj: kitDataObj)
                
            } else {
                print("SETTINGS: Core data for", key, "not found during disclosureRowSelected")
            }
        }
        
    }

    
    //MARK: Private
    
    fileprivate func _getMidiSyncCell() -> DisclosureCell? {
        
        if (midiSyncCell == nil){
            midiSyncCell = getCell(fromKey: XvSetConstants.kAppMidiSync) as? DisclosureCell
            
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
