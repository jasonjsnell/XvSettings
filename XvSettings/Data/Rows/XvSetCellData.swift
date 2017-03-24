//
//  DefaultBoolData.swift
//  RF Settings
//
//  Created by Jason Snell on 10/23/16.
//  Copyright © 2016 Jason J. Snell. All rights reserved.
//

import Foundation

public class XvSetCellData {
    
    //MARK:-
    //MARK:VARIABLES
    
   
    //basics
    internal var key:String = ""
    internal var label:String = ""
    internal var dataType:String = ""
    internal var displayType:String = ""
    
    //position
    internal var indexPath:IndexPath?
    
    //defaults
    internal var defaultValue:Any?
    
    internal let debug:Bool = false
    
    //MARK:-
    //MARK:INIT
    public init(
        key:String,
        label:String,
        dataType:String,
        displayType:String,
        defaultValue:Any?){
        
        //record incoming vars
        self.key = key
        self.label = label
        self.dataType = dataType
        self.displayType = displayType
        self.defaultValue = defaultValue

    }
            
}
