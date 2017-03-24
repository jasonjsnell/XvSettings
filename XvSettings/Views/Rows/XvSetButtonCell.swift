//
//  SetButtonCell.swift
//  Refraktions
//
//  Created by Jason Snell on 12/16/16.
//  Copyright © 2016 Jason J. Snell. All rights reserved.
//

import UIKit

public class XvSetButtonCell: XvSetCell {
    
    fileprivate let APPLE_BLUE:UIColor = UIColor.init(red: 14/255, green: 122/255, blue: 1, alpha: 1)
    
    override public init(style: UITableViewCellStyle, reuseIdentifier: String?, data:XvSetCellData){
        
        super.init(style:style, reuseIdentifier:reuseIdentifier, data:data)
      
        //text is link colored blue
        textLabel?.textColor = APPLE_BLUE
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
    }
    
    
}


