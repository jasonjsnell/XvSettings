//
//  SetFooter.swift
//  Refraktions
//
//  Created by Jason Snell on 12/14/16.
//  Copyright © 2016 Jason J. Snell. All rights reserved.
//

import UIKit

class SetFooter:UILabel {
    
    //MARK:VARS
    internal var url:String = ""
    
    fileprivate let LEFT_MARGIN:CGFloat = 16
    fileprivate let RIGHT_MARGIN:CGFloat = 12
    fileprivate let TEXT_SIZE:CGFloat = 14
    
    //http://stackoverflow.com/questions/25477547/how-can-i-create-a-hyperlink-with-swift
    
    convenience init(withText:String){
        
        //init first
        self.init(frame:CGRect(
            x: 0, y: 0,
            width: XvSetConstants.PANEL_WIDTH,
            height: 20))
        
        //normal text, set content, color, and size
        numberOfLines = 0
        text = withText
        textColor = UIColor.gray
        font = font.withSize(TEXT_SIZE)
        
    }
    
    convenience init(preText:String, underlinedText:String, postText:String, link:String){
        
        //init first
        self.init(frame:CGRect(
            x: 0, y: 0,
            width: XvSetConstants.PANEL_WIDTH,
            height: 20))
        
        numberOfLines = 0
        
        //save url
        url = link
        
        //set styles
        let normalStyle:[String:Any] = [
            NSFontAttributeName : UIFont.systemFont(ofSize: TEXT_SIZE),
            NSForegroundColorAttributeName : UIColor.gray]

        
        let underlinedStyle:[String:Any] = [
            NSFontAttributeName : UIFont.systemFont(ofSize: TEXT_SIZE),
            NSForegroundColorAttributeName : UIColor.gray,
            NSUnderlineStyleAttributeName : 1]
        
        //construct strings
        let attributedStr:NSMutableAttributedString = NSMutableAttributedString(string:"")
        
        let preStr = NSMutableAttributedString(string: preText, attributes: normalStyle)
        
        let underlinedStr = NSMutableAttributedString(string: underlinedText, attributes: underlinedStyle)
        
        let postStr = NSMutableAttributedString(string: postText, attributes: normalStyle)
        
        //append them into a sentence
        attributedStr.append(preStr)
        attributedStr.append(underlinedStr)
        attributedStr.append(postStr)
        
        //assign to the label
        attributedText = attributedStr
        
    }
    
    
    
    //MARK: TEXT INSET / BUFFER
    //override to create custom buffer on left side of label
    override func drawText(in rect: CGRect) {
        
        let insets:UIEdgeInsets = UIEdgeInsets(
            top: 0,
            left: LEFT_MARGIN,
            bottom: 0,
            right: RIGHT_MARGIN)
        
        super.drawText(in: UIEdgeInsetsInsetRect(rect, insets))
        
    }
    
    //Required overrides
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
