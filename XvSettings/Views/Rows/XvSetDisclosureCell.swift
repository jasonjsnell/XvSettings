//
//  SettingsDisclosureCell.swift
//  RF Settings
//
//  Created by Jason Snell on 10/22/16.
//  Copyright © 2016 Jason J. Snell. All rights reserved.
//

import UIKit

public class XvSetDisclosureCell: XvSetCell {
    
    public init(style: UITableViewCellStyle, reuseIdentifier: String?, data:XvSetDisclosureCellData){
        
        super.init(style:style, reuseIdentifier:reuseIdentifier, data:data)
    
        self.accessoryType = .disclosureIndicator
        self.selectionStyle = .none
        self.detailTextLabel?.text = data.defaultLabel
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
    }
    
    //updates text back on the disclosure cell display that opened the new table
    internal func updateDefaultLabel(){
        self.detailTextLabel?.text = (data as! XvSetDisclosureCellData).defaultLabel
    }
    
    //called by SetMain when programmatically forcing a new default (such as when selected ABL Link and forcing MIDI Sync to none)
    public func forceSetNewDefaultLabel(newIndex: Int){
        
        if (data != nil){
            (data as! XvSetDisclosureCellData).setNewDefault(newIndex: newIndex)
            let lastLabel:String = (data as! XvSetDisclosureCellData).subLabels[newIndex]
            detailTextLabel?.text = lastLabel
        }
    }
    
    
}

