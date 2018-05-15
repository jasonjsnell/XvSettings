//
//  MusicalScaleCustomData.swift
//  XvSettings
//
//  Created by Jason Snell on 5/14/18.
//  Copyright © 2018 Jason J. Snell. All rights reserved.
//


import CoreData

class MusicalScaleCustomData:CheckmarkTableData {
    
    fileprivate let _xvcdm:XvCoreDataManager = XvCoreDataManager.sharedInstance
    
    public init?(){
        
        //musical semi-tone selection
        
        var musicalScaleCustomSection:SectionData?
        
        let musicalScaleCustomKey:String = XvSetConstants.kConfigMusicalScaleCustom
        if let currConfigFile:NSManagedObject = _xvcdm.currConfigFile,
            let musicalScaleCustomValues:[Int] = _xvcdm.getArray(forKey: musicalScaleCustomKey, forObject: currConfigFile) as? [Int]{
            
            super.init(
                
                key: musicalScaleCustomKey,
                dataType: XvSetConstants.DATA_TYPE_STRING,
                defaultValue: musicalScaleCustomValues,
                possibleValues: XvSetConstants.getMusicScaleNoteValues(),
                textLabel: Labels.MUSIC_SCALE_LABEL,
                detailTextLabels: Labels.getMusicScaleNotes(),
                levelType: XvSetConstants.LEVEL_TYPE_CONFIG,
                isVisible: true
                
            )
            
            musicalScaleCustomSection = SectionData(
                
                header: Labels.MUSIC_SCALE_CUSTOM_HEADER,
                footerType: XvSetConstants.FOOTER_TYPE_NONE,
                footerText: nil,
                footerLink: nil,
                footerHeight: 10,
                cells: getCellDataArray(),
                isVisible: true
                
            )
            
            title = Labels.MUSIC_SCALE_CUSTOM_HEADER
            
        } else {
            
            print("SETTINGS: Error: Unable to get musical scale from core data in MusicalScaleCustomData")
            return nil
        }
        
        //append
        if (musicalScaleCustomSection != nil){
            sections.append(musicalScaleCustomSection!)
        }
        
        
    }
}

