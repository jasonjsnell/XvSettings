//
//  SettingsDisclosureCell.swift
//  RF Settings
//
//  Created by Jason Snell on 10/22/16.
//  Copyright © 2016 Jason J. Snell. All rights reserved.
//

import UIKit

public class XvSetDisclosureMultiCell: XvSetDisclosureCell {
    
    public init(style: UITableViewCellStyle, reuseIdentifier: String?, data:XvSetDisclosureMultiCellData){
        
        super.init(style:style, reuseIdentifier:reuseIdentifier, data:data)
        
        self.accessoryType = .disclosureIndicator
        self.selectionStyle = .none
        self.detailTextLabel?.text = data.defaultLabel
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
    }
    
}

