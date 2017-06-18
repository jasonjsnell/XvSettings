//
//  SetMusicalScaleData
//  Repercussion
//
//  Created by Jason Snell on 6/4/17.
//  Copyright © 2017 Jason J. Snell. All rights reserved.


class MusicalScaleData:CheckmarkTableData {
    
    fileprivate let _xvcdm:XvCoreDataManager = XvCoreDataManager.sharedInstance
    
    public init(){
       
        let key:String = XvSetConstants.kMusicalScale
        
        super.init(
            
            key: key,
            dataType: XvSetConstants.DATA_TYPE_STRING,
            value: _xvcdm.getAppString(forKey: key),
            values: XvSetConstants.getMusicScaleValues(),
            textLabel: XvSetConstants.MUSIC_SCALE_LABEL,
            detailTextLabels: XvSetConstants.getMusicScaleLabels(),
            multi: false,
            levelType: XvSetConstants.LEVEL_TYPE_APP
            
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
    }
    
}
