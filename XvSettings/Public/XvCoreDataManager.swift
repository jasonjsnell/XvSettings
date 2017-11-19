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
    
    //these are the vars that need to come in externally (from MIDI framework) when opening the settings panel
    fileprivate var midiDestinationNames:[String] = []
    fileprivate var midiSourceNames:[String] = []
    
    fileprivate let debug:Bool = true
    
    
    //MARK: - INIT - 
    
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
            print("XVCDM: Setup", self.managedContext as Any)
        }
        
    }
    
    //check to see this is core data's first installtion (user just installed app and launched it for the first time)
    public var firstInstallation:Bool {
        
        get {
            if (_app == nil) {
                
                return true
                
            } else {
                
                return false
            }
        }
    }
    
    //load configutation file
    //used on first installation
    //used when user loads their own custom config file
    
    //loads entire
    public func load(configFile:XvSetConfigFile) {
        
        //loads both app and track level config
        loadApp(configFile: configFile)
        loadTrack(confileFile: configFile)
    }
    
    public func loadApp(configFile:XvSetConfigFile){
        
        //load app level data, mirrors XvDataModel
        setApp(value: configFile.abletonLinkEnabled, forKey: XvSetConstants.kConfigAbletonLinkEnabled)
        setApp(value: configFile.backgroundMode, forKey: XvSetConstants.kConfigBackgroundModeEnabled)
        setApp(value: configFile.globalMidiDestinations, forKey: XvSetConstants.kConfigGlobalMidiDestinations)
        setApp(value: configFile.globalMidiSources, forKey: XvSetConstants.kConfigGlobalMidiSources)
        setApp(value: configFile.id, forKey: XvSetConstants.kAppId)
        setApp(value: configFile.midiSync, forKey: XvSetConstants.kConfigMidiSync)
        setApp(value: configFile.musicalScale, forKey: XvSetConstants.kConfigMusicalScale)
        setApp(value: configFile.musicalScaleRoot, forKey: XvSetConstants.kConfigMusicalScaleRootKey)
        setApp(value: configFile.tourStatus, forKey: XvSetConstants.kAppTourStatus)
        setApp(value: configFile.userTempo, forKey: XvSetConstants.kConfigTempo)
        
    }
    
    //used when user restores factory settings
    public func loadTrack(confileFile:XvSetConfigFile){
        
        //load app level data, mirrors XvDataModel
        
        //TODO: how do I format a file that can be both loaded into XvSettings and XvSequencerSystem into a XvTrack? It can't be a file format from either framework, it has to be a local, simple variable system. It can't be it's own class, like a track object of any kind, because either framework won't recognize it. Dictionary? Array of arrays? NSManagedObject?
    
    }
    
    //init a new managed object with entity name
    public func createNewObject(withEntityName:String) -> NSManagedObject? {
        
        if (managedContext != nil){
            
            return NSEntityDescription.insertNewObject(
                forEntityName: withEntityName,
                into: managedContext!)
            
        } else {
            
            print("XVCDM: Error: Managed context is nil during createNewObject")
            return nil
        }
        
    }
    
    
    
    //MARK: - GETTERS -
    
    // get track array from the app objects relationship variable "tracks"
    public func getTracks() -> [NSManagedObject?]? {
        
        /*
        if let _app:NSManagedObject = getApp(){
            
            
            //TODO: get curr config
            print("getTracks")
            //print(_app.value(forKey: XvSetConstants.kAppTracks) as Any)
            //print(_app.value(forKey: XvSetConstants.kAppTracks) as? [NSManagedObject])
            
            //cast as NSSet
            //TODO: this isn't casting as a NSSet. What is it??
            if let tracksSet:NSSet = _app.value(forKey: XvSetConstants.kAppTracks) as? NSSet {
                
                print("tracksSet", tracksSet)
                
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
                            print("XVCDM: Error getting position from unsorted object during getTracks")
                        }
                        
                    }
                    
                    return sortedTrackObjArr
                    
                } else {
                    print("XVCDM: Error getting track managed object array during getTracks")
                    return nil
                }
                
            } else {
                print("XVCDM: Error getting tracks NSSet during getTracks")
                return nil
            }
            
        } else {
            print("XVCDM: Error geting app object during getTracks")
            return nil
        }
        
        */
        
        return nil
        
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
                    print("XVCDM: Error getting track position during getTrack forPosition")
                }
            }
            
            //else return nil
            return nil
            
        } else {
            
            print("XVCDM: Error getting tracks during getTrack forPosition")
            return nil
        }
    }
    
    public func getCurrTrack() -> NSManagedObject? {
        
        return currTrack
    }
    
    //MARK: - ACCESSORS FOR APP LEVEL VARS
    
    /*
    public func getArray(forKey:String) -> [Any]? {
        
        if (app != nil) {
            return getArray(forKey: forKey, forObject: app!)
        } else {
            print("XVCDM: Error geting app object during getArray")
            return nil
        }
    }
    
    public func getBool(forKey:String) -> Bool? {
        
        if (app != nil) {
            return getBool(forKey: forKey, forObject: app!)
        } else {
            print("XVCDM: Error geting app object during getBool")
            return nil
        }
    }
    
    public func getDouble(forKey:String) -> Double? {
        
        if (app != nil) {
            return getDouble(forKey: forKey, forObject: app!)
        } else {
            print("XVCDM: Error geting app object during getDouble")
            return nil
        }
    }
    
    public func getAppFloat(forKey:String) -> Float? {
        
        if (app != nil) {
            return getFloat(forKey: forKey, forObject: app!)
        } else {
            print("XVCDM: Error geting app object during getAppFloat")
            return nil
        }
        
    }
    
    public func getAppInteger(forKey:String) -> Int? {
        
        if (app != nil) {
            return getInteger(forKey: forKey, forObject: app!)
        } else {
            print("XVCDM: Error geting app object during getAppInterger")
            return nil
        }
        
    }
    
    public func getString(forKey:String) -> String? {
        
        if (app != nil) {
            return getString(forKey: forKey, forObject: app!)
        } else {
            print("XVCDM: Error geting app object during getString")
            return nil
        }
        
    }*/
    
    //MARK: - ACCESSORS FOR ANY LEVEL OBJECT
    
    public func getAny(forKey:String, forObject:NSManagedObject) -> Any? {
        
        return _getValue(forKey: forKey, forObject: forObject)
    }
    
    public func getArray(forKey:String, forObject:NSManagedObject) -> [Any]? {
        
        if let array:[Any] = _getValue(forKey: forKey, forObject: forObject) as? [Any] {
            
            return array
            
        } else {
            print("XVCDM: Error getting array for key", forKey)
            return nil
        }
    }
    
    public func getBool(forKey:String, forObject:NSManagedObject) -> Bool? {
        
        if let bool:Bool = _getValue(forKey: forKey, forObject: forObject) as? Bool {
            
            return bool
            
        } else {
            print("XVCDM: Error getting bool for key", forKey)
            return nil
        }
    }
    
    public func getDouble(forKey:String, forObject:NSManagedObject) -> Double? {
        
        if let double:Double = _getValue(forKey: forKey, forObject: forObject) as? Double {
            
            return double
            
        } else {
            print("XVCDM: Error getting double for key", forKey)
            return nil
        }
    }
    
    public func getFloat(forKey:String, forObject:NSManagedObject) -> Float? {
        
        if let flt:Float = _getValue(forKey: forKey, forObject: forObject) as? Float {
            
            return flt
            
        } else {
            print("XVCDM: Error getting float for key", forKey)
            return nil
        }
    }

    public func getInteger(forKey:String, forObject:NSManagedObject) -> Int? {
        
        if let int:Int = _getValue(forKey: forKey, forObject: forObject) as? Int {
            
            return int
            
        } else {
            print("XVCDM: Error getting integer for key", forKey)
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
            print("XVCDM: Error getting string for key", forKey)
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
                print("XVCDM: Error, could not fetch objects during getManagedObjectArray")
                return nil
            }
            
            
        } else {
            
            print("XVCDM: Error: Managed context is nil during _getManagedObjectArray")
            return nil
        
        }
    
    }
    
    // MARK: - SETTERS -
    
    //MARK: Set vars
    fileprivate var _app:NSManagedObject?
    public var app:NSManagedObject? {
        
        get {
            
            if (_app != nil) {
                
                if (debug) { print("XVCDM: Return the existing app object") }
                
                //if app var is already populated, then return it
                return _app
            
            } else {
                
                //app is nil. Check to see if managedContext is valid
                if (managedContext != nil){
                    
                    //subroutine that makes a new app
                    func makeNewApp() -> NSManagedObject? {
                        
                        if let _newApp:NSManagedObject = createNewObject(
                            withEntityName: XvSetConstants.kAppEntity
                            ) {
                            
                            if (debug) { print("XVCDM: New app object created") }
                            _app = _newApp
                            return _app
                        
                        } else {
                            
                            print("XVCDM: Error making new app object during app retrival request")
                            return nil
                        }
                    }
                    
                    //check to see if an array of app objects already exists
                    if let _apps:[NSManagedObject] = _getManagedObjectArray(
                        fromEntityName: XvSetConstants.kAppEntity,
                        sortKey: nil) {
                        
                        if (debug) { print("XVCDM: App array exists") }
                        
                        //if array is blank, try to make a new app object
                        if (_apps.count == 0){
                            
                            if (debug){ print("XVCDM: App array is empty, try to make a new app object") }
                            
                            return makeNewApp()
                            
                        } else {
                            
                            //if there is an app object in the array, assign it to the app var and return it
                            
                            if (debug) { print("XVCDM: Retriving first app object from app array") }
                            _app = _apps[0]
                            return _app
                        }
                        
                    } else {
                        
                        if (debug) { print("XVCDM: No app array exists, try to make a new app object") }
                        return makeNewApp()
                    }
                    
                } else {
                    
                    //no managed context, unable to make an app object
                    print("XVCDM: Error: Managed context is nil during app retrival")
                    return nil
                }
            }
        }
    }
    
    //curr config file
    fileprivate var _currConfig:NSManagedObject?
    public var currConfig:NSManagedObject? {
        get { return _currConfig! }
        set {
            _currConfig = newValue
            print("XVCDM: currConfig is now", currConfig?.value(forKey: "name") as Any)
        }
    }
    
    //curr sample
    fileprivate var _currSample:NSManagedObject?
    public var currSample:NSManagedObject? {
        get { return _currSample }
        set {
            _currSample = newValue
            print("XVCDM: currSample is now", currSample?.value(forKey: "position") as Any)
        }
    }
    
    //curr track
    fileprivate var _currTrack:NSManagedObject?
    public var currTrack:NSManagedObject? {
        get { return _currTrack }
        set {
            _currTrack = newValue
            print("XVCDM: currTrack is now", currTrack?.value(forKey: "position") as Any)
        }
    }
    
    
    
    //MARK: Set key value pairs
    public func setApp(value:Any, forKey:String) {
        
        if (app != nil) {
            
            if (debug){
                print("XVCDM: Set", forKey, "to", value, "for app")
            }
            
            app!.setValue(value, forKeyPath: forKey)
            
        } else {
            print("XVCDM: Unable to get app object during setAppValue")
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
            
            print("XVCDM: Unable to get curr track during setCurrTrack")
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
                print("XVCDM: Set", forKey, "to", value, "for track", position)
            }
            
        }
        
    }
    
    //MARK: - SAVE -
    public func save() -> Bool {
        
        if (managedContext != nil){
            
            do {
                
                try managedContext!.save()
                if (debug){
                    print("XVCDM: Data saved")
                }
                return true
                
            } catch let error as NSError {
                
                print("XVCDM: Error: Could not save managed context \(error), \(error.userInfo)")
                return false
                
            }
            
        } else {
            print("XVCDM: Error: Managed context is nil during save")
            return false
        }
        
    }

    
}
