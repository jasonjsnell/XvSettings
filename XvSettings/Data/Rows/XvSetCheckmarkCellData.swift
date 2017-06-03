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
        key:String,         // the key of the default. In disclosures, this is the key of the parent, disclosure cell
        value:Any,          // the value that gets assign to the key, like the string "kitLake" to the default kSelectedKit
        selected:Bool,      // is the checkmark on or off
        multi:Bool,         // does selecting this checkmark unselect others of the same key?
        label:String,       // the visual text in the cell
        dataType:String,    // string / bool, etc...
        displayType:String) // type = checkmark
    {
        
        //the key in this class is the parent key, the key that these values assign to
        super.init(
            key: key,
            label: label,
            dataType: dataType,
            displayType: displayType,
            defaultValue: nil
        )
        
        self.value = value
        self.selected = selected
        self.multi = multi
        
    }
    
}
