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
    
    public static let kSettingsValueChanged:String = "kSettingsValueChanged"
    public static let kConfigTempoChanged:String = "kConfigTempoChanged"
    
    //general app
    public static let kAppSupport:String = "kAppSupport"
    public static let kAppDonation:String = "kAppDonation"
    
    //midi
    public static let kConfigGlobalMidiDestinationsRequest:String = "kConfigGlobalMidiDestinationsRequest"
    public static let kConfigGlobalMidiDestinationsChanged:String = "kConfigGlobalMidiDestinationsChanged"
    public static let kConfigGlobalMidiSourcesRequest:String = "kConfigGlobalMidiSourcesRequest"
    public static let kConfigGlobalMidiSourcesChanged:String = "kConfigGlobalMidiSourcesChanged"
    public static let kTrackMidiDestinationsRequest:String = "kTrackMidiDestinationsRequest"
    
    
    //MARK: - BUTTONS -
    
    //MARK: Buttons: General app
    
    public static let kAppEmailDeveloper:String = "kAppEmailDeveloper"
    public static let kAppFacebookPage:String = "kAppFacebookPage"
    public static let kAppUserManual:String = "kAppUserManual"
    public static let kAppDonationButtonTapped:String = "kAppDonationButtonTapped"
    
    
    //MARK: Buttons: Config
    public static let kConfigArtificialIntelligence:String = "artificialIntelligence" // passive
    public static let kConfigRearrange:String = "kAppRearrange" // passive
    
    //MARK: Buttons: Tracks
    public static let kTracksFactorySettings = "kAppFactorySettings" // passive
    
    //MARK: - Buttons Actions: Config
    public static let kConfigAbletonLinkViewControllerRequested:String = "kAppAbletonLinkViewControllerRequested"
    public static let kConfigRearrangeButtonTapped:String = "kAppRearrangeButtonTapped"
    public static let kConfigResetAIButtonTapped:String = "kAppResetAIButtonTapped"
    
    //MARK: Buttons Actions: Tracks
    public static let kTracksRestoreFactorySettingsButtonTapped:String = "kAppRestoreFactorySettingsButtonTapped"
    
    
    
    
    
    //MARK: - CORE DATA KEYS -
    
    //MARK: APP -
    public static let kAppEntity:String = "App"
    public static let kAppId:String = "id" //passive
    
    //MARK: App: Tour
    public static let kAppTourStatus:String = "tourStatus"
    public static let TOUR_IN_QUEUE:String = "tourInQueue"
    public static let TOUR_COMPLETE:String = "tourComplete"
    
    public static let kAppConfigFiles = "configFiles" //array of config files in the app object
    
    //MARK: - CONFIG FILES  -
    
    public static let kConfigEntity:String = "ConfigFile"
    
    public static let kConfigAbletonLinkEnabled:String = "abletonLinkEnabled" // passive
    
    public static let kConfigBackgroundModeEnabled:String = "backgroundModeEnabled" // passive
    public static let kConfigCreatedAtPosition:String = "createdAtPosition"
    public static let kConfigName:String = "name"
    public static let kConfigTempo:String = "userTempo" //pushed to sequencer and ABL Link
    
    //MARK: Config: MIDI
    public static let kConfigGlobalMidiDestinations:String = "globalMidiDestinations" // passive
    public static let kConfigGlobalMidiSources:String = "globalMidiSources" // pushed to MIDI system w/new sources
    public static let kConfigMidiSync:String = "midiSync" //pushed to sequencer and ABL Link
    
    //MIDI sync values
    public static let MIDI_CLOCK_RECEIVE:String = "midiClockReceive"
    public static let MIDI_CLOCK_SEND:String = "midiClockSend"
    public static let MIDI_CLOCK_NONE:String = "midiClockNone"
    
    //MARK: App: Musical Scale
    
    public static let kConfigMusicalScale:String = "musicalScale" //updates sequencer
    public static let kConfigMusicalScaleRootKey:String = "musicalScaleRootKey" //updates sequencer
    public static let kConfigMusicalScaleCustom:String = "musicalScaleCustom" //updates sequencer
    
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
    
    public static let MUSIC_SCALE_CUSTOM:String = "musicScaleCustom"
    
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
            MUSIC_SCALE_WHOLE_TONE,
            MUSIC_SCALE_CUSTOM
        ]
    }
    
    public static func getMusicScaleNoteValues() -> [Int] {
        return [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]
    }
    
    //references to other core data objects stored in config
    public static let kConfigApp:String = "app"
    public static let kConfigSampleBanks:String = "sampleBanks" //array of samples in the config file
    public static let kConfigTracks:String = "tracks" //array of tracks in the config file
    
    //MARK: - TRACK -
    
    public static let kTrackEntity:String = "Track"

    //all update XvTrack object with same id as core data object
    public static let kTrackActive:String = "active"
    
    public static let kTrackCompositionAttack:String = "compositionAttack"
    public static let kTrackCompositionDecay:String = "compositionDecay"
    public static let kTrackCompositionSustain:String = "compositionSustain"
    public static let kTrackCompositionRelease:String = "compositionRelease"
    public static let kTrackConfigFile:String = "configFile" //ref to containting core data object
    public static let kTrackLifetimeKeyTallies = "lifetimeKeyTallies"
    public static let kTrackPatternLength:String = "patternLength"
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
    public static let kTrackTune:String = "tune"
    public static let kTrackVolume:String = "volume"
    public static let kTrackVolumeLock:String = "volumeLock"
    
    public static let MIDI_DESTINATION_GLOBAL:String = "Global"
    public static let MIDI_DESTINATION_OMNI:String = "Omni"
    public static let MIDI_DESTINATION_NONE:String = "None"
    public static let MIDI_SOURCE_GLOBAL:String = "Global"
    public static let MIDI_SOURCE_OMNI:String = "Omni"
    public static let MIDI_SOURCE_NONE:String = "None"
    
    
    

    //MARK: - SAMPLE BANKS-
    
    public static let kSampleBankEntity:String = "SampleBank"
    public static let kSampleBankActive:String = "active"
    public static let kSampleBankAbbreviatedName:String = "abbreviatedName"
    public static let kSampleBankConfigFile:String = "configFile" //ref to containting core data object
    public static let kSampleBankDisplayName:String = "displayName"
    public static let kSampleBankFileNames:String = "fileNames"
    public static let kSampleBankPosition:String = "position"

    
    //MARK: - Panel size -
    public static let PANEL_WIDTH:CGFloat = 320
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
    public static let LEVEL_TYPE_CONFIG:String = "levelConfig"
    public static let LEVEL_TYPE_TRACK:String = "levelTrack"
    public static let LEVEL_TYPE_SAMPLE:String = "levelSample"
    
    //MARK: - Linked slider types -
    public static let LISTENER_MAX:String = "listernerMax"
    public static let LISTENER_MIN:String = "listenerMin"
    

}
