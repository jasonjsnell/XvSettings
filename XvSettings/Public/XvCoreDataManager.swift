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
    fileprivate var currTrack:NSManagedObject?
    
    
    //these are the vars that need to come in externally (from MIDI framework) when opening the settings panel
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
                
                if let apps:[NSManagedObject] = _getManagedObjectArray(
                    fromEntityName: XvSetConstants.kAppEntity,
                    sortKey: nil) {
                    
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
    
    // get track array from the app objects relationship variable "tracks"
    public func getTracks() -> [NSManagedObject?]? {
        
        if let _app:NSManagedObject = getApp(){
            
            //cast as NSSet
            if let tracksSet:NSSet = _app.value(forKey: XvSetConstants.kAppTracks) as? NSSet {
                
                //cast as NSManagedObject array
                if let unsortedTrackObjArray:[NSManagedObject] = tracksSet.allObjects as? [NSManagedObject] {
                    
                    //create blank array of nil objects
                    var sortedTrackObjArr = [NSManagedObject?](
                        repeating: nil,
                        count: unsortedTrackObjArray.count
                    )
                    
                    //go through unsorted object array
                    for unsortedObj in unsortedTrackObjArray {
                        
                        //grab position var
                        if let position:Int = unsortedObj.value(forKey: XvSetConstants.kTrackPosition) as? Int {
                            
                            //and place content in that position in the sorted array
                            sortedTrackObjArr[position] = unsortedObj
                        } else {
                            print("CDM: Error getting position from unsorted object during getTracks")
                        }
                        
                    }
                    
                    return sortedTrackObjArr
                    
                } else {
                    print("CDM: Error getting track managed object array during getTracks")
                    return nil
                }
                
            } else {
                print("CDM: Error getting tracks NSSet during getTracks")
                return nil
            }
            
        } else {
            print("CDM: Error geting app object during getTracks")
            return nil
        }
        
        
        
    }
    
    public func getTrack(forPosition:Int) -> NSManagedObject? {
        
        //get tracks
        if let trackObjs:[NSManagedObject] = getTracks() as? [NSManagedObject] {
            
            //loop through them
            for trackObj in trackObjs {
                
                //grab the position
                if let position:Int = getInteger(forKey: XvSetConstants.kTrackPosition, forObject: trackObj) {
                    
                    //if it matches the incoming id, return the instr data obj
                    if (position == forPosition) {
                        
                        return trackObj
                    }
                } else {
                    print("CDM: Error getting track position during getTrack forPosition")
                }
            }
            
            //else return nil
            return nil
            
        } else {
            
            print("CDM: Error getting tracks during getTrack forPosition")
            return nil
        }
    }
    
    public func getCurrTrack() -> NSManagedObject? {
        
        return currTrack
    }
    
    //MARK: - ACCESSORS FOR APP LEVEL VARS
    
    public func getAppArray(forKey:String) -> [Any]? {
        
        if let _app:NSManagedObject = getApp(){
            return getArray(forKey: forKey, forObject: _app)
        } else {
            print("CDM: Error geting app object during getAppArray")
            return nil
        }
    }
    
    public func getAppBool(forKey:String) -> Bool? {
        
        if let _app:NSManagedObject = getApp(){
            return getBool(forKey: forKey, forObject: _app)
        } else {
            print("CDM: Error geting app object during getAppBool")
            return nil
        }
    }
    
    public func getAppDouble(forKey:String) -> Double? {
        
        if let _app:NSManagedObject = getApp(){
            return getDouble(forKey: forKey, forObject: _app)
        } else {
            print("CDM: Error geting app object during getAppDouble")
            return nil
        }
    }
    
    public func getAppFloat(forKey:String) -> Float? {
        
        if let _app:NSManagedObject = getApp(){
            return getFloat(forKey: forKey, forObject: _app)
        } else {
            print("CDM: Error geting app object during getAppFloat")
            return nil
        }
        
    }
    
    public func getAppInteger(forKey:String) -> Int? {
        
        if let _app:NSManagedObject = getApp(){
            return getInteger(forKey: forKey, forObject: _app)
        } else {
            print("CDM: Error geting app object during getAppInterger")
            return nil
        }
        
    }
    
    public func getAppString(forKey:String) -> String? {
        
        if let _app:NSManagedObject = getApp(){
            return getString(forKey: forKey, forObject: _app)
        } else {
            print("CDM: Error geting app object during getAppString")
            return nil
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
    

    
    fileprivate func _getManagedObjectArray(fromEntityName:String, sortKey:String?) -> [NSManagedObject]?{
        
        //if managed context is valid...
        if (managedContext != nil){
            
            //do a fetch request
            let fetchRequest:NSFetchRequest = NSFetchRequest<NSManagedObject>(entityName: fromEntityName)
            
            if (sortKey != nil){
                let sortDescriptor = NSSortDescriptor(key: sortKey, ascending: true)
                let sortDescriptors = [sortDescriptor]
                fetchRequest.sortDescriptors = sortDescriptors
            }
            
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
    
    
    public func set(currTrack:NSManagedObject) {
        print("CDM: currTrack is now", currTrack.value(forKey: "id") as Any)
        self.currTrack = currTrack
    }
    
    public func setApp(value:Any, forKey:String) {
        
        if let _app:NSManagedObject = getApp(){
            
            if (debug){
                print("CDM: Set", forKey, "to", value, "for app")
            }
            
            _app.setValue(value, forKeyPath: forKey)
            
        } else {
            print("CDM: Unable to get app object during setAppValue")
        }
    }
    
    
    
    public func set(value:Any, forKey:String, forTrackObject:NSManagedObject) {
        
        if (debug){
            
            printChange(value:value, forKey:forKey, forTrackObject: forTrackObject)
        }
        
        forTrackObject.setValue(value, forKeyPath: forKey)
        
    }

    
    public func setCurrTrack(value:Any, forKey:String) {
        
        if (currTrack != nil) {
            
            if (debug){
                
                printChange(value:value, forKey:forKey, forTrackObject: currTrack!)
            }
            
            currTrack!.setValue(value, forKeyPath: forKey)
            
        } else {
            
            print("CDM: Unable to get curr track during setCurrTrack")
        }
    }
    
    fileprivate var _audioBusMidiBypass:Bool = false
    public var audioBusMidiBypass:Bool {
        get { return _audioBusMidiBypass }
        set { _audioBusMidiBypass = newValue }
    }
    
    //called by root vc when settings panel is launched
    public func set(midiDestinationNames:[String]){
        
        self.midiDestinationNames = midiDestinationNames
    }
    
    public func set(midiSourceNames:[String]){
        
        self.midiSourceNames = midiSourceNames
    }
    
    //MARK: - PRIVATE HELPERS
    
    
    fileprivate func printChange(value:Any, forKey:String, forTrackObject:NSManagedObject){
        
        if let position:Int = getInteger(forKey: XvSetConstants.kTrackPosition, forObject: forTrackObject) {
            
            if (forKey != XvSetConstants.kTrackLifetimeKeyTallies){
                print("CDM: Set", forKey, "to", value, "for track", position)
            }
            
        }
        
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
