//
//  SettingsDisclosureCell.swift
//  RF Settings
//
//  Created by Jason Snell on 10/22/16.
//  Copyright © 2016 Jason J. Snell. All rights reserved.
//

import UIKit

class DisclosureCell: Cell {
    
    init(
        style: UITableViewCellStyle,
        reuseIdentifier: String?,
        data:DisclosureCellData
    ){
        
        super.init(style:style, reuseIdentifier:reuseIdentifier, data:data)
    
        self.accessoryType = .disclosureIndicator
        self.selectionStyle = .none
        self.detailTextLabel?.text = data.detailTextLabel
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
    }
    
    //updates text back on the disclosure cell display that opened the new table
    public func set(label:String){
        self.detailTextLabel?.text = label
    }
    
    
}

