//
//  XvSetKitTableData.swift
//  XvSettings
//
//  Created by Jason Snell on 6/6/17.
//  Copyright © 2017 Jason J. Snell. All rights reserved.
//

import Foundation
import CoreData

open class XvSetKitTableData:XvSetTableData {
    
    //local copy
    fileprivate var xvcdm:XvCoreDataManager = XvCoreDataManager()
    
    public init(kitDataObj:NSManagedObject){
        //print("SETTINGS: Init kit table with data obj", kitDataObj)
        
        super.init()
        
        //MARK: Header
        let kitName:String = xvcdm.getString(forKey: XvSetConstants.kKitName, forObject: kitDataObj)
        title = kitName
        
        
        //MARK: Instruments section
        
        //try to get instruments data array from core data
        if let instrumentsDataObjs:[NSManagedObject] = xvcdm.getInstruments(forKitObject: kitDataObj) as? [NSManagedObject] {
            
            var instrumentDisclosureCellDataArray:[XvSetDisclosureCellData] = []
            
            // loop through each instrument
            for instrumentsDataObj in instrumentsDataObjs {
             
                let name:String = xvcdm.getString(
                    forKey: XvSetConstants.kInstrumentName,
                    forObject: instrumentsDataObj
                )
                
                let instrumentDisclosureCellData:XvSetDisclosureCellData = XvSetDisclosureCellData(
                    key: "temp",
                    textLabel: name
                )
                
                instrumentDisclosureCellDataArray.append(instrumentDisclosureCellData)
                
            }
            
            
            
            let instrumentsSection:XvSetSectionData = XvSetSectionData(
                header: "Instruments",
                footerType: XvSetConstants.FOOTER_TYPE_NONE,
                footerText: nil,
                footerLink: nil,
                footerHeight: 10,
                cells: instrumentDisclosureCellDataArray,
                isVisible: true
            )
            
            sections.append(instrumentsSection)
           
        
        
            
        } else {
            print("SETTINGS: Unable to find instruments data array during XvSetKitTableData init")
        }
        
        //MARK: Artificial Intelligence
        
        let artificialIntelligence:XvSetButtonCellData = XvSetButtonCellData(
            key: XvSetConstants.kKitArtificialIntelligence,
            textLabel: "Reset AI Memory",
            levelType: XvSetConstants.LEVEL_TYPE_KIT
        )
        
        let artificialIntelligenceSection:XvSetSectionData = XvSetSectionData(
            header: "Artificial Intelligence",
            footerType: XvSetConstants.FOOTER_TYPE_NORMAL,
            footerText: ["This clears and resets the AI memory for " + kitName + "."],
            footerLink: nil,
            footerHeight: 50,
            cells: [artificialIntelligence],
            isVisible: true
        )
        
        sections.append(artificialIntelligenceSection)
        
        
        //MARK: Factory settings
        
        let factorySettings:XvSetButtonCellData = XvSetButtonCellData(
            key: XvSetConstants.kKitFactorySettings,
            textLabel: "Restore " + kitName,
            levelType: XvSetConstants.LEVEL_TYPE_KIT
        )
        
        let factorySettingsSection:XvSetSectionData = XvSetSectionData(
            header: "Factory Settings",
            footerType: XvSetConstants.FOOTER_TYPE_NORMAL,
            footerText: ["This resets the " + kitName + " and its instruments to their factory settings."],
            footerLink: nil,
            footerHeight: 50,
            cells: [factorySettings],
            isVisible: true
        )
        
        sections.append(factorySettingsSection)

        
        /*
        
        
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
