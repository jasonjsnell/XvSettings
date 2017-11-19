//
//  XvSetConfigFile.swift
//  XvSettings
//
//  Created by Jason Snell on 11/16/17.
//  Copyright © 2017 Jason J. Snell. All rights reserved.
//

/*
 
 This file is used when the app first installs or a user restores the factory settings
 It is an exact duplicate of the variables in the XcDataModel file in this particular app
 If the data model is updated, this file needs to be too
 
 On app first-time installation, this file installs both app and track level vars into Core Data
 Then on app launch, core data values will be loaded into the sequencer system, MIDI, etc...
 
 
 */

import Foundation

//TODO: needed?

open class XvSetConfigFile {
    
    //ref
    public let xvcdm:XvCoreDataManager = XvCoreDataManager.sharedInstance
    
    //these public vars mirror the app level core data objects
    //init with blanks
    //override with real values in config file inside of app
    
    //app
    public var id:String = ""
    public var tourStatus:String = XvSetConstants.TOUR_COMPLETE
    
    //config
    public var abletonLinkEnabled:Bool = false
    public var backgroundMode:Bool = false
    public var globalMidiDestinations:[String] = []
    public var globalMidiSources:[String] = []
    public var midiSync:String = XvSetConstants.MIDI_CLOCK_NONE
    public var musicalScale:String = XvSetConstants.MUSIC_SCALE_MAJOR
    public var musicalScaleRoot:Int = 0
    public var name:String = ""
    public var userTempo:Double = 120.0
    
    public init(){
        
    }
    
}
