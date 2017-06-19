//
//
//  Created by Jason Snell on 10/23/16.
//  Copyright © 2016 Jason J. Snell. All rights reserved.
//
// used by defaults manager and settings

import Foundation

public class XvSetConstants {
    
    //MARK: - Core data keys -
    
    //MARK: App
    public static let kAppEntity:String = "App"
    public static let kAppBackgroundModeEnabled:String = "backgroundModeEnabled"
    public static let kAppTempo:String = "userTempo"
    public static let kAppAbletonLinkEnabled:String = "abletonLinkEnabled"
    
    //MARK: App: MIDI Sync
    public static let kAppMidiSync:String = "midiSync"
   
    public static let MIDI_CLOCK_RECEIVE:String = "midiClockReceive"
    public static let MIDI_CLOCK_SEND:String = "midiClockSend"
    public static let MIDI_CLOCK_NONE:String = "midiClockNone"
    
    public static let MIDI_SYNC_LABEL:String = "MIDI Sync"
    public static let MIDI_CLOCK_RECEIVE_LABEL:String = "Sync to External MIDI Clock"
    public static let MIDI_CLOCK_SEND_LABEL:String = "Send MIDI Clock"
    public static let MIDI_CLOCK_NONE_LABEL:String = "None"
    
    //MARK: App: Musical Scale
    public static let kMusicalScale:String = "musicalScale"
    
    public static let MUSIC_SCALE_LABEL:String = "Musical Scale"
    
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
    
    public static let MUSIC_SCALE_MAJOR_LABEL:String = "Major"
    public static let MUSIC_SCALE_MINOR_LABEL:String = "Minor"
    public static let MUSIC_SCALE_DORIAN_LABEL:String = "Dorian"
    public static let MUSIC_SCALE_PHRYGIAN_LABEL:String = "Phrygian"
    public static let MUSIC_SCALE_LYDIAN_LABEL:String = "Lydian"
    public static let MUSIC_SCALE_MIXOLYDIAN_LABEL:String = "Mixolydian"
    public static let MUSIC_SCALE_AEOLIAN_LABEL:String = "Aeolian"
    public static let MUSIC_SCALE_LOCARIAN_LABEL:String = "Locarian"
    public static let MUSIC_SCALE_MAJOR_BLUES_LABEL:String = "Major Blues"
    public static let MUSIC_SCALE_MINOR_BLUES_LABEL:String = "Minor Blues"
    public static let MUSIC_SCALE_MAJOR_PENTATONIC_LABEL:String = "Major Pentatonic"
    public static let MUSIC_SCALE_MINOR_PENTATONIC_LABEL:String = "Minor Pentatonic"
    public static let MUSIC_SCALE_DIMINISHED_LABEL:String = "Diminished"
    public static let MUSIC_SCALE_CHROMATIC_LABEL:String = "Chromatic"
    public static let MUSIC_SCALE_HARMONIC_MINOR_LABEL:String = "Harmonic Minor"
    public static let MUSIC_SCALE_WHOLE_TONE_LABEL:String = "Whole Tone"
    
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
    
    public static func getMusicScaleLabels() -> [String] {
        return [
            MUSIC_SCALE_MAJOR_LABEL,
            MUSIC_SCALE_MINOR_LABEL,
            MUSIC_SCALE_DORIAN_LABEL,
            MUSIC_SCALE_PHRYGIAN_LABEL,
            MUSIC_SCALE_LYDIAN_LABEL,
            MUSIC_SCALE_MIXOLYDIAN_LABEL,
            MUSIC_SCALE_AEOLIAN_LABEL,
            MUSIC_SCALE_LOCARIAN_LABEL,
            MUSIC_SCALE_MAJOR_BLUES_LABEL,
            MUSIC_SCALE_MINOR_BLUES_LABEL,
            MUSIC_SCALE_MAJOR_PENTATONIC_LABEL,
            MUSIC_SCALE_MINOR_PENTATONIC_LABEL,
            MUSIC_SCALE_DIMINISHED_LABEL,
            MUSIC_SCALE_CHROMATIC_LABEL,
            MUSIC_SCALE_HARMONIC_MINOR_LABEL,
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
    
    //MARK: - Instrument -
    public static let kInstrumentEntity:String = "Instrument"
    public static let kInstrumentID:String = "id"
    public static let kInstrumentName:String = "name"
    public static let kInstrumentAudioEnabled:String = "audioEnabled"
    public static let kInstrumentKit:String = "kit"
    public static let kInstrumentLifetimeKeyTallies = "lifetimeKeyTallies"
    public static let kInstrumentLoopLength:String = "loopLength"
    public static let kInstrumentMeasuresUntilFadeOut:String = "measuresUntilFadeOut"
    public static let kInstrumentMidiDestinations:String = "midiDestinations"
    public static let kInstrumentMidiReceiveChannel:String = "midiReceiveChannel"
    public static let kInstrumentMidiReceiveEnabled:String = "midiReceiveEnabled"
    public static let kInstrumentMidiSendChannel:String = "midiSendChannel"
    public static let kInstrumentMidiSendEnabled:String = "midiSendEnabled"
    public static let kInstrumentMidiSources:String = "midiSources"
    public static let kInstrumentPitchEnabled:String = "pitchEnabled"
    public static let kInstrumentPosition:String = "position"
    public static let kInstrumentQuantization:String = "quantization"
    public static let kInstrumentRandomizedPitch:String = "randomizedPitch"
    public static let kInstrumentRegenerateAtBeginningOfPattern:String = "regenerateAtBeginningOfPattern"
    public static let kInstrumentVolume:String = "volume"
    public static let kInstrumentVolumeLock:String = "volumeLock"
  

    
    //MARK: - Notifications -
    public static let kSettingsPanelAttributeChanged:String = "kSettingsPanelAttributeChanged"
    public static let kSettingsPanelKitAttributeChanged:String = "kSettingsPanelKitAttributeChanged"
    public static let kSettingsPanelInstrumentAttributeChanged:String = "kSettingsPanelInstrumentAttributeChanged"
    
    public static let kAppAbletonLinkViewControllerRequested:String = "kAppAbletonLinkViewControllerRequested"
    public static let kKitResetAIButtonTapped:String = "kKitResetAIButtonTapped"
    public static let kKitRestoreFactorySettingsButtonTapped:String = "kKitRestoreFactorySettingsButtonTapped"
    
    
    //MARK: - Panel size -
    public static let PANEL_WIDTH:CGFloat = 300
    public static let PANEL_HEIGHT:CGFloat = 400
    
    //MARK: - Data types -
    public static let DATA_TYPE_BOOL:String = "bool"
    public static let DATA_TYPE_STRING:String = "string"
    public static let DATA_TYPE_INTEGER:String = "integer"
    public static let DATA_TYPE_ARRAY:String = "array"
    public static let DATA_TYPE_NONE:String = "none"
    
    //MARK: - Cell types -
    public static let DISPLAY_TYPE_NONE:String = "displayTypeNone"
    public static let DISPLAY_TYPE_BUTTON:String = "displayTypeButton"
    public static let DISPLAY_TYPE_CHECKMARK:String = "displayTypeCheckmark"
    public static let DISPLAY_TYPE_SWITCH:String = "displayTypeSwitch"
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

}
