//
//  DefaultsAccessors.swift
//  Update: XvCoreDataManager
//  XvSettings
//
//  Created by Jason Snell on 3/18/17.
//  Update: Created by Jason Snell on 6/9/17.
//  Copyright © 2017 Jason J. Snell. All rights reserved.
//

import UIKit
import CoreData

//basic functions, including getters and setters, used with CoreData


open class XvCoreDataManager {
    
    // keep ref to managed context
    fileprivate var managedContext:NSManagedObjectContext?
    
    //single app var for quick access
    fileprivate var app:NSManagedObject?
    
    //one list of kits for quick access
    fileprivate var kits:[NSManagedObject]?
    
    fileprivate let debug:Bool = true
    
    
    //MARK: - INIT - 
    
    public init(){
        //nothing here, because it gets called before app delegate init's
    }
    
    //called in first app delegate func
    //ref to managedContext
    public func setup(withManagedContext:NSManagedObjectContext){
        
        if (debug){
            print("CDM: Setup")
        }
        self.managedContext = withManagedContext
        
    }
    
    
    //init a new managed object with entity name
    public func createNewObject(withEntityName:String) -> NSManagedObject? {
        
        if (managedContext != nil){
            
            return NSEntityDescription.insertNewObject(
                forEntityName: withEntityName,
                into: managedContext!)
            
        } else {
            
            print("CDM: Error: Managed context is nil during createNewObject")
            return nil
        }
        
    }
    
    
    
    //MARK: - GETTERS -
    
    public func getApp() -> NSManagedObject? {
        
        if (managedContext != nil){
            
            //if app var is already set, return it
            if (app != nil){
                
                return app
                
            } else {
                
                //else get it from core data
                
                if let apps:[NSManagedObject] = _getManagedObjectArray(fromEntityName: XvSetConstants.kAppEntity) {
                    
                    //if none, return nil
                    if (apps.count == 0){
                        
                        print("CDM: No app object, returning nil")
                        return nil
                        
                    } else {
                        
                        //if there is a record in the array, assign it to the app var and return it
                        set(app: apps[0])
                        return apps[0]
                    }
                    
                } else {
                    return nil
                }
            }
            
        } else {
            print("CDM: Error: Managed context is nil during getApp")
            return nil
        }
        
    }
    
    
    public func getKits() -> [NSManagedObject]? {
        
        if (managedContext != nil){
            
            //if kit var is already set, return it
            if (kits != nil){
                
                return kits
            } else {
                
                //
                if let kitsArr:[NSManagedObject] = _getManagedObjectArray(fromEntityName: XvSetConstants.kKitEntity) {
                    
                    set(kits: kitsArr)
                    return kitsArr
                    
                } else {
                    return nil
                }
            }
            
        } else {
            print("CDM: Error: Managed context is nil during getKits")
            return nil
        }
        
    }
    
    // get instruments array from a kit objects relationship variable "instruments"
    
    public func getInstruments(forKitObject:NSManagedObject) -> [NSManagedObject]? {
        
        //cast as NSSet
        if let instrumentsSet:NSSet = forKitObject.value(forKey: XvSetConstants.kKitInstruments) as? NSSet {
            
            //cast as NSManagedObject array
            if let instrumentObjArray:[NSManagedObject] = instrumentsSet.allObjects as? [NSManagedObject] {
                
                return instrumentObjArray
                
            } else {
                print("CDM: Error getting instrument managed object array for kit", forKitObject)
                return nil
            }
            
        } else {
            print("CDM: Error getting instruments NSSet for kit", forKitObject)
            return nil
        }
        
    }
    
    //MARK: - ACCESSORS FOR APP LEVEL VARS
    
    public func getAppBool(forKey:String) -> Bool {
        
        if let _app:NSManagedObject = getApp(){
            return getBool(forKey: forKey, forObject: _app)
        } else {
            print("CDM: Unable to get app object during getAppBool, returning false")
            return false
        }
        
    }
    
    public func getAppDouble(forKey:String) -> Double {
        
        if let _app:NSManagedObject = getApp(){
            return getDouble(forKey: forKey, forObject: _app)
        } else {
            print("CDM: Unable to get app object during getAppDouble, returning 0.0")
            return 0.0
        }
        
    }
    
    public func getAppFloat(forKey:String) -> Float {
        
        if let _app:NSManagedObject = getApp(){
            return getFloat(forKey: forKey, forObject: _app)
        } else {
            print("CDM: Unable to get app object during getAppFloat, returning 0.0")
            return 0.0
        }
        
    }
    
    public func getAppInteger(forKey:String) -> Int {
        
        if let _app:NSManagedObject = getApp(){
            return getInteger(forKey: forKey, forObject: _app)
        } else {
            print("CDM: Unable to get app object during getAppInterger, returning 0")
            return 0
        }
        
    }
    
    public func getAppString(forKey:String) -> String {
        
        if let _app:NSManagedObject = getApp(){
            return getString(forKey: forKey, forObject: _app)
        } else {
            print("CDM: Unable to get app object during getAppString, returning blank string")
            return ""
        }
        
    }
    
    
    
    
    
    
    
    
    //MARK: - ACCESSORS FOR ANY LEVEL OBJECT
    
    public func getArray(forKey:String, forObject:NSManagedObject) -> [Any] {
        
        if let array:[Any] = _getValue(forKey: forKey, forObject: forObject) as? [Any] {
            
            return array
            
        } else {
            print("CDM: Error getting array for key", forKey, ", returning []")
            return []
        }
    }
    
    public func getBool(forKey:String, forObject:NSManagedObject) -> Bool {
        
        if let bool:Bool = _getValue(forKey: forKey, forObject: forObject) as? Bool {
            
            return bool
            
        } else {
            print("CDM: Error getting bool for key", forKey, ", returning false")
            return false
        }
    }
    
    public func getDouble(forKey:String, forObject:NSManagedObject) -> Double {
        
        if let double:Double = _getValue(forKey: forKey, forObject: forObject) as? Double {
            
            return double
            
        } else {
            print("CDM: Error getting double for key", forKey, ", returning 0.0")
            return 0.0
        }
    }
    
    public func getFloat(forKey:String, forObject:NSManagedObject) -> Float {
        
        if let flt:Float = _getValue(forKey: forKey, forObject: forObject) as? Float {
            
            return flt
            
        } else {
            print("CDM: Error getting float for key", forKey, ", returning 0.0")
            return 0.0
        }
    }

    public func getInteger(forKey:String, forObject:NSManagedObject) -> Int {
        
        if let int:Int = _getValue(forKey: forKey, forObject: forObject) as? Int {
            
            return int
            
        } else {
            print("CDM: Error getting integer for key", forKey, ", returning 0")
            return 0
        }
    }
    
    //called by app delegate
    public func getMatrix(forKey:String, forObject:NSManagedObject) -> [[Int]]? {
        
        if let matrix:[[Int]] = _getValue(forKey: forKey, forObject: forObject) as? [[Int]] {
            return matrix
        } else {
            return nil
        }
    }
    
    public func getString(forKey:String, forObject:NSManagedObject) -> String {
        
        if let str:String = _getValue(forKey: forKey, forObject: forObject) as? String {
            
            return str
            
        } else {
            print("CDM: Error getting string for key", forKey, ", returning blank string")
            return ""
        }
    }
    
    //MARK: - PRIVATE ACCESSORS
    
    
    fileprivate func _getValue(forKey:String, forObject:NSManagedObject) -> Any? {
        
        //try to grab value for key
        if let value:Any = forObject.value(forKey: forKey){
            
            //return if found
            return value
        } else {
            
            //return nil if none found
            return nil
        }
        
    }
    

    
    fileprivate func _getManagedObjectArray(fromEntityName:String) -> [NSManagedObject]?{
        
        //if managed context is valid...
        if (managedContext != nil){
            
            //do a fetch request
            let fetchRequest:NSFetchRequest = NSFetchRequest<NSManagedObject>(entityName: fromEntityName)
            
            do {
                
                //try to get array of apps objects
                let objs:[NSManagedObject] = try managedContext!.fetch(fetchRequest)
                return objs
                
            } catch _ as NSError {
                print("CDM: Error, could not fetch objects during getManagedObjectArray")
                return nil
            }
            
            
        } else {
            
            print("CDM: Error: Managed context is nil during _getManagedObjectArray")
            return nil
        
        }
    
    }
    
    // MARK: - SETTERS -
    
    public func set(app:NSManagedObject){
        self.app = app
    }
    
    public func set(kits:[NSManagedObject]){
        self.kits = kits
    }
    
    public func setApp(value:Any, forKey:String) {
        
        if let _app:NSManagedObject = getApp(){
            set(value: value, forKey: forKey, forObject: _app)
            let _:Bool = save()
        } else {
            print("CDM: Unable to get app object during setAppValue")
        }
        
    }
    
    fileprivate func set(value:Any, forKey:String, forObject:NSManagedObject) {
        
        forObject.setValue(value, forKeyPath: forKey)
        let _:Bool = save()
        if (debug){
            print("CDM: Set", forKey, "to", value)
        }
        
    }
    
    
    //MARK: - SAVE -
    public func save() -> Bool {
        
        if (managedContext != nil){
            
            do {
                
                try managedContext!.save()
                return true
                
            } catch let error as NSError {
                
                print("CDM: Error: Could not save managed context \(error), \(error.userInfo)")
                return false
                
            }
            
        } else {
            print("CDM: Error: Managed context is nil during save")
            return false
        }
        
    }

    
}
