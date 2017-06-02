//
//  XvSetKitDataObj.swift
//  XvSettings
//
//  Created by Jason Snell on 6/1/17.
//  Copyright © 2017 Jason J. Snell. All rights reserved.
//

import Foundation

public class XvSetKitDataObj: NSObject, NSCoding {
    
    internal var id:String
    internal var name:String
    internal var instrumentArray:[XvSetInstrumentDataObj]
    
    public init(id:String, name:String, instrumentArray:[XvSetInstrumentDataObj]){
        self.id = id
        self.name = name
        self.instrumentArray = instrumentArray
    }
    
    required public init(coder decoder: NSCoder) {
        self.id = decoder.decodeObject(forKey: "id") as? String ?? ""
        self.name = decoder.decodeObject(forKey: "name") as? String ?? ""
        self.instrumentArray = decoder.decodeObject(forKey: "instrumentArray") as? [XvSetInstrumentDataObj] ?? []
    }
    
    public func encode(with coder: NSCoder) {
        coder.encode(id, forKey: "id")
        coder.encode(name, forKey: "name")
        coder.encode(instrumentArray, forKey: "instrumentArray")
    }
    
}
