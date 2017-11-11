//
//  QuantizationData.swift
//  XvSettings
//
//  Created by Jason Snell on 6/29/17.
//  Copyright © 2017 Jason J. Snell. All rights reserved.
//

import Foundation
import CoreData

class QuantizationData:CheckmarkTableData {
    
    fileprivate let _xvcdm:XvCoreDataManager = XvCoreDataManager.sharedInstance
    
    public init?(withInstrDataObj:NSManagedObject){
        
        let key:String = XvSetConstants.kTrackQuantization
        
        if let value:Int = _xvcdm.getInteger(forKey: key, forObject: withInstrDataObj){

            super.init(
                
                key: key,
                dataType: XvSetConstants.DATA_TYPE_INTEGER,
                defaultValue: value,
                possibleValues: [16, 8, 4, 2, 1],
                textLabel: Labels.QUANTIZATION_LABEL,
                detailTextLabels: [
                    Labels.QUANTIZATION_1_16,
                    Labels.QUANTIZATION_1_8,
                    Labels.QUANTIZATION_1_4,
                    Labels.QUANTIZATION_1_2,
                    Labels.QUANTIZATION_1_1,
                    
                ],
                levelType: XvSetConstants.LEVEL_TYPE_TRACK,
                isVisible: true
                
            )
            
            let section:SectionData = SectionData(
                
                header: Labels.QUANTIZATION_HEADER,
                footerType: XvSetConstants.FOOTER_TYPE_NONE,
                footerText: nil,
                footerLink: nil,
                footerHeight: 10,
                cells: getCellDataArray(),
                isVisible: true
                
            )
            
            sections.append(section)
            
        } else {
            
            print("SETTINGS: Error: Unable to get musical scale from core data in QuantizationData")
            return nil
        }
    }
    
}
