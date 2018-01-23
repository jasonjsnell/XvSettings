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
    
    //used in mail form
    internal var appID:String = ""
    
    //these are the vars that need to come in externally (from MIDI framework) when opening the settings panel
    fileprivate var _midiDestinationNames:[String] = []
    fileprivate var _midiSourceNames:[String] = []
    
    //called by root vc when settings panel is launched
    public var midiDestinationNames:[String] {
        get { return _midiDestinationNames }
        set { _midiDestinationNames = newValue }
    }
    
    public var midiSourceNames:[String] {
        get { return _midiSourceNames }
        set { _midiSourceNames = newValue }
    }
    
    fileprivate let debug:Bool = false
    
    
    //MARK: - INIT - 
    
    //singleton code
    static public let sharedInstance = XvCoreDataManager()
    public init(){
        //nothing here, because it gets called before app delegate init's
    }
    
    //called in first app delegate func
    //ref to managedContext
    public func setup(appID:String, managedContext:NSManagedObjectContext){
        
        self.appID = appID
        self.managedContext = managedContext
        
        if (debug){
            print("XVCDM: Setup", self.managedContext as Any)
        }
        
    }
    
    //check to see this is core data's first installtion (user just installed app and launched it for the first time)
    public func firstInstallationCheck() -> Bool {
        
        if let _apps:[NSManagedObject] = _getManagedObjectArray(
            fromEntityName: XvSetConstants.kAppEntity,
            sortKey: nil) {
            
            //if (debug) { print("XVCDM: App array exists") }
            
            //if array is blank, try to make a new app object
            if (_apps.count == 0){
                
                return true
                
            } else {
                
                return false
            }
        
        } else {
            
            print("XVCDM: Error getting apps array during firstInstallationCheck")
            return true
        }
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
    
    
    //MARK: - VARS -
    
    //MARK: App
    fileprivate var _app:NSManagedObject?
    public var app:NSManagedObject? {
        
        get {
            
            if (_app != nil) {
                
                //if (debug) { print("XVCDM: Return the existing app object") }
                
                //if app var is already populated, then return it
                return _app
                
            } else {
                
                //check to see if an array of app objects already exists
                if let _apps:[NSManagedObject] = _getManagedObjectArray(
                    fromEntityName: XvSetConstants.kAppEntity,
                    sortKey: nil) {
                    
                    //if (debug) { print("XVCDM: App array exists") }
                    
                    //if array is blank, try to make a new app object
                    if (_apps.count == 0){
                        
                        if (debug){ print("XVCDM: App array is empty, try to create a new app object") }
                        
                        return _createNewApp()
                        
                    } else {
                        
                        //if there is an app object in the array, assign it to the app var and return it
                        
                        if (debug) { print("XVCDM: Retriving first app object from app array") }
                        _app = _apps[0]
                        return _app
                    }
                    
                } else {
                    
                    print("XVCDM: Fatal error: No app array exists. Check core data model for App entity")
                    return nil
                }
                    
                
            }
        }
    }
    
    //MARK: - Config files

    fileprivate var _currConfigFile:NSManagedObject?
    public var currConfigFile:NSManagedObject? {
        
        get {
            
            if (_currConfigFile != nil){
                
                //if (debug) { print("XVCDM: Return the curr config file ") }
                return _currConfigFile!
            
            } else {
                
                if (configFiles != nil){
                    
                    //if (debug) { print("XVCDM: Config files array exists") }
                    
                    if (configFiles!.count == 0){
                        
                        if (debug) { print("XVCDM: There are no config files in config file array. Make one.") }
                        
                        if let _newConfigFile:NSManagedObject = _createNewConfigFile() {
                            
                            if (debug) { print("XVCDM: Return newly created config file") }
                            _currConfigFile = _newConfigFile
                            configFiles!.append(_currConfigFile!)
                            return _currConfigFile
                            
                        }
                        
                    } else {
                        
                        if (debug) { print("XVCDM: Return first config file in config file array") }
                        _currConfigFile = configFiles![0]
                        return _currConfigFile
                    }
                
                } else {
                    
                    print("XVCDM: Fatal error: No ConfigFile array exists. Check core data model for ConfigFile entity")
                    return nil
                }
                
                print("XVCDM: Fatal error: Unable to create config file. Check core data model for ConfigFile entity")
                return nil
           
            }
        }
        
        set {
            _currConfigFile = newValue
            print("XVCDM: currConfigFile is now", currConfigFile?.value(forKey: "name") as Any)
        }
    }
    
    fileprivate var _configFiles:[NSManagedObject]?
    public var configFiles:[NSManagedObject]? {
        
        get {
            
            if (_configFiles != nil) {
                
                //if already stored, return that array
                //if (debug){ print("XVCDM: Return array of config files") }
                return _configFiles
            
            } else {
                
                //else grab that array from core data
                if let configFilesArr:[NSManagedObject] = _getManagedObjectArray(
                    fromEntityName: XvSetConstants.kConfigEntity,
                    sortKey: "createdAtPosition") {
                    
                    //if (debug){ print("XVCDM: Return new array of config files") }
                    
                    _configFiles = configFilesArr
                    return _configFiles
                    
                } else {
                    
                    print("XVCDM: Fatal error: No ConfigFile array exists. Check core data model for ConfigFile entity")
                    return nil
                }
            }
        }
        
        set {
            
            _configFiles = newValue
        }
    }
    
    //MARK: - Tracks
    fileprivate var _currTrack:NSManagedObject?
    public var currTrack:NSManagedObject? {
        get { return _currTrack }
        set {
            _currTrack = newValue
            print("XVCDM: currTrack is now", currTrack?.value(forKey: "position") as Any)
        }
    }
    
    // get track array from the app objects relationship variable "tracks"
    public var tracks:[NSManagedObject?]? {
        
        get {
            
            if (currConfigFile != nil) {
                
                if let tracksSet:NSSet = currConfigFile!.value(forKey: XvSetConstants.kConfigTracks) as? NSSet {
                    
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
                
                print("XVCDM: Curr config file is nil when attempting getTracks")
            }
            
            return nil
        }
    }
    
    //MARK: - Sample banks
    fileprivate var _currSampleBank:NSManagedObject?
    public var currSampleBank:NSManagedObject? {
        get { return _currSampleBank }
        set {
            _currSampleBank = newValue
            print("XVCDM: currSample is now", currSampleBank?.value(forKey: "position") as Any)
        }
    }
    
    // get track array from the app objects relationship variable "tracks"
    public var sampleBanks:[NSManagedObject?]? {
        
        get {
            
            if (currConfigFile != nil) {
                
                if let sampleBanksSet:NSSet = currConfigFile!.value(forKey: XvSetConstants.kConfigSampleBanks) as? NSSet {
                    
                    //cast as NSManagedObject array
                    if let unsortedSampleBankObjArray:[NSManagedObject] = sampleBanksSet.allObjects as? [NSManagedObject] {
                        
                        //create blank array of nil objects
                        var sortedSampleBankObjArr = [NSManagedObject?](
                            repeating: nil,
                            count: unsortedSampleBankObjArray.count
                        )
                        
                        //go through unsorted object array
                        for unsortedObj in unsortedSampleBankObjArray {
                            
                            //grab position var
                            if let position:Int = unsortedObj.value(forKey: XvSetConstants.kSampleBankPosition) as? Int {
                                
                                //and place content in that position in the sorted array
                                sortedSampleBankObjArr[position] = unsortedObj
                            } else {
                                print("XVCDM: Error getting position from unsorted object during getSampleBanks")
                            }
                            
                        }
                        
                        return sortedSampleBankObjArr
                        
                    } else {
                        print("XVCDM: Error getting sample bank managed object array during getSampleBanks")
                        return nil
                    }
                    
                } else {
                    print("XVCDM: Error getting tracks NSSet during getSampleBanks")
                    return nil
                }
                
            } else {
                
                print("XVCDM: Curr config file is nil when attempting getSampleBanks")
            }
            
            return nil
        }
    }
    
    
    //MARK: - GETTERS -
    
    public func getTrack(forPosition:Int) -> NSManagedObject? {
        
        //get tracks
        if let trackObjs:[NSManagedObject] = tracks as? [NSManagedObject] {
            
            //loop through them
            for trackObj in trackObjs {
                
                //grab the position
                if let position:Int = getInteger(forKey: XvSetConstants.kTrackPosition, forObject: trackObj) {
                    
                    //if it matches the incoming id, return the track data obj
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
    
   
    
    public func getSampleBank(forPosition:Int) -> NSManagedObject? {
        
        //get sample banks
        if let sampleBankObjs:[NSManagedObject] = sampleBanks as? [NSManagedObject] {
            
            //loop through them
            for sampleBankObj in sampleBankObjs {
                
                //grab the position
                if let position:Int = getInteger(forKey: XvSetConstants.kSampleBankPosition, forObject: sampleBankObj) {
                    
                    //if it matches the incoming id, return the track data obj
                    if (position == forPosition) {
                        
                        return sampleBankObj
                    }
                } else {
                    print("XVCDM: Error getting sample bank position during getSampleBank forPosition")
                }
            }
            
            //else return nil
            return nil
            
        } else {
            
            print("XVCDM: Error getting sample banks during getSampleBanks forPosition")
            return nil
        }
    }
   
    
    //MARK: - ACCESSORS
    
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
    
    public func getString(forKey:String, forObject:NSManagedObject) -> String? {
        
        if let str:String = _getValue(forKey: forKey, forObject: forObject) as? String {
            
            return str
            
        } else {
            print("XVCDM: Error getting string for key", forKey)
            return nil
        }
    }
    
    
    // MARK: - SETTERS -

    //MARK: Set key value pairs
    
    public func set(value:Any, forKey:String, forObject:NSManagedObject) {
        
        if (debug){
            
            _printChange(value:value, forKey:forKey, forObject: forObject)
        }
        
        forObject.setValue(value, forKeyPath: forKey)
        
    }

    
    //MARK: - AUDIOBUS
    public func audioBusConnected(){
        
        if let config:NSManagedObject = currConfigFile {
            
            set(value: true, forKey: XvSetConstants.kConfigAbletonLinkEnabled, forObject: config)
            set(value: true, forKey: XvSetConstants.kConfigBackgroundModeEnabled, forObject: config)
            
            //TODO: test
            set(
                value: [XvSetConstants.MIDI_DESTINATION_NONE],
                forKey: XvSetConstants.kConfigGlobalMidiDestinations,
                forObject: config
            )
            
            /*set(
                value: [XvSetConstants.MIDI_SOURCE_NONE],
                forKey: XvSetConstants.kConfigGlobalMidiSources,
                forObject: config
            )*/
            
            if (tracks != nil) {
                
                for track in tracks! {
                    
                    if (track != nil) {
                        
                        set(
                            value: [XvSetConstants.MIDI_DESTINATION_GLOBAL],
                            forKey: XvSetConstants.kTrackMidiDestinations,
                            forObject: track!
                        )
                    } else {
                        
                        print("XVCDM: Error accessing individual track when trying to force set variables for audiobus")
                    }
                }
                
            } else {
                
                print("XVCDM: Error accessing tracks when trying to force set variables for audiobus")
            }
            
            if (save()) {
                print("XVCDM: ABL Link = true | bgMode = true | Global MIDI dest = Omni | Track MIDI destiations = Global.")
            }
            
        } else {
            
            print("XVCDM: Error accessing currConfigFile when trying to force set variables for audiobus")
        }
    }
    
    fileprivate var _audioBusMidiBypass:Bool = false
    public var audioBusMidiBypass:Bool {
        get { return _audioBusMidiBypass }
        set {
            _audioBusMidiBypass = newValue
            
            //if true, fire the above func too
            if (_audioBusMidiBypass) {
                audioBusConnected()
                
                print("XVCDM: Audiobus MIDI bypass = true. MIDI settings are hidden")
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
    
    //MARK: - PRIVATE -
    
    fileprivate func _createNewApp() -> NSManagedObject? {
        
        if let _newApp:NSManagedObject = createNewObject(
            withEntityName: XvSetConstants.kAppEntity
            ) {
            
            if (debug) { print("XVCDM: New app object created") }
            _app = _newApp
            return _app
            
        } else {
            
            print("XVCDM: Error making new app object during _createNewApp")
            return nil
        }
    }
    
    fileprivate func _createNewConfigFile() -> NSManagedObject? {
        
        if let _newConfig:NSManagedObject = createNewObject(
            withEntityName: XvSetConstants.kConfigEntity
            ) {
            
            if (debug) { print("XVCDM: New config object created") }
            return _newConfig
            
        } else {
            
            print("XVCDM: Error making new config object during _createNewConfigFile")
            return nil
        }
    }
    
    
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
                print("XVCDM: Error fetching", fromEntityName, "objects with during getManagedObjectArray")
                return nil
            }
            
            
        } else {
            
            print("XVCDM: Error: Managed context is nil during _getManagedObjectArray")
            return nil
            
        }
        
    }
    
    fileprivate func _printChange(value:Any, forKey:String, forObject:NSManagedObject){
        
        //print all by lifetime tallies (they take up a lot of room in the console)
        if (forKey != XvSetConstants.kTrackLifetimeKeyTallies){
            print("XVCDM: Set", forKey, "to", value)
        }
        
    }
    

    
}
