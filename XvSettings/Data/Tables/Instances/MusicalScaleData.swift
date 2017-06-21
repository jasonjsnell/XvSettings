//
//  SetMusicalScaleData
//  Repercussion
//
//  Created by Jason Snell on 6/4/17.
//  Copyright © 2017 Jason J. Snell. All rights reserved.


class MusicalScaleData:CheckmarkTableData {
    
    fileprivate let _xvcdm:XvCoreDataManager = XvCoreDataManager.sharedInstance
    
    public init?(){
       
        let key:String = XvSetConstants.kMusicalScale
        
        if let value:String = _xvcdm.getAppString(forKey: key) {
            
            super.init(
                
                key: key,
                dataType: XvSetConstants.DATA_TYPE_STRING,
                defaultValue: value,
                possibleValues: XvSetConstants.getMusicScaleValues(),
                textLabel: XvSetConstants.MUSIC_SCALE_LABEL,
                detailTextLabels: XvSetConstants.getMusicScaleLabels(),
                levelType: XvSetConstants.LEVEL_TYPE_APP,
                isVisible: true
                
            )
            
            let section:SectionData = SectionData(
                
                header: XvSetConstants.MUSIC_SCALE_LABEL,
                footerType: XvSetConstants.FOOTER_TYPE_NONE,
                footerText: nil,
                footerLink: nil,
                footerHeight: 10,
                cells: getCellDataArray(),
                isVisible: true
                
            )
            
            sections.append(section)
            
        } else {
            
            print("SETTINGS: Error: Unable to get musical scale from core data in MusicalScaleData")
            return nil
        }
    }
    
}
