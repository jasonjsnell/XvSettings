//
//  SetMusicalScaleData
//  Repercussion
//
//  Created by Jason Snell on 6/4/17.
//  Copyright © 2017 Jason J. Snell. All rights reserved.


//TODO: can this be in framework?

class XvMusicalScaleData:XvSetCheckmarkTableData {
    
    fileprivate let xvcdm:XvCoreDataManager = XvCoreDataManager()
    
    public init(){
       
        let key:String = XvSetConstants.kMusicalScale
        
        super.init(
            
            key: key,
            dataType: XvSetConstants.DATA_TYPE_STRING,
            value: xvcdm.getAppString(forKey: key),
            values: XvSetConstants.getMusicScaleValues(),
            textLabel: XvSetConstants.MUSIC_SCALE_LABEL,
            detailTextLabels: XvSetConstants.getMusicScaleLabels(),
            multi: false,
            levelType: XvSetConstants.LEVEL_TYPE_APP
            
        )
        
        let section:XvSetSectionData = XvSetSectionData(
            
            header: XvSetConstants.MUSIC_SCALE_LABEL,
            footerType: XvSetConstants.FOOTER_TYPE_NONE,
            footerText: nil,
            footerLink: nil,
            footerHeight: 10,
            cells: getCellDataArray(),
            isVisible: true
            
        )
        
        sections.append(section)
    }
    
}
