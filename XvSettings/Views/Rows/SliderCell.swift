//
//  SliderCell.swift
//  XvSettings
//
//  Created by Jason Snell on 6/22/17.
//  Copyright © 2017 Jason J. Snell. All rights reserved.
//

import UIKit

public class SliderCell: Cell {
    
    //https://stackoverflow.com/questions/35176104/swift-how-to-get-the-value-of-a-slider-in-a-custom-cell-in-a-dynamic-uitablevie
    //create slider, accessible to tableview so listener can be added to detect value changes
    internal let slider:UISlider = UISlider()
    internal var baseText:String = ""
    
    init(
        style: UITableViewCellStyle,
        reuseIdentifier: String?,
        data:SliderCellData){
        
        super.init(style:style, reuseIdentifier:reuseIdentifier, data:data)
        
        let currWidth:CGFloat = self.bounds.width
        
        baseText = data.textLabel
        
        //set text
        textLabel?.text = baseText
        
        // size the slider based on the text
        let sliderWidth:CGFloat = currWidth / 2
        
        slider.frame = CGRect(x: 0, y: 0, width: sliderWidth, height: 25)
        
        slider.minimumValue = data.valueMin
        slider.maximumValue = data.valueMax
        
        //add the slider to the row cell
        self.accessoryView = UIView(frame:slider.frame)
        self.accessoryView?.addSubview(slider)
        self.selectionStyle = .none
        
        //convert slider value to a float
        if let valueAsFloat:Float = Utils.getFloat(fromAny: data.value) {
            
            //init set
            let _:Any? = set(withSliderValue: valueAsFloat)
            
            //set init slider position
            setSliderPosition(withValue:valueAsFloat)
            
        } else {
            
            print("SETTINGS: Error: Unable to cast slider value from Any to Float during SliderCell init")
        }
        
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
    }
    
    
    //user moves handle, table vc handler calls this func
    internal func set(withSliderValue:Float) -> Any? {
        
        if let formattedValue:Any = getFormattedValue(withSliderValue: withSliderValue) {
            
            setTextLabel(withValue: formattedValue)
            
            //if there is a linked slider cell data, update it with same slider value
            if let sliderData:SliderCellData = data as? SliderCellData {
                
                if let linkedSliderCellData:SliderCellData = sliderData.linkedSliderCellData {
                    
                    linkedSliderCellData.set(withLinkedSliderValue: withSliderValue)
                
                }
                
            } else {
                
                print("SETTINGS: Error: Unable to cast slider cell data as SliderCellData type during set withSliderValue")
        
            }
            
            return formattedValue
            
        } else {
            
            print("SETTINGS: Error: Unable to get formatted value from", withSliderValue, "during set withSliderValue")
            return nil
        }
        
        
    }
    
    
    
    //called locally and during linked slider movement
    internal func setTextLabel(withValue:Any) {
        
        textLabel?.text = baseText + ": " + String(describing: withValue)
    }
    
    //called loally and during linked slider movement
    internal func setSliderPosition(withValue:Float) {
        
        slider.value = withValue
    }
    
    internal func getFormattedValue(withSliderValue:Float) -> Any? {
        
        // cast data as slider data
        if let sliderData:SliderCellData = data as? SliderCellData {
            
            //send slider value to data class for formatting
            return sliderData.set(withSliderValue: withSliderValue)
            
        } else {
            print("SETTINGS: Error: Unable to cast slider cell data as SliderCellData type during getFormattedValue")
            return nil
        }
        
    }
    
}

