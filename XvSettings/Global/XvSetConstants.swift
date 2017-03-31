//
//
//  Created by Jason Snell on 10/23/16.
//  Copyright © 2016 Jason J. Snell. All rights reserved.
//
// used by defaults manager and settings

import Foundation

public class XvSetConstants {
    
    //notifications
    public static let kSettingsPanelDefaultChanged:String = "kSettingsPanelDefaultChanged"
    
    //panel size
    public static let PANEL_WIDTH:CGFloat = 300
    public static let PANEL_HEIGHT:CGFloat = 400
    
    //data types
    public static let TYPE_BOOL:String = "bool"
    public static let TYPE_STRING:String = "string"
    public static let TYPE_INTEGER:String = "integer"
    public static let TYPE_ARRAY:String = "array"
    public static let TYPE_NONE:String = "none"
    
    //cells types
    public static let DISPLAY_TYPE_BUTTON:String = "displayTypeButton"
    public static let DISPLAY_TYPE_SWITCH:String = "displayTypeSwitch"
    public static let DISPLAY_TYPE_DISCLOSURE:String = "displayTypeDisclosure"
    public static let DISPLAY_TYPE_DISCLOSURE_MULTI:String = "displayTypeDisclosureMulti"
    public static let DISPLAY_TYPE_CHECKMARK:String = "displayTypeCheckmark"
    public static let DISPLAY_TYPE_NONE:String = "displayTypeNone"
    
    //footer types
    public static let FOOTER_TYPE_NORMAL:String = "footerNormal"
    public static let FOOTER_TYPE_LINK:String = "footerLink"
    public static let FOOTER_TYPE_NONE:String = "footerNone"

}
