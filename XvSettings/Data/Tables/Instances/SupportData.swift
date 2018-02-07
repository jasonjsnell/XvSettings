//
//  SupportData.swift
//  XvSettings
//
//  Created by Jason Snell on 2/7/18.
//  Copyright © 2018 Jason J. Snell. All rights reserved.
//

//
//  SetMusicalScaleData
//  Repercussion
//
//  Created by Jason Snell on 6/4/17.
//  Copyright © 2017 Jason J. Snell. All rights reserved.

import CoreData

class SupportData:TableData {
    
    public override func refresh(){
        
        let userManualButton:ButtonCellData = ButtonCellData(
            key: XvSetConstants.kAppUserManual,
            textLabel: "User Manual",
            levelType: XvSetConstants.LEVEL_TYPE_NONE,
            isVisible: true
        )
        
        let userManualSection:SectionData = SectionData(
            header: "User Manual",
            footerType: XvSetConstants.FOOTER_TYPE_NORMAL,
            footerText: ["Information about the app, MIDI, Audiobus, and Ableton Link."],
            footerLink: nil,
            footerHeight: 60,
            cells: [userManualButton],
            isVisible: true
        )
        
        sections.append(userManualSection)
        
        let facebookButton:ButtonCellData = ButtonCellData(
            key: XvSetConstants.kAppFacebookPage,
            textLabel: "Facebook Page",
            levelType: XvSetConstants.LEVEL_TYPE_NONE,
            isVisible: true
        )
        
        let facebookSection:SectionData = SectionData(
            header: "Facebook",
            footerType: XvSetConstants.FOOTER_TYPE_NORMAL,
            footerText: ["Videos on new releases and real-world examples, including music and film sequencing."],
            footerLink: nil,
            footerHeight: 60,
            cells: [facebookButton],
            isVisible: true
        )
        
        sections.append(facebookSection)
        
        
        let emailDeveloperButton:ButtonCellData = ButtonCellData(
            key: XvSetConstants.kAppEmailDeveloper,
            textLabel: "Email Developer",
            levelType: XvSetConstants.LEVEL_TYPE_NONE,
            isVisible: true
        )
        
        let emailDeveloperSection:SectionData = SectionData(
            header: "Email",
            footerType: XvSetConstants.FOOTER_TYPE_NORMAL,
            footerText: ["Please email if you are experiencing any bugs, have feature requests, or any support questions."],
            footerLink: nil,
            footerHeight: 60,
            cells: [emailDeveloperButton],
            isVisible: true
        )
        
        sections.append(emailDeveloperSection)
        
        
        let donationButton:ButtonCellData = ButtonCellData(
            key: XvSetConstants.kAppDonation,
            textLabel: "Donate",
            levelType: XvSetConstants.LEVEL_TYPE_NONE,
            isVisible: true
        )
        
        let donationSection:SectionData = SectionData(
            header: "Donate",
            footerType: XvSetConstants.FOOTER_TYPE_NORMAL,
            footerText: ["Tap to make a donation to this app's research and development."],
            footerLink: nil,
            footerHeight: 60,
            cells: [donationButton],
            isVisible: true
        )
        
        sections.append(donationSection)
        
        
       
        
        
        
    }
}



