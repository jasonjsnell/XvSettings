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
    
    public static let MIDI_SEND_HEADER:String = "MIDI Outs"
    public static let MIDI_SEND_LABEL:String = "Channel"
    public static let MIDI_DESTINATION_HEADER:String = "MIDI Destinations"
    public static let MIDI_GLOBAL_DESTINATION_HEADER:String = "Global MIDI Destinations"
    public static let MIDI_DESTINATION_LABEL:String = "Destinations"
    public static let MIDI_GLOBAL_DESTINATION_LABEL:String = "MIDI destinations"
    
    public static let MIDI_RECEIVE_HEADER:String = "MIDI Ins"
    public static let MIDI_RECEIVE_LABEL:String = "Channel"
    public static let MIDI_SOURCE_HEADER:String = "Global MIDI Sources"
    public static let MIDI_SOURCE_LABEL:String = "MIDI sources"
    
    
    //MARK: - App: Tempo
    public static let TEMPO_LABEL:String = "Tempo"
    
    //MARK: - App: Musical Scale

    public static let MUSIC_SCALE_HEADER:String = "Musical Scale"
    public static let MUSIC_SCALE_LABEL:String = "Musical scale"
    
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
            MUSIC_SCALE_WHOLE_TONE_LABEL
        ]
    }
    
    //MARK: - Instrument: Kit Selection
    public static let KIT_SELECTION_HEADER:String = "Select a Kit"
    public static let KIT_CUSTOMIZATION_HEADER:String = "Customize"
    
    
    public static let COMPOSITION_HEADER:String = "Composition"
    
    //MARK: - Instrument: Fade out
    public static let FADE_OUT_LABEL:String = "Loop fades out"
    
    public static let FADE_OUT_DURATION_HEADER:String = "Fade Out"
    public static let FADE_OUT_DURATION_LABEL:String = "Fade out duration"
    
    public static let FADE_OUT_DURATION_MEASURE_8:String = "8 measures"
    public static let FADE_OUT_DURATION_MEASURE_16:String = "16 measures"
    public static let FADE_OUT_DURATION_MEASURE_32:String = "32 measures"
    public static let FADE_OUT_DURATION_MEASURE_64:String = "64 measures"
    
    
    //MARK: - Instrument: Loop length
    
    public static let LOOP_LENGTH_HEADER:String = "Loop Length"
    public static let LOOP_LENGTH_LABEL:String = "Loop length"
    
    public static let LOOP_LENGTH_MEASURE_1:String = "1 measure"
    public static let LOOP_LENGTH_MEASURE_2:String = "2 measures"
    public static let LOOP_LENGTH_MEASURE_4:String = "4 measures"
    public static let LOOP_LENGTH_MEASURE_8:String = "8 measures (full pattern)"
    
    
    //MARK: - Instrument: Sound
    public static let SOUND_HEADER:String = "Sound"
    
    public static let VOLUME_LABEL:String = "Volume"
    public static let PAN_LABEL:String = "Pan"
    public static let PITCH_ENABLED_LABEL:String = "Chromatic Mode"
    public static let TUNE_LABEL:String = "Tune"
    public static let RANDOMIZED_PITCH_LABEL:String = "Randomize pitch on loops"
    
    public static let OCTAVE_CENTER_LABEL:String = "Octave"
    public static let OCTAVE_RANGE_LABEL:String = "Octave range"
    
    //MARK: - Instrument: Quantization
    
    public static let QUANTIZATION_LABEL:String = "Quantization"
    public static let QUANTIZATION_HEADER:String = "Quantization"
    
    public static let QUANTIZATION_1_16:String = "1/16 note"
    public static let QUANTIZATION_1_8:String = "1/8 note"
    public static let QUANTIZATION_1_4:String = "1/4 note"
    public static let QUANTIZATION_1_2:String = "1/2 note"
    public static let QUANTIZATION_1_1:String = "1/1 note"
    
    //MARK: - Instrument: Regenerate
    public static let REGENERATE_LABEL:String = "Regenerate at beginning of loop"
    
    //MARK: - Instrument: Audio enabled
    public static let AUDIO_ENABLED_LABEL:String = "Audio Enabled"
    
}
