//
//
//  Created by Jason Snell on 10/23/16.
//  Copyright © 2016 Jason J. Snell. All rights reserved.
//
// used by defaults manager and settings

/*
 There are active and passive vars
 Passive vars are settings inside of core data that are not stored outside of core data. They are referrred to direct in core data when needed, like bgMode.
 Active vars also live outside of core data and need to be pushed to other parts of the app when updated, like into an track class, or need to change something instantly, like changing the song tempo when changing the tempo slider. These require post notifcations to do an update outside the framework
 
*/

import Foundation

public class XvSetConstants {
    
    //MARK: - Notifications -
    
    //app
    public static let kAppTempoChanged:String = "kAppTempoChanged"
    public static let kAppMusicalScaleChanged:String = "kAppMusicalScaleChanged"
    
    //midi
    public static let kAppMidiSyncChanged:String = "kAppMidiSyncChanged"
    public static let kAppGlobalMidiDestinationsRequest:String = "kAppGlobalMidiDestinationsRequest"
    public static let kAppGlobalMidiDestinationsChanged:String = "kAppGlobalMidiDestinationsChanged"
    public static let kAppGlobalMidiSourcesRequest:String = "kAppGlobalMidiSourcesRequest"
    public static let kAppGlobalMidiSourcesChanged:String = "kAppGlobalMidiSourcesChanged"
    public static let kTrackMidiDestinationsRequest:String = "kTrackMidiDestinationsRequest"
    
    //track data
    public static let kTrackValueChanged:String = "kTrackValueChanged"
    
    
    
    //button commands
    public static let kAppAbletonLinkViewControllerRequested:String = "kAppAbletonLinkViewControllerRequested"
    public static let kAppRearrangeButtonTapped:String = "kAppRearrangeButtonTapped"
    public static let kAppResetAIButtonTapped:String = "kAppResetAIButtonTapped"
    public static let kAppRestoreFactorySettingsButtonTapped:String = "kAppRestoreFactorySettingsButtonTapped"
    
    
    
    //MARK: - Core data keys -
    
    //MARK: App
    public static let kAppEntity:String = "App"
    public static let kAppBackgroundModeEnabled:String = "backgroundModeEnabled" // passive
    public static let kAppAbletonLinkEnabled:String = "abletonLinkEnabled" // passive
    public static let kAppTempo:String = "userTempo" //updates sequencer and ABL Link
    public static let kAppTracks:String = "tracks" //array of track objects
    public static let kAppArtificialIntelligence = "artificialIntelligence" // passive
    public static let kAppFactorySettings = "kAppFactorySettings" // passive
    public static let kAppRearrange = "kAppRearrange" // passive
    
    //MARK: App: MIDI
    public static let kAppGlobalMidiDestinations:String = "globalMidiDestinations" // passive
    public static let kAppGlobalMidiSources:String = "globalMidiSources" // updates MIDI system w/new sources
    public static let kAppMidiSync:String = "midiSync" //updates sequencer and ABL Link
    
    //MIDI sync values
    public static let MIDI_CLOCK_RECEIVE:String = "midiClockReceive"
    public static let MIDI_CLOCK_SEND:String = "midiClockSend"
    public static let MIDI_CLOCK_NONE:String = "midiClockNone"
    
    //MARK: App: Musical Scale
    
    public static let kAppMusicalScale:String = "musicalScale" //updates sequencer
    public static let kAppMusicalScaleRootKey:String = "musicalScaleRootKey" //updates sequencer
    
    public static let MUSIC_SCALE_MAJOR:String = "musicScaleMajor"
    public static let MUSIC_SCALE_MINOR:String = "musicScaleMinor"
    public static let MUSIC_SCALE_DORIAN:String = "musicScaleDorian"
    public static let MUSIC_SCALE_PHRYGIAN:String = "musicScalePhrygian"
    public static let MUSIC_SCALE_LYDIAN:String = "musicScaleLydian"
    public static let MUSIC_SCALE_MIXOLYDIAN:String = "musicScaleMixolydian"
    public static let MUSIC_SCALE_AEOLIAN:String = "musicScaleAeolian"
    public static let MUSIC_SCALE_LOCARIAN:String = "musicScaleLocarian"
    public static let MUSIC_SCALE_MAJOR_BLUES:String = "musicScaleMajorNlues"
    public static let MUSIC_SCALE_MINOR_BLUES:String = "musicScaleMinorNlues"
    public static let MUSIC_SCALE_MAJOR_PENTATONIC:String = "musicScaleMajorPentatonic"
    public static let MUSIC_SCALE_MINOR_PENTATONIC:String = "musicScaleMinorPentatonic"
    public static let MUSIC_SCALE_DIMINISHED:String = "musicScaleDiminished"
    public static let MUSIC_SCALE_CHROMATIC:String = "musicScaleChromatic"
    public static let MUSIC_SCALE_HARMONIC_MINOR:String = "musicScaleHarmonicMinor"
    public static let MUSIC_SCALE_WHOLE_TONE:String = "musicScaleWholeTone"
    
    public static func getMusicScaleValues() -> [String] {
        return [
            MUSIC_SCALE_MAJOR,
            MUSIC_SCALE_MINOR,
            MUSIC_SCALE_DORIAN,
            MUSIC_SCALE_PHRYGIAN,
            MUSIC_SCALE_LYDIAN,
            MUSIC_SCALE_MIXOLYDIAN,
            MUSIC_SCALE_AEOLIAN,
            MUSIC_SCALE_LOCARIAN,
            MUSIC_SCALE_MAJOR_BLUES,
            MUSIC_SCALE_MINOR_BLUES,
            MUSIC_SCALE_MAJOR_PENTATONIC,
            MUSIC_SCALE_MINOR_PENTATONIC,
            MUSIC_SCALE_DIMINISHED,
            MUSIC_SCALE_CHROMATIC,
            MUSIC_SCALE_HARMONIC_MINOR,
            MUSIC_SCALE_WHOLE_TONE
        ]
    }
    
    
    //MARK: App: Tour
    public static let kAppTourStatus:String = "tourStatus"
    public static let TOUR_IN_QUEUE:String = "tourInQueue"
    public static let TOUR_COMPLETE:String = "tourComplete"
    
    //MARK: - Track -
    
    public static let kTrackEntity:String = "Track"
    
 
  
    //all update XvTrack object with same id as core data object
    public static let kTrackAudioEnabled:String = "audioEnabled"
    public static let kTrackAbbreviatedName:String = "abbreviatedName"
    
    public static let kTrackCompositionAttack:String = "compositionAttack"
    public static let kTrackCompositionDecay:String = "compositionDecay"
    public static let kTrackCompositionSustain:String = "compositionSustain"
    public static let kTrackCompositionRelease:String = "compositionRelease"
    
    public static let kTrackDisplayName:String = "displayName"
    public static let kTrackLifetimeKeyTallies = "lifetimeKeyTallies"
    public static let kTrackLoopLength:String = "loopLength"
    public static let kTrackMidiDestinations:String = "trackMidiDestinations"
    public static let kTrackMidiReceiveChannel:String = "midiReceiveChannel"
    public static let kTrackMidiReceiveEnabled:String = "midiReceiveEnabled"
    public static let kTrackMidiSendChannel:String = "midiSendChannel"
    public static let kTrackMidiSendEnabled:String = "midiSendEnabled"
    public static let kTrackOctaveCenter:String = "octaveCenter"
    public static let kTrackOctaveRange:String = "octaveRange"
    public static let kTrackPanRange:String = "panRange"
    public static let kTrackPitchEnabled:String = "pitchEnabled"
    public static let kTrackPosition:String = "position"
    public static let kTrackQuantization:String = "quantization"
    public static let kTrackRandomizedPitch:String = "randomizedPitch"
    public static let kTrackRegenerateAtBeginningOfPattern:String = "regenerateAtBeginningOfPattern"
    public static let kTrackSampleFileNames:String = "sampleFileNames"
    public static let kTrackTune:String = "tune"
    public static let kTrackVisible:String = "visible"
    public static let kTrackVolume:String = "volume"
    public static let kTrackVolumeLock:String = "volumeLock"
    
    public static let MIDI_DESTINATION_GLOBAL:String = "Global"
    public static let MIDI_DESTINATION_OMNI:String = "Omni"
    public static let MIDI_SOURCE_GLOBAL:String = "Global"
    public static let MIDI_SOURCE_OMNI:String = "Omni"


    
    //MARK: - Panel size -
    public static let PANEL_WIDTH:CGFloat = 300
    public static let PANEL_HEIGHT:CGFloat = 400
    
    //MARK: - Data types -
    public static let DATA_TYPE_ARRAY:String = "array"
    public static let DATA_TYPE_BOOL:String = "bool"
    public static let DATA_TYPE_FLOAT:String = "float"
    public static let DATA_TYPE_INTEGER:String = "integer"
    public static let DATA_TYPE_STRING:String = "string"
    public static let DATA_TYPE_NONE:String = "none"
    
    //MARK: - Cell types -
    public static let DISPLAY_TYPE_NONE:String = "displayTypeNone"
    public static let DISPLAY_TYPE_BUTTON:String = "displayTypeButton"
    public static let DISPLAY_TYPE_CHECKMARK:String = "displayTypeCheckmark"
    public static let DISPLAY_TYPE_SWITCH:String = "displayTypeSwitch"
    public static let DISPLAY_TYPE_SLIDER:String = "displayTypeSlider"
    public static let DISPLAY_TYPE_DISCLOSURE:String = "displayTypeDisclosure"
    public static let DISPLAY_TYPE_DISCLOSURE_MULTI:String = "displayTypeDisclosureMulti"
    public static let DISPLAY_TYPE_MULTI_TABLE:String = "displayTypeMultiTable"
    
    //MARK: - Footer types -
    public static let FOOTER_TYPE_NORMAL:String = "footerNormal"
    public static let FOOTER_TYPE_LINK:String = "footerLink"
    public static let FOOTER_TYPE_NONE:String = "footerNone"
    
    //MARK: - Level types -
    public static let LEVEL_TYPE_NONE:String = "levelNone"
    public static let LEVEL_TYPE_APP:String = "levelApp"
    public static let LEVEL_TYPE_TRACK:String = "levelTrack"
    
    //MARK: - Linked slider types -
    public static let LISTENER_MAX:String = "listernerMax"
    public static let LISTENER_MIN:String = "listenerMin"
    

}
