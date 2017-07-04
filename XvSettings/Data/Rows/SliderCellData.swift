//
//  SliderCellData.swift
//  XvSettings
//
//  Created by Jason Snell on 6/22/17.
//  Copyright © 2017 Jason J. Snell. All rights reserved.
//

import Foundation

public class SliderCellData:CellData {
    
    internal var valueMin:Float
    internal var valueMax:Float
    
    internal var sliderCell:SliderCell?
    
    internal var linkedSliderCellData:SliderCellData?
    internal var linkedSliderCellDataType:String?

    internal var dataType:String
    
    //MARK:- INIT
    public init(
        key:String,
        value:Any,
        valueMin:Float,
        valueMax:Float,
        textLabel:String,
        dataType:String,
        levelType:String,
        isVisible:Bool){
        
        self.valueMin = valueMin
        self.valueMax = valueMax
        self.dataType = dataType
        
        super.init(
            key: key,
            value: value,
            textLabel: textLabel,
            displayType: XvSetConstants.DISPLAY_TYPE_SLIDER,
            levelType: levelType,
            isVisible: isVisible
        )
        
    }
    
    //MARK: SETTERS
    // Setters to allow linked slider cells
    internal func set(linkedSliderCellData:SliderCellData, asType:String) {
        self.linkedSliderCellData = linkedSliderCellData
        self.linkedSliderCellDataType = asType
    }
    
    internal func set(sliderCell:SliderCell) {
        self.sliderCell = sliderCell
    }

    internal func set(withLinkedSliderValue:Float) {
        
        if (sliderCell != nil){
            
            //convert *this* data object's value to a float
            let mySliderCurrValue:Float = sliderCell!.slider.value
                
            //if linked slider is listening to max values + linked value is less than local value...
            //or if linked slider is listening to min values + linked value is more than local value...
            if (
                
                (linkedSliderCellDataType == XvSetConstants.LISTENER_MAX && withLinkedSliderValue < mySliderCurrValue)
                    ||
                    (linkedSliderCellDataType == XvSetConstants.LISTENER_MIN && withLinkedSliderValue > mySliderCurrValue)
                
                ){
                
                // set local slider with linked slider value
                let _:Any = set(withSliderValue: withLinkedSliderValue)
                
                if let formattedValue:Any = sliderCell!.getFormattedValue(withSliderValue: withLinkedSliderValue) {
                    
                    sliderCell!.setSliderPosition(withValue: withLinkedSliderValue)
                    sliderCell!.setTextLabel(withValue: formattedValue)
                    
                } else {
                    
                    print("SETTINGS: Error: Unable to get formatted value from", withLinkedSliderValue, "during set withLinkedSliderValue")
                    
                }
                
            }
            
        }
        
        
    }
    
    //MARK: FORMAT
    // converts incoming slider handle data to correct data type
    internal func set(withSliderValue: Float) -> Any {
    
        //check data type and convert incoming float to that
        if (dataType == XvSetConstants.DATA_TYPE_INTEGER){
            
            //convert float to int
            let intValue:Int = Utils.getInteger(fromFloat: withSliderValue)
            value = intValue
            
        } else {
            
            //float is default since slider values are floats
            let floatValueHundredth:Float = Utils.getFloatHundredth(fromFloat: withSliderValue)
            value = floatValueHundredth
        }

        return value
    
    }
    
    //MARK: GETTERS
    
    
}

