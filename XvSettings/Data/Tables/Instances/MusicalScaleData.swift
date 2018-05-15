//
//  SetMusicalScaleData
//  Repercussion
//
//  Created by Jason Snell on 6/4/17.
//  Copyright © 2017 Jason J. Snell. All rights reserved.

import CoreData

class MusicalScaleData:CheckmarkTableData {
    
    fileprivate let _xvcdm:XvCoreDataManager = XvCoreDataManager.sharedInstance
    
    public init?(){
        
        //root / global key
        var rootKeySection:SectionData?
        
        if let currConfigFile:NSManagedObject = _xvcdm.currConfigFile,
            let musicalScaleRootKeyInt:Int = _xvcdm.getInteger(
            forKey: XvSetConstants.kConfigMusicalScaleRootKey,
            forObject: currConfigFile) {
            
            let rootKey:SliderCellData = SliderCellData(
                key: XvSetConstants.kConfigMusicalScaleRootKey,
                value: musicalScaleRootKeyInt,
                valueMin: 0,
                valueMax: Float(Labels.getMusicScaleNotes().count-1),
                textLabel: Labels.MUSICAL_SCALE_ROOT_KEY_LABEL,
                dataType: XvSetConstants.DATA_TYPE_INTEGER,
                levelType: XvSetConstants.LEVEL_TYPE_CONFIG,
                isVisible: true)
            
            rootKey.set(substituteTextLabels: Labels.getMusicScaleNotes())
            
            rootKeySection = SectionData(
                header: Labels.MUSICAL_SCALE_ROOT_KEY_LABEL,
                footerType: XvSetConstants.FOOTER_TYPE_NONE,
                footerText: nil,
                footerLink: nil,
                footerHeight: 10,
                cells: [rootKey],
                isVisible: true
            )
            
        } else {
            
            print("SETTINGS: Error getting musical note root key during musical scale table init")
            return nil
        }

        
        //musical scale selection
        
        var musicalScaleSection:SectionData?
        
        let musicalScaleKey:String = XvSetConstants.kConfigMusicalScale
        if let currConfigFile:NSManagedObject = _xvcdm.currConfigFile,
            let musicalScaleValue:String = _xvcdm.getString(forKey: musicalScaleKey, forObject: currConfigFile) {
        
            super.init(
                
                key: musicalScaleKey,
                dataType: XvSetConstants.DATA_TYPE_STRING,
                defaultValue: musicalScaleValue,
                possibleValues: XvSetConstants.getMusicScaleValues(),
                textLabel: Labels.MUSIC_SCALE_LABEL,
                detailTextLabels: Labels.getMusicScaleLabels(),
                levelType: XvSetConstants.LEVEL_TYPE_CONFIG,
                isVisible: true
                
            )
            
            musicalScaleSection = SectionData(
                
                header: Labels.MUSIC_SCALE_HEADER,
                footerType: XvSetConstants.FOOTER_TYPE_NONE,
                footerText: nil,
                footerLink: nil,
                footerHeight: 10,
                cells: getCellDataArray(),
                isVisible: true
                
            )
            
            title = Labels.MUSIC_SCALE_HEADER
            
        } else {
            
            print("SETTINGS: Error: Unable to get musical scale from core data in MusicalScaleData")
            return nil
        }
        
        //custom scale table
        
        let musicalScaleCustom:DisclosureCellData = DisclosureCellData(
            key: XvSetConstants.kConfigMusicalScaleCustom,
            textLabel: Labels.MUSIC_SCALE_CUSTOM_LABEL,
            isVisible: true
        )
        
        let musicalScaleCustomSection:SectionData = SectionData(
            header: Labels.MUSIC_SCALE_CUSTOM_HEADER,
            footerType: XvSetConstants.FOOTER_TYPE_NONE,
            footerText: nil,
            footerLink: nil,
            footerHeight: 40,
            cells: [musicalScaleCustom],
            isVisible: true
        )
        
        
        
        //append sections
        if (rootKeySection != nil){
            sections.append(rootKeySection!)
        }
        
        if (musicalScaleSection != nil){
            sections.append(musicalScaleSection!)
        }
        
        sections.append(musicalScaleCustomSection)
        
       
        
    }
}
