//
//  XvSetCheckmarkTable.swift
//  XvSettings
//
//  Created by Jason Snell on 6/5/17.
//  Copyright © 2017 Jason J. Snell. All rights reserved.
//

import UIKit

//check mark tables are launched with a parent disclosure cell, rather than a data class. The data for the class is inside the incoming cell

open class XvSetCheckmarkTable: XvSetTable {

    //parent cell that launched this table
    public var parentDisclosureCell:XvSetDisclosureCell?
    
    open func load(withParentDisclosureCell:XvSetDisclosureCell){
        
        //retain parent cell for detailTextLabel updates during checkmark selections in the sub table
        self.parentDisclosureCell = withParentDisclosureCell
        
        //load the super class with the data stored in the disclosure cell
        
        //if parent cell data is valid...
        if let parentDisclosureCellData:XvSetDisclosureCellData = withParentDisclosureCell.data as? XvSetDisclosureCellData {
            
            //if table data is valid...
            if let checkmarkTableDataSource = parentDisclosureCellData.checkmarkTableDataSource {
                
                //load super class
                self.load(withDataSource: checkmarkTableDataSource)
                
            } else {
                print("SETTINGS: Checkmark table data source invalid during load")
            }
            
        } else {
            print("SETTINGS: Parent disclosure cell's data is invalid during load")
        }
    }
    
    //when the local checkmark func is executed, update the parent cells detailTextLabel
    override internal func _checkmarkRowSelected(cell: XvSetCheckmarkCell, indexPath:IndexPath) {
        
        super._checkmarkRowSelected(cell: cell, indexPath: indexPath)
        
        //if there is a parent cell...
        if (parentDisclosureCell != nil){
            
            //if parent cell data is valid...
            if let parentDisclosureCellData:XvSetDisclosureCellData = parentDisclosureCell!.data as? XvSetDisclosureCellData {
                
                //update detail text label
                parentDisclosureCellData.updateDetailTextLabel(withRow: indexPath.row)
                
                //update view
                parentDisclosureCell!.set(label: parentDisclosureCellData.detailTextLabel)
                
            } else {
                print("SETTINGS: Parent cell data is invalid during _checkmarkRowSelected")
            }
        }
    }
}
