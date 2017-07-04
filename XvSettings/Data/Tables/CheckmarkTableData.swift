//
//  XvSetCheckmarkTableData.swift
//  XvSettings
//
//  Created by Jason Snell on 6/4/17.
//  Copyright © 2017 Jason J. Snell. All rights reserved.
//

import Foundation

class CheckmarkTableData:TableData {
    
    //key of the default this table is updating
    fileprivate var key:String
    
    //Does checkmark selection update a String, Int, etc...?
    fileprivate var dataType:String
    
    //all the values and the currently selected value in the table
    fileprivate var defaultValue:Any // current value
    fileprivate var possibleValues:[Any] // all the possible values
    
    //labels
    fileprivate var textLabel:String //left-side text label
    fileprivate var detailTextLabel:String // curr right-side text label
    fileprivate var detailTextLabels:[String] //all the possible right-side text labels / name of checkmark cells in table
    
    fileprivate var cellDataArray:[CheckmarkCellData]
    
    
    //MARK: INIT
    public init(
        key:String,
        dataType:String,
        defaultValue:Any,
        possibleValues:[Any],
        textLabel:String,
        detailTextLabels:[String],
        levelType:String,
        isVisible:Bool
        ){
    
        self.key = key
        self.dataType = dataType
        self.defaultValue = defaultValue
        self.possibleValues = possibleValues
        self.textLabel = textLabel
        self.detailTextLabel = ""
        self.detailTextLabels = detailTextLabels
        self.cellDataArray = []
        
        var multi:Bool = false
        var defaultValues:[Any] = []
        
        //test to see if the default value is an array of values
        if let defaultValueAsArray:[Any] = defaultValue as? [Any] {
            
            //if so, turn on multi
            multi = true
            defaultValues = defaultValueAsArray
        }
        
        //calculate detail text label during load
        for i in 0..<possibleValues.count {
            
            var isSelected:Bool = false
            
            if (multi){
                
                //multiple default values
                for df in defaultValues {
                    if (String(describing: possibleValues[i]) == String(describing: df)){
                        isSelected = true
                    }
                }
                
            } else {
                
                //single default value, which includes a detail text label
                if (String(describing: possibleValues[i]) == String(describing: defaultValue)){
                    isSelected = true
                    
                    if (!multi){
                        detailTextLabel = detailTextLabels[i]
                    }
                }
            }
            
            let cellData:CheckmarkCellData  = CheckmarkCellData(
                key: key,
                value: possibleValues[i],
                textLabel: detailTextLabels[i],
                selected: isSelected,
                multi: multi,
                levelType: levelType,
                isVisible: isVisible
            )
            
            cellDataArray.append(cellData)
            
        }
    }

    //MARK: - ACCESSORS
    public func getKey() -> String {
        return key
    }
    
    public func getDefaultValue() -> Any {
        return defaultValue
    }
    
    public func getTextLabel() -> String {
        return textLabel
    }
    
    public func getDetailTextLabel() -> String {
        return detailTextLabel
    }
    
    public func getDetailTextLabels() -> [String] {
        return detailTextLabels
    }
    
    public func getCellDataArray() -> [CheckmarkCellData] {
        return cellDataArray
    }
    
    
}
