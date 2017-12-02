//
//  PatternLengthData.swift
//  XvSettings
//
//  Created by Jason Snell on 7/3/17.
//  Copyright © 2017 Jason J. Snell. All rights reserved.
//

import Foundation
import CoreData

class PatternLengthData:CheckmarkTableData {
    
    fileprivate let _xvcdm:XvCoreDataManager = XvCoreDataManager.sharedInstance
    
    public init?(withTrackDataObj:NSManagedObject){
        
        let key:String = XvSetConstants.kTrackPatternLength
        
        if let value:Int = _xvcdm.getInteger(forKey: key, forObject: withTrackDataObj){
            
            super.init(
                
                key: key,
                dataType: XvSetConstants.DATA_TYPE_INTEGER,
                defaultValue: value,
                possibleValues: [1, 2, 4, 8],
                textLabel: Labels.PATTERN_LENGTH_LABEL,
                detailTextLabels: [
                    Labels.PATTERN_LENGTH_MEASURE_1,
                    Labels.PATTERN_LENGTH_MEASURE_2,
                    Labels.PATTERN_LENGTH_MEASURE_4,
                    Labels.PATTERN_LENGTH_MEASURE_8,
                ],
                levelType: XvSetConstants.LEVEL_TYPE_TRACK,
                isVisible: true
                
            )
            
            let section:SectionData = SectionData(
                
                header: Labels.PATTERN_LENGTH_HEADER,
                footerType: XvSetConstants.FOOTER_TYPE_NONE,
                footerText: nil,
                footerLink: nil,
                footerHeight: 10,
                cells: getCellDataArray(),
                isVisible: true
                
            )
            
            sections.append(section)
            
        } else {
            
            print("SETTINGS: Error: Unable to get musical scale from core data in PatternLengthData")
            return nil
        }
    }
    
}

