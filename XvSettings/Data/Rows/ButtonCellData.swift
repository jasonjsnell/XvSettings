//
//  XvSetButtonCellData.swift
//  XvSettings
//
//  Created by Jason Snell on 6/5/17.
//  Copyright © 2017 Jason J. Snell. All rights reserved.
//

import Foundation

public class ButtonCellData:CellData {
    
    //MARK:- INIT
    public init(
        key:String,
        textLabel:String,
        levelType:String,
        isVisible:Bool){
        
        super.init(
            key: key,
            value: "",
            textLabel: textLabel,
            displayType: XvSetConstants.DISPLAY_TYPE_BUTTON,
            levelType: levelType,
            isVisible: isVisible
        )
        
    }
    
}
