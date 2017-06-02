//
//  DefaultsAccessors.swift
//  XvSettings
//
//  Created by Jason Snell on 3/18/17.
//  Copyright © 2017 Jason J. Snell. All rights reserved.
//

import Foundation

//basic getters and setters used with UserDefaults

//connect to standard user defaults
public let defaults:UserDefaults = UserDefaults.standard

open class XvDefaultsAccessors {
    
    public init(){
    
        let userDefaults:UserDefaults = UserDefaults.standard
        
        let instrObj1:XvSetInstrumentDataObj = XvSetInstrumentDataObj(name: "test name", filename: "testfilename", volume: 0.1, quantization: 8, loopLength: 1, measuresUntilFadeOut: 16, midiChannel: 5, regenerateAtBeginningOfPatten: true, pitchVariesEachLoop: false, volumeLock: false)
        
        let instrObj2:XvSetInstrumentDataObj = XvSetInstrumentDataObj(name: "test name2", filename: "testfilename2", volume: 0.2, quantization: 8, loopLength: 1, measuresUntilFadeOut: 16, midiChannel: 5, regenerateAtBeginningOfPatten: true, pitchVariesEachLoop: false, volumeLock: false)
        
        let kitObj:XvSetKitDataObj = XvSetKitDataObj(id: "testKit", name: "Test Kit", instrumentArray: [instrObj1, instrObj2])
        
        let akey:String = "testKey"
        
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: [kitObj])
        
        userDefaults.set(encodedData, forKey: akey)
        
        if let data = UserDefaults.standard.data(forKey: akey),
            let kitDataObjArray:[XvSetKitDataObj] = NSKeyedUnarchiver.unarchiveObject(with: data) as? [XvSetKitDataObj] {
            
            
            for kitDataObj in kitDataObjArray {
                print(kitDataObj.name)
                print(kitDataObj.id)
                let instrumentDataObjArr:[XvSetInstrumentDataObj] = kitDataObj.instrumentArray
                
                for instrumentDataObj in instrumentDataObjArr {
                    
                    print("INSTRUMENT")
                    print(instrumentDataObj.name)
                    print(instrumentDataObj.filename ?? "")
                    
                    print(instrumentDataObj.volume)
                    
                    print(instrumentDataObj.quantization)
                    print(instrumentDataObj.loopLength)
                    print(instrumentDataObj.measuresUntilFadeOut)
                    print(instrumentDataObj.midiChannel)
                    
                    print(instrumentDataObj.regenerateAtBeginningOfPatten)
                    print(instrumentDataObj.pitchVariesEachLoop)
                    print(instrumentDataObj.volumeLock)
                }
            }
        
        } else {
            print("There is an issue")
        }

        
        
        
    }
    
    
    //MARK: - CONSTANTS -
    
    fileprivate let EMPTY_STRING:String = "empty_string"
    fileprivate let EMPTY_ARRAY:[Any] = []
    
    
    //MARK:- GETTERS -
    
    public func getBool(forKey:String) -> Bool {
        return defaults.bool(forKey: forKey)
    }
    
    public func getInteger(forKey:String) -> Int {
        return defaults.integer(forKey: forKey)
    }
    
    public func getDouble(forKey:String) -> Double {
        return defaults.double(forKey: forKey)
    }
    
    public func getString(forKey:String) -> String {
        if let str:String = defaults.string(forKey: forKey) {
            return str
        } else {
            print("DM: NONE returned in string request for", forKey)
            return EMPTY_STRING
        }
    }
    
    public func getArray(forKey:String) -> [Any] {
        
        if let array:[Any] = defaults.array(forKey: forKey) {
            return array
        } else {
            print("DM: BLANK_ARRAY returned in array request for", forKey)
            return EMPTY_ARRAY
        }
    }
    
    
    //MARK: - SETTERS -
    
    public func set(value:Any, forKey:String){
        defaults.set(value, forKey: forKey)
    }
    
    public func set(value:Double, forKey:String){
        defaults.set(value, forKey: forKey)
    }
    
    public func set(value:Int, forKey:String){
        defaults.set(value, forKey: forKey)
    }
    
    public func set(bool:Bool, forKey:String){
        defaults.set(bool, forKey: forKey)
    }

    
}
