//
//  SliderCell.swift
//  XvSettings
//
//  Created by Jason Snell on 6/22/17.
//  Copyright © 2017 Jason J. Snell. All rights reserved.
//

import UIKit

//allows slider to caluclate text width
extension NSAttributedString {
    
    func width(withConstrainedHeight height: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
        
        return boundingBox.width
    }
}

public class SliderCell: Cell {
    
    //https://stackoverflow.com/questions/35176104/swift-how-to-get-the-value-of-a-slider-in-a-custom-cell-in-a-dynamic-uitablevie
    //create slider, accessible to tableview so listener can be added to detect value changes
    internal let slider:UISlider = UISlider()
    internal var baseText:String = ""
    
    override public init(style: UITableViewCellStyle, reuseIdentifier: String?, data:CellData){
        
        super.init(style:style, reuseIdentifier:reuseIdentifier, data:data)
        
        let currWidth:CGFloat = self.bounds.width
        
        //set the toggle based on the data
        //toggleSwitch.isOn = data.value as! Bool
        
        baseText = data.textLabel
        let stringLength:CGFloat = NSAttributedString(string: baseText).width(withConstrainedHeight: 25)
        
       
        
        print("stringLength:", stringLength)
        
        //set text
        textLabel?.text = baseText
        
        // size the slider based on the text
        let sliderWidth:CGFloat = currWidth - stringLength - 50
        
        slider.frame = CGRect(x: 0, y: 0, width: sliderWidth, height: 25)
        
        //add the slider to the row cell
        self.accessoryView = UIView(frame:slider.frame)
        self.accessoryView?.addSubview(slider)
        self.selectionStyle = .none
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
    }
    
    
}

