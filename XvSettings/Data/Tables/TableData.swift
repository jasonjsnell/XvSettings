//
//  XvSetMultiDataObj.swift
//  Refraktions
//
//  Created by Jason Snell on 3/16/17.
//  Copyright © 2017 Jason J. Snell. All rights reserved.
//


import Foundation
import CoreData

public class TableData {
    
    internal let xvcdm:XvCoreDataManager = XvCoreDataManager.sharedInstance
    
    public var title:String = ""
    public var sections:[SectionData] = []
    
    public init() {
        
        refresh()
        
    }
    
    public func refresh(){
        
        //clear vars
        title = ""
        sections = []
        
    }
    
}
