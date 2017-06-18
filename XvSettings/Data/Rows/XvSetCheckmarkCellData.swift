//
//  DefaultBoolData.swift
//  RF Settings
//
//  Created by Jason Snell on 10/23/16.
//  Copyright © 2016 Jason J. Snell. All rights reserved.
//
//object that appears in sub array of a data object. This contains values instead of keys and is used to populate checkmark cells

import Foundation

public class XvSetCheckmarkCellData:XvSetCellData {
    
    //MARK:- VARIABLES
    
    // is the checkmark on or off
    internal var selected:Bool = false
    
    // does selecting this checkmark unselect others of the same key?
    internal var multi:Bool = true
    
    
    //MARK:- INIT
    public init(
        key:String,
        value:Any,
        textLabel:String,
        dataType:String,
        selected:Bool,
        multi:Bool,
        levelType:String
    ){
        
        super.init(
            key: key,
            value: value,
            textLabel: textLabel,
            displayType: XvSetConstants.DISPLAY_TYPE_CHECKMARK,
            levelType: levelType
        )
        
        self.selected = selected
        self.multi = multi
        
    }
    
    
}
