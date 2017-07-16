//
//  XvSetCheckmarkTableData.swift
//  XvSettings
//
//  Created by Jason Snell on 6/4/17.
//  Copyright © 2017 Jason J. Snell. All rights reserved.
//

import Foundation

public class CheckmarkTableData:TableData {
    
    //key of the default this table is updating
    //accessed during table view will appear to check for midi dest / source tables
    internal var key:String
    
    //Does checkmark selection update a String, Int, etc...?
    fileprivate var dataType:String
    
    //all the values and the currently selected value in the table
    internal var defaultValue:Any // current value
    internal var possibleValues:[Any] // all the possible values
    
    //labels
    fileprivate var textLabel:String //left-side text label
    fileprivate var detailTextLabel:String // curr right-side text label
    internal var detailTextLabels:[String] //all the possible right-side text labels / name of checkmark cells in table
    
    //level type: app, kit, or instrument
    fileprivate var levelType:String
    
    //visibility
    fileprivate var isVisible:Bool
    
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
        self.levelType = levelType
        self.isVisible = isVisible
        self.cellDataArray = []
        
        super.init()
        
        initCellDataArray()
    }
    
    //called locally and from midi instance tables during reloads with updated midi info
    public func initCellDataArray(){
        
        print("initCellDataArray")
        
        //clear out array 
        cellDataArray = []
        
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
