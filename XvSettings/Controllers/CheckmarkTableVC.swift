//
//  XvSetCheckmarkTable.swift
//  XvSettings
//
//  Created by Jason Snell on 6/5/17.
//  Copyright © 2017 Jason J. Snell. All rights reserved.
//

import UIKit

//check mark tables are launched with a parent disclosure cell, rather than a data class. The data for the class is inside the incoming cell

public class CheckmarkTableVC: TableVC {

    //parent cell that launched this table
    var parentDisclosureCell:DisclosureCell?
    
    internal func load(withParentDisclosureCell:DisclosureCell){
        
        //retain parent cell for detailTextLabel updates during checkmark selections in the sub table
        self.parentDisclosureCell = withParentDisclosureCell
        
        //load the super class with the data stored in the disclosure cell
        
        //if parent cell data is valid...
        if let parentDisclosureCellData:DisclosureCellData = withParentDisclosureCell.data as? DisclosureCellData {
            
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
    
    //when the local checkmark func is executed, update the parent cells detailTextLabel on non-multi tables
    override internal func _checkmarkRowSelected(cell: CheckmarkCell, indexPath:IndexPath) {
        
        super._checkmarkRowSelected(cell: cell, indexPath: indexPath)
        
        if let cellData:CheckmarkCellData = cell.data as? CheckmarkCellData {
            
            if (!cellData.multi) {
                
                //if there is a parent cell...
                if (parentDisclosureCell != nil){
                    
                    //if parent cell data is valid...
                    if let parentDisclosureCellData:DisclosureCellData = parentDisclosureCell!.data as? DisclosureCellData {
                        
                        //update detail text label
                        parentDisclosureCellData.updateDetailTextLabel(withRow: indexPath.row)
                        
                        //update view
                        parentDisclosureCell!.set(label: parentDisclosureCellData.detailTextLabel)
                        
                    } else {
                        print("SETTINGS: Error: Parent cell data is invalid during _checkmarkRowSelected")
                    }
                }
            }
            
            
        } else {
            print("SETTINGS: Error: Unable to get checkmark cell data during _checkmarkRowSelected")
        }
    }
}
