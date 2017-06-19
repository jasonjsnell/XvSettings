//
//  InstrumentTableData.swift
//  XvSettings
//
//  Created by Jason Snell on 6/19/17.
//  Copyright © 2017 Jason J. Snell. All rights reserved.
//

import Foundation
import CoreData

public class InstrumentTableData:TableData {
    
    //data object that gets passed in from Core Data to populate the table data
    fileprivate var instrumentDataObj:NSManagedObject
   
    public init(instrumentDataObj:NSManagedObject){
        
        self.instrumentDataObj = instrumentDataObj
        
        super.init()
        
        //MARK: Header
        let instrumentName:String = xvcdm.getString(
            forKey: XvSetConstants.kInstrumentName,
            forObject: instrumentDataObj
        )
        
        title = instrumentName
        
       
    }
}
