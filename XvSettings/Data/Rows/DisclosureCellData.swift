//
//  DefaultBoolData.swift
//  RF Settings
//
//  Created by Jason Snell on 10/23/16.
//  Copyright © 2016 Jason J. Snell. All rights reserved.
//

import Foundation

class DisclosureCellData:CellData {
   
    //MARK: - VARIABLES
    
    //text on the right side of the cell, which indicates which variable is selected inside the sub-table
    internal var detailTextLabel:String
    internal var detailTextLabels:[String]
    
    //data for the sub table that gets launched
    internal var checkmarkTableDataSource:CheckmarkTableData?
    
    //MARK: - INIT
    
    init(key:String, value:Any, textLabel:String){
        
        detailTextLabel = ""
        detailTextLabels = []
        
        super.init(
            key: key,
            value: value,
            textLabel: textLabel,
            displayType: XvSetConstants.DISPLAY_TYPE_DISCLOSURE,
            levelType: XvSetConstants.LEVEL_TYPE_NONE //disclosure leads to more panels, does not change vars
        )
        
    }
    
    //init by data class, for simpler disclosure cells that launch non-checkmark tables
    convenience init (key:String, textLabel:String){
        
        self.init(
            key: key,
            value: "",
            textLabel: textLabel
        )
    }
    
    
    // init with data class, unpack it to get the vars
    // called by table that wants to create a checkmark table launched from a disclosure cell tap
    convenience init(withCheckmarkTableDataSource: CheckmarkTableData){
        
        //init with data from table data source
        self.init(
            key: withCheckmarkTableDataSource.getKey(),
            value: withCheckmarkTableDataSource.getValue(),
            textLabel: withCheckmarkTableDataSource.getTextLabel()
        )
        
        //retain table data so checkmark table can be launched with this data object (via its cell)
        self.checkmarkTableDataSource = withCheckmarkTableDataSource
        
        //grab other data from table data source
        self.detailTextLabel = withCheckmarkTableDataSource.getDetailTextLabel()
        self.detailTextLabels = withCheckmarkTableDataSource.getDetailTextLabels()
        
    }
    
    // called when checkmark cell is tapped inside a disclosure table
    public func updateDetailTextLabel(withRow:Int){
        detailTextLabel = detailTextLabels[withRow]
    }

    
}
