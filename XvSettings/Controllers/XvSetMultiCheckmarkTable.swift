//
//  SetMultiCheckmarkTable.swift
//  Refraktions
//
//  Created by Jason Snell on 1/6/17.
//  Copyright © 2017 Jason J. Snell. All rights reserved.
//

// a table of checkmark cells, multiple can be selected

import UIKit

public class XvSetMultiCheckmarkTable: XvSetCheckmarkTable {
    
    internal var parentCellMultiData:XvSetDisclosureMultiCellData?

    
    //MARK: - PUBLIC -
    
    //MARK:BUILD
    
    override public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (parentCellData != nil){
            
            parentCellMultiData = parentCellData as? XvSetDisclosureMultiCellData
            
            //record parent values
            let parentCellKey:String = parentCellData!.key
            let parentCellDataType:String = parentCellData!.dataType
            
            //record values for this cell
            let cellValue:Any = parentCellData!.subValues[indexPath.row]
            let cellLabel:String = (parentCellData?.subLabels[indexPath.row])!
            
            var cellSelected:Bool = false
            
            for defaultPosition in parentCellMultiData!.defaultPositions{
                
                //if this row is one of the default position, then set selected to true
                if (defaultPosition == indexPath.row){
                    cellSelected = true
                }
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
                print("SETTINGS: Multi checkmark table data is nil while building rows")
            }
            return UITableViewCell()
        }
        
    }


    //MARK:- USER INPUT
    
    //user taps row
    
    override public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if (debug){
            print("SETTINGS: Select row", (indexPath as NSIndexPath).row)
        }
        
        //confirm cell is a checkmark cell
        if let cell:XvSetCheckmarkCell = tableView.cellForRow(at: indexPath) as? XvSetCheckmarkCell {
            
            //toggle on or off
            if (cell.accessoryType == .checkmark){
                
                cell.isSelected = false
                cell.accessoryType = .none
                
            } else {
                
                cell.isSelected = true
                cell.accessoryType = .checkmark
            }
            
            //change color of highlight
            let highlightCell:UIView = UIView(frame:cell.frame)
            highlightCell.backgroundColor = CELL_BACKGROUND_COLOR
            cell.selectedBackgroundView =  highlightCell
            
            
            //update the parent cell data so change is remembered in GUI and recorded to user defaults
            if (parentCellMultiData != nil){
                
                //if cell is checked (selected)...
                if (cell.accessoryType == .checkmark){
                    
                    //add position to defaults
                    parentCellMultiData!.addDefault(position: indexPath.row)
                    
                } else {
                    
                    //remove position from defaults
                    parentCellMultiData!.removeDefault(position: indexPath.row)
                    
                }
                
                
            } else {
                if (debug){
                    print("SETTINGS: Error updating parent cell data during checkmark table row tap")
                }
            }
            
        }
        
        //deselect row so the grey background flashes
        tableView.deselectRow(at: indexPath, animated: true)
        
    }

}
