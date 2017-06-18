//
//  DefaultBoolData.swift
//  RF Settings
//
//  Created by Jason Snell on 10/23/16.
//  Copyright © 2016 Jason J. Snell. All rights reserved.
//

import Foundation

public class CellData {
    
    //MARK:-
    //MARK:VARIABLES
    
   
    // the key of the default. In disclosures, this is the key of the parent disclosure cell.
    // Example: kMidiSync
    internal var key:String
    
    // value of the default. 
    // Example midi_clock_receive
    internal var value:Any
    
    // the text on the left side the cell
    internal var textLabel:String
    
    //checkmark, toggle, disclosure, button
    internal var displayType:String
    
    //level type, does the cell change a var on the app, kit, or instrument level
    internal var levelType:String
    

    //position
    internal var indexPath:IndexPath?
    
    internal var visibilityTargets:[Int]?
    
    internal let debug:Bool = false
    
    //MARK:-
    //MARK:INIT
    
    
    public init(
        key:String,
        value:Any,
        textLabel:String,
        displayType:String,
        levelType:String){
        
        //record incoming vars
        self.key = key
        self.value = value
        self.textLabel = textLabel
        self.displayType = displayType
        self.levelType = levelType

    }
    
    
    //visibility targets are rare, so it has its own setter
    public func set(visibilityTargets:[Int]){
        self.visibilityTargets = visibilityTargets
    }
            
}
