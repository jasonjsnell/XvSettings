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
    fileprivate var currKit:NSManagedObject?
    fileprivate var currInstrument:NSManagedObject?
    
    //one list of kits for quick access
    fileprivate var kits:[NSManagedObject]?
    
    //these are the only vars that need to come in externally (from MIDI framework) when opening the settings panel
    fileprivate var midiDestinationNames:[String] = []
    fileprivate var midiSourceNames:[String] = []
    
    fileprivate let debug:Bool = true
    
    
    //MARK: - INIT - 
    
    //public init(){
        //nothing here, because it gets called before app delegate init's
    //}
    
    //singleton code
    static public let sharedInstance = XvCoreDataManager()
    public init(){
        //nothing here, because it gets called before app delegate init's
    }
    
    //called in first app delegate func
    //ref to managedContext
    public func setup(withManagedContext:NSManagedObjectContext){
        
        self.managedContext = withManagedContext
        
        if (debug){
            print("CDM: Setup", self.managedContext as Any)
        }
        
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
        
        print("CDM: Get Kits")
        
        if (managedContext != nil){
            
            //if kit var is already set, return it
            if (kits != nil){
                
                return kits
            } else {
                
                //TODO: make alphabetical
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
    
    public func getKit(withID:String) -> NSManagedObject? {
        
        print("CDM: Get kit with ID", withID)
        
        if let kits:[NSManagedObject] = getKits() {
            
            for kit in kits {
                
                if let kitID:String = kit.value(forKey: XvSetConstants.kKitID) as? String {
                    
                    if (kitID == withID){
                        return kit
                    }
                    
                } else {
                    print("CDM: Error finding kit ID during during getKit(withID)")
                    return nil
                }
            }
            
            print("CDM: Error finding kit with id", withID)
            return nil
            
        } else {
            print("CDM: Error: Unable to get kits during getKit(withID)")
            return nil
        }
    }
    
    public func getCurrKit() -> NSManagedObject? {
        
        return currKit
    }
    
    
    // get instruments array from a kit objects relationship variable "instruments"
    public func getInstruments(forKitObject:NSManagedObject) -> [NSManagedObject?]? {
        
        //cast as NSSet
        if let instrumentsSet:NSSet = forKitObject.value(forKey: XvSetConstants.kKitInstruments) as? NSSet {
            
            //cast as NSManagedObject array
            if let unsortedInstrumentObjArray:[NSManagedObject] = instrumentsSet.allObjects as? [NSManagedObject] {
                
                //create blank array of nil objects
                var sortedInstrumentObjArr = [NSManagedObject?](
                    repeating: nil,
                    count: unsortedInstrumentObjArray.count
                )
                
                //go through unsorted object array
                for unsortedObj in unsortedInstrumentObjArray {
                    
                    //grab position var
                    if let position:Int = unsortedObj.value(forKey: XvSetConstants.kInstrumentPosition) as? Int {
                        
                        //and place content in that position in the sorted array
                        sortedInstrumentObjArr[position] = unsortedObj
                    } else {
                        print("CDM: Error getting position from unsorted object during getInstruments")
                    }
                    
                }
                
                return sortedInstrumentObjArr
                
            } else {
                print("CDM: Error getting instrument managed object array for kit", forKitObject)
                return nil
            }
            
        } else {
            print("CDM: Error getting instruments NSSet for kit", forKitObject)
            return nil
        }
    }
    
    public func getInstrumentInCurrKit(forID:String) -> NSManagedObject? {
        
        //grab all instruments in this kit obj
        if (currKit != nil) {
            
            if let instrumentObjs:[NSManagedObject] = getInstruments(forKitObject: currKit!) as? [NSManagedObject] {
                
                //loop through them
                for instrumentObj in instrumentObjs {
                    
                    //grab the id
                    if let id:String = getString(forKey: XvSetConstants.kInstrumentID, forObject: instrumentObj) {
                        
                        //if it matches the incoming id, return the instr data obj
                        if (id == forID) {
                            
                            return instrumentObj
                        }
                    } else {
                        print("CDM: Error getting instrument ID during getInstrumentInCurrKit")
                    }
                }
                
                //else return nil
                return nil
                
            } else {
                
                print("CDM: Error getting instruments during getInstrument")
                return nil
            }
            
        } else {
            print("currKit is nil during getInstrument")
            return nil
        }
    }
    
    public func getCurrInstrument() -> NSManagedObject? {
        
        return currInstrument
    }
    
    //MARK: - ACCESSORS FOR APP LEVEL VARS
    
    public func getAppBool(forKey:String) -> Bool? {
        
        if let _app:NSManagedObject = getApp(){
            return getBool(forKey: forKey, forObject: _app)
        } else {
            print("CDM: Error geting app object during getAppBool, returning false")
            return false
        }
    }
    
    public func getAppDouble(forKey:String) -> Double? {
        
        if let _app:NSManagedObject = getApp(){
            return getDouble(forKey: forKey, forObject: _app)
        } else {
            print("CDM: Error geting app object during getAppDouble, returning 0.0")
            return 0.0
        }
    }
    
    public func getAppFloat(forKey:String) -> Float? {
        
        if let _app:NSManagedObject = getApp(){
            return getFloat(forKey: forKey, forObject: _app)
        } else {
            print("CDM: Error geting app object during getAppFloat, returning 0.0")
            return 0.0
        }
        
    }
    
    public func getAppInteger(forKey:String) -> Int? {
        
        if let _app:NSManagedObject = getApp(){
            return getInteger(forKey: forKey, forObject: _app)
        } else {
            print("CDM: Error geting app object during getAppInterger, returning 0")
            return 0
        }
        
    }
    
    public func getAppString(forKey:String) -> String? {
        
        if let _app:NSManagedObject = getApp(){
            return getString(forKey: forKey, forObject: _app)
        } else {
            print("CDM: Error geting app object during getAppString, returning blank string")
            return ""
        }
        
    }
    
    //MARK: - ACCESSORS FOR ANY LEVEL OBJECT
    
    public func getAny(forKey:String, forObject:NSManagedObject) -> Any? {
        
        return _getValue(forKey: forKey, forObject: forObject)
    }
    
    public func getArray(forKey:String, forObject:NSManagedObject) -> [Any]? {
        
        if let array:[Any] = _getValue(forKey: forKey, forObject: forObject) as? [Any] {
            
            return array
            
        } else {
            print("CDM: Error getting array for key", forKey)
            return nil
        }
    }
    
    public func getBool(forKey:String, forObject:NSManagedObject) -> Bool? {
        
        if let bool:Bool = _getValue(forKey: forKey, forObject: forObject) as? Bool {
            
            return bool
            
        } else {
            print("CDM: Error getting bool for key", forKey)
            return nil
        }
    }
    
    public func getDouble(forKey:String, forObject:NSManagedObject) -> Double? {
        
        if let double:Double = _getValue(forKey: forKey, forObject: forObject) as? Double {
            
            return double
            
        } else {
            print("CDM: Error getting double for key", forKey)
            return nil
        }
    }
    
    public func getFloat(forKey:String, forObject:NSManagedObject) -> Float? {
        
        if let flt:Float = _getValue(forKey: forKey, forObject: forObject) as? Float {
            
            return flt
            
        } else {
            print("CDM: Error getting float for key", forKey)
            return nil
        }
    }

    public func getInteger(forKey:String, forObject:NSManagedObject) -> Int? {
        
        if let int:Int = _getValue(forKey: forKey, forObject: forObject) as? Int {
            
            return int
            
        } else {
            print("CDM: Error getting integer for key", forKey)
            return nil
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
    
    public func getString(forKey:String, forObject:NSManagedObject) -> String? {
        
        if let str:String = _getValue(forKey: forKey, forObject: forObject) as? String {
            
            return str
            
        } else {
            print("CDM: Error getting string for key", forKey)
            return nil
        }
    }
    
    public func getMidiDestinationNames() -> [String] {
        return midiDestinationNames
    }
    
    public func getMidiSourceNames() -> [String] {
        return midiSourceNames
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
    
    public func set(app:NSManagedObject) {
        self.app = app
    }
    
    public func set(kits:[NSManagedObject]) {
        self.kits = kits
    }
    
    public func set(currKit:NSManagedObject) {
        print("CDM: currKit is now", currKit.value(forKey: "id") as Any)
        self.currKit = currKit
    }
    
    public func set(currInstrument:NSManagedObject) {
        print("CDM: currInstrument is now", currInstrument.value(forKey: "id") as Any)
        self.currInstrument = currInstrument
    }
    
    public func setApp(value:Any, forKey:String) {
        
        if let _app:NSManagedObject = getApp(){
            set(value: value, forKey: forKey, forObject: _app)
        } else {
            print("CDM: Unable to get app object during setAppValue")
        }
    }
    
    public func setCurrKit(value:Any, forKey:String) {
        
        if (currKit != nil) {
            set(value: value, forKey: forKey, forObject: currKit!)
        } else {
            print("CDM: Unable to get curr kit during setCurrKitValue")
        }
    }
    
    public func setCurrInstrument(value:Any, forKey:String) {
        
        if (currInstrument != nil) {
            set(value: value, forKey: forKey, forObject: currInstrument!)
        } else {
            print("CDM: Unable to get curr instrument during setCurrKitValue")
        }
    }
    
    
    
    //used by core data helper, setting values during init and updating whole classes
    public func set(value:Any, forKey:String, forObject:NSManagedObject) {
        
        forObject.setValue(value, forKeyPath: forKey)
        
        if (debug){
            if let objectID:String = getString(forKey: "id", forObject: forObject) {
                print("CDM: Set", forKey, "to", value, "for", objectID)
            }
        }
    }
    
    //called by root vc when settings panel is launched
    public func set(midiDestinationNames:[String]){
    
        self.midiDestinationNames = midiDestinationNames
    }
    
    public func set(midiSourceNames:[String]){
        
        self.midiSourceNames = midiSourceNames
    }
    
    
    //MARK: - SAVE -
    public func save() -> Bool {
        
        if (managedContext != nil){
            
            do {
                
                try managedContext!.save()
                if (debug){
                    print("CDM: Data saved")
                }
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
