//
//  XvSetInstrumentDataObj.swift
//  XvSettings
//
//  Created by Jason Snell on 6/1/17.
//  Copyright © 2017 Jason J. Snell. All rights reserved.
//

import Foundation

public class XvSetInstrumentDataObj:NSObject, NSCoding {
    
    public var name:String
    public var filename:String?
    
    public var volume:Float
    
    public var quantization:Int32
    public var loopLength:Int32
    public var measuresUntilFadeOut:Int32
    public var midiChannel:Int32
    
    public var regenerateAtBeginningOfPatten:Bool
    public var pitchVariesEachLoop:Bool
    public var volumeLock:Bool
    public var midiEnabled:Bool
    public var audioEnabled:Bool
    
    public var midiDestinations:[Any]
    
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
        volumeLock:Bool,
        midiEnabled:Bool,
        audioEnabled:Bool,
        midiDestinations:[Any]){
        
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
        self.midiEnabled = midiEnabled
        self.audioEnabled = audioEnabled
        self.midiDestinations = midiDestinations
        
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
        self.midiEnabled = decoder.decodeBool(forKey: "midiEnabled")
        self.audioEnabled = decoder.decodeBool(forKey: "audioEnabled")
        
        //arrays
        self.midiDestinations = decoder.decodeObject(forKey: "midiDestinations") as? [Any] ?? []
        
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
        coder.encode(midiEnabled, forKey: "midiEnabled")
        coder.encode(audioEnabled, forKey: "audioEnabled")
        
        //arrays
        coder.encode(midiDestinations, forKey: "midiDestinations")
        
    }
}
