//
//  DefaultBoolData.swift
//  RF Settings
//
//  Created by Jason Snell on 10/23/16.
//  Copyright © 2016 Jason J. Snell. All rights reserved.
//

import Foundation

public class XvSetDisclosureMultiCellData:XvSetDisclosureCellData {
    
    //MARK:-
    //MARK:VARIABLES
    
    //defaults
    internal var defaultPositions:[Int] = []
    
    override public func initSubArrays(values:[Any], labels:[String]){
        
        //record arrays
        self.subValues = values
        self.subLabels = labels
        
    }
    
    public func setNewDefaults(newIndexes:[Int]){
        
        //update local variables
        defaultPositions = newIndexes
        
        //reset
        defaultValue = []
        
        //init temp array
        var _subValues:[Any] = []
        
        //loop through each int in default positions
        for _defaultPosition in defaultPositions {
            
            //get value from that position
            let _subValue:Any = subValues[_defaultPosition]
            
            //record value into array
            _subValues.append(_subValue)
            
        }
        
        //record array back into default value var
        defaultValue = _subValues
        
        Utils.postNotification(
            name: XvSetConstants.kSettingsPanelDefaultChanged,
            userInfo: ["key" : key, "value" : defaultValue as Any])
        
       
        if (debug){
            print("SETCELLDATA: New defaults for", key,"are", defaultPositions)
        }
    }
    
    //called by SetMultiCheckmarkTable VC when row is tapped
    internal func addDefault(position:Int){
        
        //if position is not in array, then add it
        if !defaultPositions.contains(position) {
            defaultPositions.append(position)
        }
        
        //update local defaults, values, and user defaults
        setNewDefaults(newIndexes: defaultPositions)
        
        if (debug){
            print("SETCELLDATA: defaults for", key,"are", defaultPositions)
        }
        
    }
    
    internal func removeDefault(position:Int){
        
        //if position is in array, then remove it
        if let index:Int = defaultPositions.index(of:position) {
            defaultPositions.remove(at: index)
        }
        
        //update local defaults, values, and user defaults
        setNewDefaults(newIndexes: defaultPositions)
        
        if (debug){
            print("SETCELLDATA: defaults for", key,"are", defaultPositions)
        }
        
    }
    
}
