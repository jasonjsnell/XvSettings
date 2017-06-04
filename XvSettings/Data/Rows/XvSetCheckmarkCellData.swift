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
    
    //MARK:-
    //MARK:VARIABLES
    
    internal var value:Any = ""
    internal var selected:Bool = false
    internal var multi:Bool = true
    
    //MARK:-
    //MARK:INIT
    public init(
        
        // the key of the default. In disclosures, this is the key of the parent, disclosure cell
        key:String,
        
        // the value that gets assigned to the key, like the string "kitLake" to the default kSelectedKit
        value:Any,
        
        // the visual text in the cell
        label:String,
        
        // String, Int, etc...
        dataType:String,
        
        // is the checkmark on or off
        selected:Bool,
        
        // does selecting this checkmark unselect others of the same key?
        multi:Bool
    ){
        
        super.init(
            key: key,
            label: label,
            dataType: dataType,
            displayType: XvSetConstants.DISPLAY_TYPE_CHECKMARK,
            defaultValue: nil
        )
        
        self.value = value
        self.selected = selected
        self.multi = multi
        
    }
    
}
