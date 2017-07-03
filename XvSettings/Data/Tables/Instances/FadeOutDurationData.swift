//
//  MeasuresUntilFadeOutData.swift
//  XvSettings
//
//  Created by Jason Snell on 7/3/17.
//  Copyright © 2017 Jason J. Snell. All rights reserved.
//

import Foundation
import CoreData

class FadeOutDurationData:CheckmarkTableData {
    
    fileprivate let _xvcdm:XvCoreDataManager = XvCoreDataManager.sharedInstance
    
    public init?(withInstrDataObj:NSManagedObject){
        
        let key:String = XvSetConstants.kInstrumentFadeOutDuration
        
        if let value:Int = _xvcdm.getInteger(forKey: key, forObject: withInstrDataObj){
            
            super.init(
                
                key: key,
                dataType: XvSetConstants.DATA_TYPE_INTEGER,
                defaultValue: value,
                possibleValues: [8, 16, 32, 64],
                textLabel: Labels.FADE_OUT_DURATION_LABEL,
                detailTextLabels: [
                    Labels.FADE_OUT_DURATION_MEASURE_8,
                    Labels.FADE_OUT_DURATION_MEASURE_16,
                    Labels.FADE_OUT_DURATION_MEASURE_32,
                    Labels.FADE_OUT_DURATION_MEASURE_64
                ],
                levelType: XvSetConstants.LEVEL_TYPE_INSTRUMENT,
                isVisible: true
                
            )
            
            let section:SectionData = SectionData(
                
                header: Labels.FADE_OUT_DURATION_HEADER,
                footerType: XvSetConstants.FOOTER_TYPE_NONE,
                footerText: nil,
                footerLink: nil,
                footerHeight: 10,
                cells: getCellDataArray(),
                isVisible: true
                
            )
            
            sections.append(section)
            
        } else {
            
            print("SETTINGS: Error: Unable to get musical scale from core data in FadeOutDurationData")
            return nil
        }
    }
    
}
