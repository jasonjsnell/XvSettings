//
//  Utils.swift
//  XvSettings
//
//  Created by Jason Snell on 3/17/17.
//  Copyright © 2017 Jason J. Snell. All rights reserved.
//

import Foundation

class Utils {
    
    //MARK: - NOTIFICATIONS
    class func postNotification(name:String, userInfo:[AnyHashable : Any]?){
        
        let notification:Notification.Name = Notification.Name(rawValue: name)
        NotificationCenter.default.post(
            name: notification,
            object: nil,
            userInfo: userInfo)
    
    }
    
    //converters
    class func getInteger(fromFloat:Float) -> Int {
        
        return Int(fromFloat)
    }
    
    class func getFloatHundredth(fromFloat:Float) -> Float {
        
        return round(100.0 * fromFloat) / 100.0
    }
    
    class func getFloat(fromAny: Any) -> Float? {
        
        if let valueAsFloat:Float = fromAny as? Float {
            
            return valueAsFloat
        
        } else if let valueAsInt:Int = fromAny as? Int {
            
            return Float(valueAsInt)
            
        } else {
            
            return nil
        }
        
    }

}
