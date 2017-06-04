//
//  XvSetMultiDataObj.swift
//  Refraktions
//
//  Created by Jason Snell on 3/16/17.
//  Copyright © 2017 Jason J. Snell. All rights reserved.
//

import Foundation

open class XvSetTableData {
    
    public var title:String = ""
    public var sections:[XvSetSectionData] = []
    
    
    public init() {}
    
    //called by checkmarks cell tables to target the parent data obj so it can be updated when the user selects different cells
    
    internal func getDataObj(forKey:String) -> XvSetCellData? {
        
        for section in sections {
            
            for cell in section.cells {
                
                if (cell.key == forKey){
                    return cell
                }
            }
        }
        
        return nil
    }
    
}
