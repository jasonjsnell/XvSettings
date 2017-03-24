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

    //multi values
    internal var subValues:[Any] = []
    internal var subLabels:[String] = []
    
    //defaults
    internal var defaultLabel:String = ""
    internal var defaultPosition:Int = 0
    
    //MARK:-
    //MARK:INIT
    
    
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
    
    public func initSubArrays(values:[Any], labels:[String]){
        
        //record arrays
        self.subValues = values
        self.subLabels = labels
        
        if (defaultValue != nil){
            //find the default position in the arrays but comparing it to default object set in init func
            for i in 0..<subValues.count {
                
                let value:Any = subValues[i]
                
                //convert values to strings and compare them
                if (String(describing: value) == String(describing: defaultValue!)){
                    
                    //record the default position (this will be the selected cell in a view)
                    defaultPosition = i
                    defaultLabel = self.subLabels[i]
                    
                    if (debug){
                        print("SETCELLDATA: Position is", defaultPosition, "label is", defaultLabel)
                    }
                }
                
            }

        } else {
            print("SETCELLDATA: defaultValue is nil during initSubArrays")
        }
        
    }
    
    public func setNewDefault(newIndex:Int){
        
        //update local variables
        defaultPosition = newIndex
        defaultLabel = subLabels[newIndex]
        defaultValue = subValues[newIndex]
        
        Utils.postNotification(
            name: XvSetConstants.kSettingsPanelDefaultChanged,
            userInfo: ["key" : key, "value" : defaultValue as Any])
    
    }
    
}
