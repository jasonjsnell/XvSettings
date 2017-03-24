//
//  SettingsTableViewController.swift
//  RF Settings
//
//  Created by Jason Snell on 8/30/16.
//  Copyright © 2016 Jason J. Snell. All rights reserved.
//

// a table of checkmark cells, only 1 can be selected

import UIKit

public class XvSetCheckmarkTable: XvSetTable {
    
    //MARK:VARIABLES
    
    //table key
    internal var parentCell:XvSetDisclosureCell?
    internal var parentCellKey:String = ""
    internal var parentCellData:XvSetDisclosureCellData?
    
    
    internal let CELL_BACKGROUND_COLOR:UIColor = UIColor(
        red:0.86,
        green:0.86,
        blue:0.86,
        alpha:1.0)

    
    //MARK: - PUBLIC  - 
    
    //MARK: INIT
    public func setup(
        title: String,
        parentCell: XvSetDisclosureCell){
        
        self.title = title
        self.parentCell = parentCell
        
        parentCellData = parentCell.data as! XvSetDisclosureCellData?
        parentCellKey = parentCellData!.key
        
    }
    
    //MARK:BUILD
    
    // number of section(s)
    
    override public func numberOfSections(in tableView: UITableView) -> Int {
        //checkmark list are just 1 section
        return 1
    }
    
    
    //number of rows in each section
    
    override public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if (parentCellData != nil){
            
            return (parentCellData?.subLabels.count)!
            
        } else {
            if (debug){
                print("SETTINGS: Checkmark table data is nil while getting number of rows")
            }
            return 0
        }
    }
     
    
    //title text in each section
    override public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        //no title to section
        return ""
    }
    
    override public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (parentCellData != nil){
            
            //record parent values
            let parentCellKey:String = parentCellData!.key
            let parentCellDataType:String = parentCellData!.dataType
            
            //record values for this cell
            let cellValue:Any = parentCellData!.subValues[indexPath.row]
            let cellLabel:String = (parentCellData?.subLabels[indexPath.row])!
            var cellSelected:Bool = false
            
            //if this row is the default position, then set selected to true
            if (parentCellData?.defaultPosition == indexPath.row){
                cellSelected = true
            }
            
            //make a checkmark cell data obj
            let cellDataValueObj:XvSetCheckmarkCellData = XvSetCheckmarkCellData(
                key: parentCellKey,
                value: cellValue,
                selected: cellSelected,
                label: cellLabel,
                dataType: parentCellDataType,
                displayType: XvSetConstants.DISPLAY_TYPE_CHECKMARK
            )
            
            //return a checkmark cell
            return XvSetCheckmarkCell(
                style: .default,
                reuseIdentifier: String(describing: cellValue),
                data: cellDataValueObj)
            
            
        } else {
            if (debug){
                print("SETTINGS: Checkmark table data is nil while building rows")
            }
            return UITableViewCell()
        }
       
    }
    
    //MARK:-
    //MARK: USER INPUT
    
    //user taps row

    override public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if (debug){
            print("SETTINGS: Select row", (indexPath as NSIndexPath).row)
        }
        
        //turn off all checkmarks
        self.resetCheckmarks()
        
        //confirm cell is a checkmark cell
        if let cell:XvSetCheckmarkCell = tableView.cellForRow(at: indexPath) as? XvSetCheckmarkCell {
            
            //update visual and bool to selected
            cell.accessoryType = .checkmark
            cell.isSelected = true
            
            //change color of highlight
            let highlightCell:UIView = UIView(frame:cell.frame)
            highlightCell.backgroundColor = CELL_BACKGROUND_COLOR
            cell.selectedBackgroundView =  highlightCell
            
            
            //update the parent cell data so change is remembered in GUI and recorded to user defaults
            if (parentCellData != nil){
                parentCellData!.setNewDefault(newIndex: indexPath.row)
                
            } else {
                if (debug){
                    print("SETTINGS: Error updating parent cell data during checkmark table row tap")
                }
            }
            
            if (parentCell != nil){
                parentCell?.updateDefaultLabel()
            }
            
        }
        
        //deselect row so the grey background flashes
        tableView.deselectRow(at: indexPath, animated: true)

        
    }
    
    //MARK: - INTERNAL -
    
    internal func resetCheckmarks() {
        for i in 0..<tableView.numberOfSections {
            for j in 0..<tableView.numberOfRows(inSection: i) {
                if let cell = tableView.cellForRow(at: IndexPath(row: j, section: i)) {
                    cell.accessoryType = .none
                }
            }
        }
    }
    
}
