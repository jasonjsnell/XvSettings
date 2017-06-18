//
//  XvSetCheckmarkTableData.swift
//  XvSettings
//
//  Created by Jason Snell on 6/4/17.
//  Copyright © 2017 Jason J. Snell. All rights reserved.
//

import Foundation

open class XvSetCheckmarkTableData:XvSetTableData {
    
    //key of the default this table is updating
    fileprivate var key:String
    
    //Does checkmark selection update a String, Int, etc...?
    fileprivate var dataType:String
    
    //all the values and the currently selected value in the table
    fileprivate var value:Any // current value
    fileprivate var values:[Any] // all the possible values
    
    //labels
    fileprivate var textLabel:String //left-side text label
    fileprivate var detailTextLabel:String // curr right-side text label
    fileprivate var detailTextLabels:[String] //all the possible right-side text labels / name of checkmark cells in table
    
    //can multiple checkmarks be selected?
    fileprivate var multi:Bool
    
    fileprivate var cellDataArray:[XvSetCheckmarkCellData]
    
    
    //MARK: INIT
    public init(
        key:String,
        dataType:String,
        value:Any,
        values:[Any],
        textLabel:String,
        detailTextLabels:[String],
        multi:Bool,
        levelType:String
        ){
    
        self.key = key
        self.dataType = dataType
        self.value = value
        self.values = values
        self.textLabel = textLabel
        self.detailTextLabel = ""
        self.detailTextLabels = detailTextLabels
        self.multi = multi
        self.cellDataArray = []
        
        //calculate detail text label during load
        for i in 0..<values.count {
            
            var isSelected:Bool = false
            
            if (String(describing: values[i]) == String(describing: value)){
                isSelected = true
                detailTextLabel = detailTextLabels[i]
            }
            
            let cellData:XvSetCheckmarkCellData  = XvSetCheckmarkCellData(
                key: key,
                value: values[i],
                textLabel: detailTextLabels[i],
                dataType: dataType,
                selected: isSelected,
                multi: multi,
                levelType: levelType
            )
            
            cellDataArray.append(cellData)
            
        }
    }
    
    //MARK: - ACCESSORS
    public func getKey() -> String {
        return key
    }
    
    public func getValue() -> Any {
        return value
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
    
    public func getCellDataArray() -> [XvSetCheckmarkCellData] {
        return cellDataArray
    }
    
    
}
