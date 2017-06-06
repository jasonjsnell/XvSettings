//
//  SettingsToggleCell
//  RF Settings
//
//  Created by Jason Snell on 10/22/16.
//  Copyright © 2016 Jason J. Snell. All rights reserved.
//

import UIKit

class XvSetToggleCell: XvSetCell {
    
    //MARK:INIT
    
    //create switch, accessible to tableview so listener can be added to detect value changes
    internal let toggleSwitch:UISwitch = UISwitch()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?, data:XvSetCellData){
        
        super.init(style:style, reuseIdentifier:reuseIdentifier, data:data)
    
        //set the toggle based on the data
        toggleSwitch.isOn = data.value as! Bool
        
        //add the switch to the row cell
        self.accessoryView = UIView(frame:toggleSwitch.frame)
        self.accessoryView?.addSubview(toggleSwitch)
        self.selectionStyle = .none
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
    }
    
   
}

