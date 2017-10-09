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
    
    internal var substituteTextLabels:[String] = [] //used to display a text value instead of an int or float
    
    internal var sliderCell:SliderCell?
    
    //TODO: uncomment if using linked sliders
    //internal var linkedSliderCellData:SliderCellData?
    //internal var linkedSliderCellDataType:String?

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
    
    //MARK: LINKED SLIDERS
    /*
     //TODO: uncomment for linked sliders
    // Setters to allow linked slider cells
    internal func set(linkedSliderCellData:SliderCellData, asType:String) {
        self.linkedSliderCellData = linkedSliderCellData
        self.linkedSliderCellDataType = asType
    }
     */
    
    internal func set(sliderCell:SliderCell) {
        self.sliderCell = sliderCell
    }

    //TODO: uncomment for linked sliders
    /*
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
                let _:Any = setDataValue(withSliderValue: withLinkedSliderValue)
                
                sliderCell!.setSliderPosition(withValue: withLinkedSliderValue)
                sliderCell!.setTextLabel(withString: getTextLabelString())
                
            }
        }
    } */
    
    //MARK: SETTER
    // sets local value var with incoming slider value
    // return the converted value
    internal func setDataValue(withSliderValue: Float) -> Any {
        
        //if local data type is in
        if (dataType == XvSetConstants.DATA_TYPE_INTEGER){
            
            //convert float to int
            let intValue:Int = Utils.getInteger(fromFloat: withSliderValue)
            value = intValue
            
        } else {
            
            //else float is default since slider values are floats
            let floatValueHundredth:Float = Utils.getFloatHundredth(fromFloat: withSliderValue)
            value = floatValueHundredth
        }
    
        return value
    }
    
    //MARK: GETTER
    
    internal func getTextLabelString() -> String {
        
        //if data type in int, and there are substitute text labels
        if (dataType == XvSetConstants.DATA_TYPE_INTEGER && substituteTextLabels.count > 0){
            
            //confirm as int
            if let intValue:Int = Utils.getInteger(fromAny: value) {
                
                //make sure it's within range of array
                if (intValue < substituteTextLabels.count){
                    
                    //return label
                    return substituteTextLabels[intValue]
                    
                } else {
                    
                    print("SETTINGS: Error: Value is out of range when attempting to access substitute text label in SliderCellData")
                    return String(describing: value)
                }

            } else {
                
                print("SETTINGS: Error: Unable to convert value to Int during getTextLabelString in SliderCellData")
            }
            
        }
        
        //else return a string version of the current value
        return String(describing: value)
    
    }
    
    internal func set(substituteTextLabels:[String]){
        
        if (dataType == XvSetConstants.DATA_TYPE_INTEGER) {
            
            let range:Int = Int(valueMax) - Int(valueMin)
            
            if ((substituteTextLabels.count-1) == range){
             
                self.substituteTextLabels = substituteTextLabels
            
            } else {
                print("SETTINGS: Error setting substitute text values on SliderCellData because range between valueMax and valueMin do not match the number in the incoming string array")
            }
            
        } else {
            print("SETTINGS: Error setting substitute text values on SliderCellData because data type is not an integer. Substitute text requires an interger to properly access the array.")
        }
    
    }
    
    
    
    
}

