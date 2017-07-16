//
//
//  Created by Jason Snell on 10/23/16.
//  Copyright © 2016 Jason J. Snell. All rights reserved.
//
// used by defaults manager and settings

/*
 There are active and passive vars
 Passive vars are settings inside of core data that are not stored outside of core data. They are referrred to direct in core data when needed, like bgMode.
 Active vars also live outside of core data and need to be pushed to other parts of the app when updated, like into an instrument class, or need to change something instantly, like changing the song tempo when changing the tempo slider. These require post notifcations to do an update outside the framework
 
*/

import Foundation

public class XvSetConstants {
    
    //MARK: - Notifications -
    public static let kAppTempoChanged:String = "kAppTempoChanged"
    
    //midi
    public static let kAppMidiSyncChanged:String = "kAppMidiSyncChanged"
    public static let kAppGlobalMidiDestinationsRequest:String = "kAppGlobalMidiDestinationsRequest"
    public static let kAppGlobalMidiSourcesRequest:String = "kAppGlobalMidiSourcesRequest"
    public static let kAppGlobalMidiSourcesChanged:String = "kAppGlobalMidiSourcesChanged"
    public static let kInstrumentMidiDestinationsRequest:String = "kInstrumentMidiDestinationsRequest"
    
    //instrument data
    public static let kInstrumentValueChanged:String = "kInstrumentValueChanged"
    
    //button commands
    public static let kAppAbletonLinkViewControllerRequested:String = "kAppAbletonLinkViewControllerRequested"
    public static let kKitResetAIButtonTapped:String = "kKitResetAIButtonTapped"
    public static let kKitRestoreFactorySettingsButtonTapped:String = "kKitRestoreFactorySettingsButtonTapped"
    public static let kKitRearrangeButtonTapped:String = "kKitRearrangeButtonTapped"
    
    
    //MARK: - Core data keys -
    
    //MARK: App
    public static let kAppEntity:String = "App"
    
    public static let kAppBackgroundModeEnabled:String = "backgroundModeEnabled" // passive
    public static let kAppAbletonLinkEnabled:String = "abletonLinkEnabled" // passive
    public static let kAppTempo:String = "userTempo" //updates sequencer and ABL Link

    
    
    //MARK: App: MIDI
    public static let kAppGlobalMidiDestinations:String = "globalMidiDestinations" // passive
    public static let kAppGlobalMidiSources:String = "globalMidiSources" // updates MIDI system w/new sources
    
    public static let kAppMidiSync:String = "midiSync" //updates sequencer and ABL Link
    
    //MIDI sync values
    public static let MIDI_CLOCK_RECEIVE:String = "midiClockReceive"
    public static let MIDI_CLOCK_SEND:String = "midiClockSend"
    public static let MIDI_CLOCK_NONE:String = "midiClockNone"
    
    //MARK: App: Musical Scale
    
    public static let kMusicalScale:String = "musicalScale"
    
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
    
    //MARK: - Kit -
    public static let kKitEntity:String = "Kit"
    public static let kKitID:String = "id"
    public static let kKitName:String = "name"
    public static let kSelectedKit:String = "selectedKit"
    public static let kKitInstruments:String = "instruments"
    public static let kKitArtificialIntelligence = "artificialIntelligence"
    public static let kKitFactorySettings = "kKitFactorySettings"
    public static let kKitRearrange = "kKitRearrange"
    
    //MARK: - Instrument -
    
    public static let kInstrumentEntity:String = "Instrument"
    public static let kInstrumentID:String = "id"
    public static let kInstrumentName:String = "name"
    
    //all update XvInstrument object with same id as core data object
    public static let kInstrumentAudioEnabled:String = "audioEnabled"
    public static let kInstrumentKit:String = "kit"
    public static let kInstrumentLifetimeKeyTallies = "lifetimeKeyTallies"
    public static let kInstrumentLoopLength:String = "loopLength"
    public static let kInstrumentFadeOut:String = "fadeOut"
    public static let kInstrumentFadeOutDuration:String = "fadeOutDuration"
    public static let kInstrumentMidiDestinations:String = "instrumentMidiDestinations"
    public static let kInstrumentMidiReceiveChannel:String = "midiReceiveChannel"
    public static let kInstrumentMidiReceiveEnabled:String = "midiReceiveEnabled"
    public static let kInstrumentMidiSendChannel:String = "midiSendChannel"
    public static let kInstrumentMidiSendEnabled:String = "midiSendEnabled"
    public static let kInstrumentMidiSources:String = "instrumentMidiSources"
    public static let kInstrumentOctaveLowest:String = "octaveLowest"
    public static let kInstrumentOctaveHighest:String = "octaveHighest"
    public static let kInstrumentPan:String = "pan"
    public static let kInstrumentPitchEnabled:String = "pitchEnabled"
    public static let kInstrumentPosition:String = "position"
    public static let kInstrumentQuantization:String = "quantization"
    public static let kInstrumentRandomizedPitch:String = "randomizedPitch"
    public static let kInstrumentRegenerateAtBeginningOfPattern:String = "regenerateAtBeginningOfPattern"
    public static let kInstrumentVolume:String = "volume"
    
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
    public static let LEVEL_TYPE_KIT:String = "levelKit"
    public static let LEVEL_TYPE_INSTRUMENT:String = "levelInstrument"
    
    //MARK: - Linked slider types -
    public static let LISTENER_MAX:String = "listernerMax"
    public static let LISTENER_MIN:String = "listenerMin"
    

}
