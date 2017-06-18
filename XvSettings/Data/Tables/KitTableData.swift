//
//  XvSetKitTableData.swift
//  XvSettings
//
//  Created by Jason Snell on 6/6/17.
//  Copyright © 2017 Jason J. Snell. All rights reserved.
//

import Foundation
import CoreData

public class KitTableData:TableData {
    
    public init(kitDataObj:NSManagedObject){
        //print("SETTINGS: Init kit table with data obj", kitDataObj)
        
        super.init()
        
        //MARK: Header
        let kitName:String = xvcdm.getString(forKey: XvSetConstants.kKitName, forObject: kitDataObj)
        title = kitName
        
        
        //MARK: Instruments section
        
        //try to get instruments data array from core data
        if let instrumentsDataObjs:[NSManagedObject] = xvcdm.getInstruments(forKitObject: kitDataObj) as? [NSManagedObject] {
            
            var instrumentDisclosureCellDataArray:[DisclosureCellData] = []
            
            // loop through each instrument
            for instrumentsDataObj in instrumentsDataObjs {
             
                let name:String = xvcdm.getString(
                    forKey: XvSetConstants.kInstrumentName,
                    forObject: instrumentsDataObj
                )
                
                let instrumentDisclosureCellData:DisclosureCellData = DisclosureCellData(
                    key: "temp",
                    textLabel: name
                )
                
                instrumentDisclosureCellDataArray.append(instrumentDisclosureCellData)
                
            }
            
            
            
            let instrumentsSection:SectionData = SectionData(
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
            print("SETTINGS: Unable to find instruments data array during KitTableData init")
        }
        
        //MARK: Artificial Intelligence
        
        let artificialIntelligence:ButtonCellData = ButtonCellData(
            key: XvSetConstants.kKitArtificialIntelligence,
            textLabel: "Reset AI Memory",
            levelType: XvSetConstants.LEVEL_TYPE_KIT
        )
        
        let artificialIntelligenceSection:SectionData = SectionData(
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
        
        let factorySettings:ButtonCellData = ButtonCellData(
            key: XvSetConstants.kKitFactorySettings,
            textLabel: "Restore " + kitName,
            levelType: XvSetConstants.LEVEL_TYPE_KIT
        )
        
        let factorySettingsSection:SectionData = SectionData(
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
        
        var instrumentDisclosureCellDataArray:[DisclosureCellData] = []
        
        for instrument in kitDataObj.instrumentArray {
            
            let instrumentDisclosureCellData:DisclosureCellData = DisclosureCellData(key: "", textLabel: instrument.name)
            
            instrumentDisclosureCellDataArray.append(instrumentDisclosureCellData)
            
        }
        
        let instrumentSelection:SectionData = SectionData(
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
