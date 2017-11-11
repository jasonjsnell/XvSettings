//
//  MeasuresUntilFadeOutData.swift
//  XvSettings
//
//  Created by Jason Snell on 7/3/17.
//  Copyright © 2017 Jason J. Snell. All rights reserved.
//

import Foundation
import CoreData

class AmpReleaseData:CheckmarkTableData {
    
    fileprivate let _xvcdm:XvCoreDataManager = XvCoreDataManager.sharedInstance
    
    public init?(withInstrDataObj:NSManagedObject){
        
        let key:String = XvSetConstants.kTrackAmpRelease
        
        if let value:Int = _xvcdm.getInteger(forKey: key, forObject: withInstrDataObj){
            
            super.init(
                
                key: key,
                dataType: XvSetConstants.DATA_TYPE_INTEGER,
                defaultValue: value,
                possibleValues: [8, 16, 32, 64],
                textLabel: Labels.AMP_RELEASE_LABEL,
                detailTextLabels: [
                    Labels.AMP_RELEASE_MEASURE_8,
                    Labels.AMP_RELEASE_MEASURE_16,
                    Labels.AMP_RELEASE_MEASURE_32,
                    Labels.AMP_RELEASE_MEASURE_64
                ],
                levelType: XvSetConstants.LEVEL_TYPE_TRACK,
                isVisible: true
                
            )
            
            let section:SectionData = SectionData(
                
                header: Labels.AMP_RELEASE_HEADER,
                footerType: XvSetConstants.FOOTER_TYPE_NONE,
                footerText: nil,
                footerLink: nil,
                footerHeight: 10,
                cells: getCellDataArray(),
                isVisible: true
                
            )
            
            sections.append(section)
            
        } else {
            
            print("SETTINGS: Error: Unable to get musical scale from core data in ampReleaseData")
            return nil
        }
    }
    
}
