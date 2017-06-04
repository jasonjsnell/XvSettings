//
//  DefaultBoolData.swift
//  RF Settings
//
//  Created by Jason Snell on 10/23/16.
//  Copyright © 2016 Jason J. Snell. All rights reserved.
//

import Foundation

public class XvSetDisclosureCellData:XvSetCellData {
    
    //MARK:-
    //MARK:VARIABLES

    //defaults
    internal var defaultLabel:String = ""
    
    //MARK:- INIT
    
    
    override public init(
        key:String,
        label:String,
        dataType:String,
        displayType:String,
        defaultValue:Any?){
        
        super.init(
            key: key,
            label: label,
            dataType: dataType,
            displayType: displayType,
            defaultValue: defaultValue
        )
        
    }
    
    
}
