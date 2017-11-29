//
//  LoopLengthData.swift
//  XvSettings
//
//  Created by Jason Snell on 7/3/17.
//  Copyright © 2017 Jason J. Snell. All rights reserved.
//

import Foundation
import CoreData

class LoopLengthData:CheckmarkTableData {
    
    fileprivate let _xvcdm:XvCoreDataManager = XvCoreDataManager.sharedInstance
    
    public init?(withTrackDataObj:NSManagedObject){
        
        let key:String = XvSetConstants.kTrackLoopLength
        
        if let value:Int = _xvcdm.getInteger(forKey: key, forObject: withTrackDataObj){
            
            super.init(
                
                key: key,
                dataType: XvSetConstants.DATA_TYPE_INTEGER,
                defaultValue: value,
                possibleValues: [1, 2, 4, 8],
                textLabel: Labels.LOOP_LENGTH_LABEL,
                detailTextLabels: [
                    Labels.LOOP_LENGTH_MEASURE_1,
                    Labels.LOOP_LENGTH_MEASURE_2,
                    Labels.LOOP_LENGTH_MEASURE_4,
                    Labels.LOOP_LENGTH_MEASURE_8,
                ],
                levelType: XvSetConstants.LEVEL_TYPE_TRACK,
                isVisible: true
                
            )
            
            let section:SectionData = SectionData(
                
                header: Labels.LOOP_LENGTH_HEADER,
                footerType: XvSetConstants.FOOTER_TYPE_NONE,
                footerText: nil,
                footerLink: nil,
                footerHeight: 10,
                cells: getCellDataArray(),
                isVisible: true
                
            )
            
            sections.append(section)
            
        } else {
            
            print("SETTINGS: Error: Unable to get musical scale from core data in LoopLengthData")
            return nil
        }
    }
    
}

