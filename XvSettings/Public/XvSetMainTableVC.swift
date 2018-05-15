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
        
        if (dataSource != nil){
            
            //main table fires a refresh so the labels are up to date with the data
            dataSource!.refresh()
            
            //this fires when main settings panel loads, and is returned to from a sub menu
            //if Ableton Link is on, keep midi sync on None, even if user selected something else
            
            if let currConfigFile:NSManagedObject = xvcdm.currConfigFile,
                let linkEnabled:Bool = xvcdm.getBool(
                    forKey: XvSetConstants.kConfigAbletonLinkEnabled, forObject: currConfigFile) {
                
                if (linkEnabled){
                    
                    if let _midiSyncCell:DisclosureCell = _getMidiSyncCell() {
                        _midiSyncCell.set(label: Labels.MIDI_CLOCK_NONE_LABEL)
                    }
                }
                
            } else {
                print("SETTINGS: Error getting ABL Link vars from Core Data during viewWillAppear in XvSetMainTableVC")
            }
            
        } else {
            
            print("SETTINGS: Error: XvSetMainTableVC has no data source during viewWillAppear")
        }
        
        super.viewWillAppear(animated)
        
    }

    //MARK: Private
    
    fileprivate func _getMidiSyncCell() -> DisclosureCell? {
        
        if (midiSyncCell == nil){
            midiSyncCell = getCell(fromKey: XvSetConstants.kConfigMidiSync) as? DisclosureCell
            
        }
        
        return midiSyncCell
    }
    
    
    
}
