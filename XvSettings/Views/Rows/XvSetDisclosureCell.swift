//
//  SettingsDisclosureCell.swift
//  RF Settings
//
//  Created by Jason Snell on 10/22/16.
//  Copyright © 2016 Jason J. Snell. All rights reserved.
//

import UIKit

public class XvSetDisclosureCell: XvSetCell {
    
    public init(
        style: UITableViewCellStyle,
        reuseIdentifier: String?,
        data:XvSetDisclosureCellData
    ){
        
        super.init(style:style, reuseIdentifier:reuseIdentifier, data:data)
    
        self.accessoryType = .disclosureIndicator
        self.selectionStyle = .none
        self.detailTextLabel?.text = data.defaultLabel
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
    }
    
    //updates text back on the disclosure cell display that opened the new table
    public func set(label:String){
        self.detailTextLabel?.text = label
    }
    
    
}

