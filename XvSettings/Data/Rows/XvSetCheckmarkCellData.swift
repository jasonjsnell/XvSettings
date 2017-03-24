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
    
    //MARK:-
    //MARK:INIT
    public init(
        key:String,
        value:Any,
        selected:Bool,
        label:String,
        dataType:String,
        displayType:String){
        
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
        
    }
    

    
}
