//
//  Labels.swift
//  XvSettings
//
//  Created by Jason Snell on 7/3/17.
//  Copyright © 2017 Jason J. Snell. All rights reserved.
//

import Foundation

//labels are stored in one place so that the copy stays consistent throughout the app

public class Labels {
    
    //MARK: - MIDI
    
    public static let MIDI_SYNC_HEADER:String = "MIDI Sync"
    public static let MIDI_SYNC_LABEL:String = "MIDI sync"
    public static let MIDI_CLOCK_RECEIVE_LABEL:String = "Sync to external MIDI clock"
    public static let MIDI_CLOCK_SEND_LABEL:String = "Send MIDI clock"
    public static let MIDI_CLOCK_NONE_LABEL:String = "None"
    
    public static let MIDI_SEND_HEADER:String = "MIDI Send Channel"
    public static let MIDI_SEND_LABEL:String = "Channel"
    public static let MIDI_DESTINATION_HEADER:String = "MIDI Destinations"
    public static let MIDI_GLOBAL_DESTINATION_HEADER:String = "Global MIDI Destinations"
    public static let MIDI_DESTINATION_LABEL:String = "Destinations"
    public static let MIDI_GLOBAL_DESTINATION_LABEL:String = "MIDI destinations"
    
    public static let MIDI_RECEIVE_HEADER:String = "MIDI Receive Channel"
    public static let MIDI_RECEIVE_LABEL:String = "Channel"
    public static let MIDI_SOURCE_HEADER:String = "Global MIDI Sources"
    public static let MIDI_SOURCE_LABEL:String = "MIDI sources"
    
    //MARK: - SUPPORT
    public static let SUPPORT_HEADER:String = "Support"
    public static let SUPPORT_LABEL:String = "Support"
    
    
    //MARK: - App: Tempo
    public static let TEMPO_LABEL:String = "Tempo"
    
    //MARK: - App: Musical Scale

    public static let MUSICAL_SCALE_ROOT_KEY_LABEL:String = "Root Key"
    
    public static let MUSIC_SCALE_HEADER:String = "Musical Scale"
    public static let MUSIC_SCALE_LABEL:String = "Musical scale"
    public static let MUSIC_SCALE_CUSTOM_HEADER:String = "Custom Musical Scale"
    
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
    public static let MUSIC_SCALE_CUSTOM_LABEL:String = "Custom"
    
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
            MUSIC_SCALE_WHOLE_TONE_LABEL,
            MUSIC_SCALE_CUSTOM_LABEL
        ]
    }
    
    public static func getMusicScaleNotes() -> [String] {
        return ["C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B"]
    }
    
    //MARK: - Track: Kit Selection
    public static let KIT_SELECTION_HEADER:String = "Select a Kit"
    public static let KIT_CUSTOMIZATION_HEADER:String = "Customize"
    
    //MARK: - Track: Sample
    
    public static let TRACK_ACTIVE_HEADER:String = "Track"
    public static let TRACK_ACTIVE_LABEL:String = "Track enabled"
    
    public static let SAMPLE_HEADER:String = "Sample"
    public static let SAMPLE_LABEL:String = "Sample playback"
    
    //MARK: - Track: Composition
    public static let COMPOSITION_HEADER:String = "Composition"
    
    //MARK: - Track: Fade out
    
    public static let AMP_RELEASE_HEADER:String = "Note Duration"
    public static let AMP_RELEASE_LABEL:String = "Note duration"
    
    public static let AMP_RELEASE_MEASURE_8:String = "8 measures"
    public static let AMP_RELEASE_MEASURE_16:String = "16 measures"
    public static let AMP_RELEASE_MEASURE_32:String = "32 measures"
    public static let AMP_RELEASE_MEASURE_64:String = "64 measures"
    
    
    //MARK: - Track: Loop length
    
    public static let PATTERN_LENGTH_HEADER:String = "Pattern Length"
    public static let PATTERN_LENGTH_LABEL:String = "Pattern length"
    
    public static let PATTERN_LENGTH_MEASURE_1:String = "1 measure"
    public static let PATTERN_LENGTH_MEASURE_2:String = "2 measures"
    public static let PATTERN_LENGTH_MEASURE_4:String = "4 measures"
    public static let PATTERN_LENGTH_MEASURE_8:String = "8 measures"
    
    
    //MARK: - Track: Sound
    public static let VOLUME_HEADER:String = "Volume"
    
    public static let VOLUME_LABEL:String = "Volume"
    
    public static let PITCH_HEADER:String = "Pitch"
    public static let PITCH_ENABLED_LABEL:String = "Chromatic Mode"
    public static let TUNE_LABEL:String = "Tune"
    public static let RANDOMIZED_PITCH_LABEL:String = "Randomize pitch on loops"
    
    public static let OCTAVE_CENTER_LABEL:String = "Center Octave"
    public static let OCTAVE_RANGE_LABEL:String = "Octave range"
    
    //MARK: - Track: Quantization
    
    public static let QUANTIZATION_LABEL:String = "Quantization"
    public static let QUANTIZATION_HEADER:String = "Quantization"
    
    public static let QUANTIZATION_1_16:String = "1/16 note"
    public static let QUANTIZATION_1_8:String = "1/8 note"
    public static let QUANTIZATION_1_4:String = "1/4 note"
    public static let QUANTIZATION_1_2:String = "1/2 note"
    public static let QUANTIZATION_1_1:String = "1/1 note"
    
    //MARK: - Track: Regenerate
    public static let REGENERATE_LABEL:String = "Quantize regeneration to pattern"
    
    
}
