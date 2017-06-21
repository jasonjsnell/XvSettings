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
        
        super.init()
        
        //save for future ref
        xvcdm.set(currKit: kitDataObj)
        
        //MARK: Header
        if let kitName:String = xvcdm.getString(forKey: XvSetConstants.kKitName, forObject: kitDataObj) {
            
            title = kitName
            
            //MARK: Instruments section
            
            //try to get instruments data array from core data
            if let instrumentsDataObjs:[NSManagedObject] = xvcdm.getInstruments(forKitObject: kitDataObj) as? [NSManagedObject] {
                
                var instrumentDisclosureCellDataArray:[DisclosureCellData] = []
                
                // loop through each instrument
                for instrumentsDataObj in instrumentsDataObjs {
                    
                    if let name:String = xvcdm.getString(
                        forKey: XvSetConstants.kInstrumentName,
                        forObject: instrumentsDataObj
                        ),
                        
                        let id:String = xvcdm.getString(
                            forKey: XvSetConstants.kInstrumentID,
                            forObject: instrumentsDataObj
                        ) {
                        
                        let instrumentDisclosureCellData:DisclosureCellData = DisclosureCellData(
                            key: id,
                            textLabel: name,
                            isVisible: true
                        )
                        
                        instrumentDisclosureCellDataArray.append(instrumentDisclosureCellData)
                        
                    } else {
                        print("SETTINGS: Error getting instrument name and id during kit table init")
                    }
                    
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
                levelType: XvSetConstants.LEVEL_TYPE_KIT,
                isVisible: true
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
                levelType: XvSetConstants.LEVEL_TYPE_KIT,
                isVisible: true
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
            
            
        } else {
            print("SETTINGS: Error getting kit name for table header")
        }
    }
    
}
