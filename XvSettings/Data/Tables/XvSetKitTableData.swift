//
//  XvSetKitTableData.swift
//  XvSettings
//
//  Created by Jason Snell on 6/6/17.
//  Copyright © 2017 Jason J. Snell. All rights reserved.
//

import Foundation

open class XvSetKitTableData:XvSetTableData {
    
    public init(kitDataObj:Any){
        print("SETTINGS: Init kit table with data obj", kitDataObj)
        
        super.init()
        
        /*
        
        //header is the name of the kit
        title = kitDataObj.name
        
        //MARK: Kit
        
        // Loop through instruments in kit
        
        var instrumentDisclosureCellDataArray:[XvSetDisclosureCellData] = []
        
        for instrument in kitDataObj.instrumentArray {
            
            let instrumentDisclosureCellData:XvSetDisclosureCellData = XvSetDisclosureCellData(key: "", textLabel: instrument.name)
            
            instrumentDisclosureCellDataArray.append(instrumentDisclosureCellData)
            
        }
        
        let instrumentSelection:XvSetSectionData = XvSetSectionData(
            header: "Instruments",
            footerType: XvSetConstants.FOOTER_TYPE_NONE,
            footerText: nil,
            footerLink: nil,
            footerHeight: 10,
            cells: instrumentDisclosureCellDataArray,
            isVisible: true
        )
        
        sections.append(instrumentSelection)
        */
        
    }
    
}
