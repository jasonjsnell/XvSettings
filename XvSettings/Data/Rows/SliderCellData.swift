//
//  SliderCellData.swift
//  XvSettings
//
//  Created by Jason Snell on 6/22/17.
//  Copyright © 2017 Jason J. Snell. All rights reserved.
//

import Foundation

public class SliderCellData:CellData {
    
    //MARK:- INIT
    public init(
        key:String,
        value:Any,
        textLabel:String,
        levelType:String,
        isVisible:Bool){
        
        super.init(
            key: key,
            value: value,
            textLabel: textLabel,
            displayType: XvSetConstants.DISPLAY_TYPE_SLIDER,
            levelType: levelType,
            isVisible: isVisible
        )
        
    }
    
}

