//
//  SetSectionDataObj.swift
//  Refraktions
//
//  Created by Jason Snell on 3/16/17.
//  Copyright © 2017 Jason J. Snell. All rights reserved.
//

import Foundation
import CoreGraphics

public class XvSetSectionData {

    //header
    internal var header:String = ""
    
    //footer
    internal var footerType:String = ""
    internal var footerText:[String]?
    internal var footerLink:String?
    internal var footerHeight:CGFloat = 10
    
    //cells
    internal var cells:[XvSetCellData] = []
    
    //visibility
    internal var isVisible:Bool = true
    internal var visibilityTargets:[Int]?
    
    public init(
        
        header:String,
        footerType:String,
        footerText:[String]?,
        footerLink:String?,
        footerHeight:CGFloat,
        cells:[XvSetCellData],
        isVisible:Bool,
        visibilityTargets:[Int]?
        ){
    
        
        self.header = header
        self.footerType = footerType
        self.footerText = footerText
        self.footerLink = footerLink
        self.footerHeight = footerHeight
        self.cells = cells
        self.isVisible = isVisible
        self.visibilityTargets = visibilityTargets
        
    }
    
}
