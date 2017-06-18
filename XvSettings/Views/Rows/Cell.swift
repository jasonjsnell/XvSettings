//
//  SettingsCell.swift
//  RF Settings
//
//  Created by Jason Snell on 10/22/16.
//  Copyright © 2016 Jason J. Snell. All rights reserved.
//

import UIKit

public class Cell: UITableViewCell {
    
    //MARK:VARIABLES
    
    public var data:CellData?
    
    internal let debug:Bool = false
    
    public init(style: UITableViewCellStyle, reuseIdentifier: String?, data:CellData){
        
        super.init(style:style, reuseIdentifier:reuseIdentifier)
        
        self.data = data as CellData
        
        self.textLabel?.text = data.textLabel
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
    }
    
}

