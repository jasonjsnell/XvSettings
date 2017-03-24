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
    
    public init(){}
    
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
