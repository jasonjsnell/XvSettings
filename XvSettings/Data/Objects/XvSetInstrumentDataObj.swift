//
//  XvSetInstrumentDataObj.swift
//  XvSettings
//
//  Created by Jason Snell on 6/1/17.
//  Copyright © 2017 Jason J. Snell. All rights reserved.
//

import Foundation

public class XvSetInstrumentDataObj:NSObject, NSCoding {
    
    internal var name:String
    internal var filename:String?
    
    internal var volume:Float
    
    internal var quantization:Int32
    internal var loopLength:Int32
    internal var measuresUntilFadeOut:Int32
    internal var midiChannel:Int32
    
    internal var regenerateAtBeginningOfPatten:Bool
    internal var pitchVariesEachLoop:Bool
    internal var volumeLock:Bool
    
    public init(
        name:String,
        filename:String?,
        volume:Float,
        quantization:Int32,
        loopLength:Int32,
        measuresUntilFadeOut:Int32,
        midiChannel:Int32,
        regenerateAtBeginningOfPatten:Bool,
        pitchVariesEachLoop:Bool,
        volumeLock:Bool){
        
        self.name = name
        self.filename = filename
        self.volume = volume
        self.quantization = quantization
        self.loopLength = loopLength
        self.measuresUntilFadeOut = measuresUntilFadeOut
        self.midiChannel = midiChannel
        self.regenerateAtBeginningOfPatten = regenerateAtBeginningOfPatten
        self.pitchVariesEachLoop = pitchVariesEachLoop
        self.volumeLock = volumeLock
        
    }
    
    required public init(coder decoder: NSCoder) {
        
        //strings
        self.name = decoder.decodeObject(forKey: "name") as? String ?? ""
        self.filename = decoder.decodeObject(forKey: "filename") as? String ?? ""
        
        //float
        self.volume = decoder.decodeFloat(forKey: "volume")
        
        //ints
        self.quantization = decoder.decodeInt32(forKey: "quantization")
        self.loopLength = decoder.decodeInt32(forKey: "loopLength")
        self.measuresUntilFadeOut = decoder.decodeInt32(forKey: "measuresUntilFadeOut")
        self.midiChannel = decoder.decodeInt32(forKey: "midiChannel")
        
        //bools
        self.regenerateAtBeginningOfPatten = decoder.decodeBool(forKey: "regenerateAtBeginningOfPatten")
        self.pitchVariesEachLoop = decoder.decodeBool(forKey: "pitchVariesEachLoop")
        self.volumeLock = decoder.decodeBool(forKey: "volumeLock")
        
    }
    
    public func encode(with coder: NSCoder) {
       
        //strings
        coder.encode(name, forKey: "name")
        coder.encode(filename, forKey: "filename")
        
        //float
        coder.encode(volume, forKey: "volume")
        
        //ints
        coder.encode(quantization, forKey: "quantization")
        coder.encode(loopLength, forKey: "loopLength")
        coder.encode(measuresUntilFadeOut, forKey: "measuresUntilFadeOut")
        coder.encode(midiChannel, forKey: "midiChannel")
        
        //bools
        coder.encode(regenerateAtBeginningOfPatten, forKey: "regenerateAtBeginningOfPatten")
        coder.encode(pitchVariesEachLoop, forKey: "pitchVariesEachLoop")
        coder.encode(volumeLock, forKey: "volumeLock")
        
    }
}
