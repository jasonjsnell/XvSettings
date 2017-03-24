//
//  SetMultiDataObj.swift
//  Refraktions
//
//  Created by Jason Snell on 3/16/17.
//  Copyright © 2017 Jason J. Snell. All rights reserved.
//

import Foundation

internal class SetMultiData:XvSetMultiData {
    
    public override init() {}
    
    //called by checkmarks cell tables to target the parent data obj so it can be updated when the user selects different cells
    
    internal override func getDataObj(forKey:String) -> XvSetCellData? {
        
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
