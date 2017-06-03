//
//  SettingsTableViewController.swift
//  RF Settings
//
//  Created by Jason Snell on 8/30/16.
//  Copyright © 2016 Jason J. Snell. All rights reserved.
//

// a table of sections. Sections can have any kind of cells (button, checkmark, disclosure, toggle)

import UIKit

open class XvSetMultiTable: XvSetTable {
    
    //multi table data
    public var dataSource:XvSetMultiData?
    
    //MARK:- VARS
    internal var sectionFooterViews:[SetFooter?]?
    
    //MARK: - OPEN API
    //MARK:   BUILD -
    
    override open func viewDidLoad() {
        
        super.viewDidLoad()
        
        buildFooters()
        
    }
    
    //MARK: - SECTIONS
    // number of section(s)
    override open func numberOfSections(in tableView: UITableView) -> Int {
        
        if (dataSource != nil){
            return dataSource!.sections.count
        } else {
            print("SETTINGS: Error connecting to data source for SetMultiTable numberOfSections")
            return 0
        }
        
    }
    
    //MARK:- ROWS -
    //number of rows in each section
    override open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if (dataSource != nil){
            
            //if section is visible...
            if (dataSource!.sections[section].isVisible){
                
                //return total from data
                return dataSource!.sections[section].cells.count
                
            } else {
                
                //else 0 rows
                return 0
            }
            
        } else {
            print("SETTINGS: Error connecting to data source for SetMultiTable numberOfRowsInSection")
            return 0
        }
        
    }
    
    //height of rows in each section
    override open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        if (dataSource != nil){
            
            //if section is visible...
            if (dataSource!.sections[indexPath.section].isVisible) {
                
                //return default
                return UITableViewAutomaticDimension
                
            } else {
                
                //else a 0 height
                return 1
            }
            
        } else {
            print("SETTINGS: Error connecting to data source for SetMultiTable heightForRowAt")
            return 1
        }
        
    }
    
    override open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (dataSource != nil){
            
            //get cell data
            let cellDataObj:XvSetCellData = dataSource!.sections[indexPath.section].cells[indexPath.row]
            
            //set the index path into the object so it can be referred to later
            //example: toggle switch requires it to set isSectionVisible bool in data class
            cellDataObj.indexPath = indexPath
            
            
            if (cellDataObj.displayType == XvSetConstants.DISPLAY_TYPE_SWITCH){
                
                //create toggle cell
                let toggleCell:XvSetToggleCell = XvSetToggleCell(
                    style: .default,
                    reuseIdentifier: cellDataObj.key,
                    data: cellDataObj)
                
                //add listener
                toggleCell.toggleSwitch.addTarget(
                    self,
                    action: #selector(toggleSwitchChanged),
                    for: UIControlEvents.valueChanged)
                
                //return object
                return toggleCell
                
            } else if (cellDataObj.displayType == XvSetConstants.DISPLAY_TYPE_BUTTON){
                
                return XvSetButtonCell(
                    style: .default,
                    reuseIdentifier: cellDataObj.key,
                    data: cellDataObj)
                
                
            } else if (cellDataObj.displayType == XvSetConstants.DISPLAY_TYPE_CHECKMARK){
                
                return XvSetCheckmarkCell(
                    style: .default,
                    reuseIdentifier: cellDataObj.key,
                    data: cellDataObj as! XvSetCheckmarkCellData)
                                
                
            } else if (cellDataObj.displayType == XvSetConstants.DISPLAY_TYPE_DISCLOSURE){
                
                //disclosure - leads to subview
                
                return XvSetDisclosureCell(
                    style: .value1,
                    reuseIdentifier: cellDataObj.key,
                    data: cellDataObj as! XvSetDisclosureCellData)
                
                
            } else if (cellDataObj.displayType == XvSetConstants.DISPLAY_TYPE_DISCLOSURE_MULTI){
                
                //disclosure multi - leads to subview where multi items can be selected
                
                return XvSetDisclosureMultiCell(
                    style: .value1,
                    reuseIdentifier: cellDataObj.key,
                    data: cellDataObj as! XvSetDisclosureMultiCellData)
                
                //else error, return empty cell
            } else {
                print("SETTINGS: Error determining cell display type")
                return UITableViewCell()
            }
            
        } else {
            print("SETTINGS: Error connecting to data source for SetMultiTable cellRowAt")
            return UITableViewCell()
        }
        
    }
    
    //MARK:- HEADERS
    //title text and their heights in each section
    override open func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if (dataSource != nil){
            
            //if section is visible...
            if (dataSource!.sections[section].isVisible){
                
                //return title from data
                return dataSource!.sections[section].header
                
            } else {
                
                //else none
                return nil
                
            }
            
        } else {
            print("SETTINGS: Error connecting to data source for SetMultiTable titleForHeaderInSection")
            return nil
        }
        
    }
    
    //title height
    override open func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if (dataSource != nil){
            
            //if section is visible...
            if (dataSource!.sections[section].isVisible){
                
                //return default
                return UITableViewAutomaticDimension
                
            } else {
                
                //return height of 1
                return 1
                
            }
            
        } else {
            print("SETTINGS: Error connecting to data source for SetMultiTable heightForHeaderInSection")
            return 1
        }
        
    }
    
    //MARK:- FOOTERS
    //footer views and their heights in each section
    override open func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        if (dataSource != nil){
            
            //if section is visible...
            if (dataSource!.sections[section].isVisible) {
                
                //else return footer object
                return sectionFooterViews![section]
                
            } else {
                
                //... return no footer object
                return nil
                
            }
            
        } else {
            print("SETTINGS: Error connecting to data source for SetMultiTable viewForFooterInSection")
            return nil
        }
        
        
    }
    
    override open func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        if (dataSource != nil){
            
            //if section is visible...
            if (dataSource!.sections[section].isVisible){
                
                //return height from data
                return dataSource!.sections[section].footerHeight
                
            } else {
                
                //return footer height of 1
                return 1
                
            }
            
        } else {
            print("SETTINGS: Error connecting to data source for SetMultiTable heightForFooterInSection")
            return 1
        }
        
    }

    //MARK: - OPEN API
    //MARK:   USER INPUT -
    
    //MARK: ROWS
    
    //called by SetMain
    
    // when user selects a row, do the error checking then call the more usable rowSelected funcs that are specific to each row type (a disclosure cell, a checkmark cell, a button cell, etc...)
    
    override open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //is data valid?
        if (dataSource != nil){
            
            let displayType:String = getDisplayType(dataSource:dataSource!, indexPath:indexPath)
            
            if (displayType == XvSetConstants.DISPLAY_TYPE_DISCLOSURE){
                
                //MARK: Disclosure cells
                
                if let cell:XvSetDisclosureCell = getDisclosureCell(indexPath: indexPath){
                    
                    //get the key
                    if let key:String = getKey(fromCell: cell) {
                        
                        disclosureRowSelected(cell: cell, key: key)
                        
                    } else {
                        print("SETTINGS: Disclosure cell data key could not be found")
                    }
                    
                    
                } else {
                    print("SETTINGS: This index does not have a valid disclosure cell")
                }
                
            } else if (displayType == XvSetConstants.DISPLAY_TYPE_DISCLOSURE_MULTI){
                
                //MARK: Disclosure multi cells
                
                if let cell:XvSetDisclosureMultiCell = getDisclosureMultiCell(indexPath: indexPath){
                    
                    if let key:String = getKey(fromCell: cell) {
                        
                        multiDisclosureRowSelected(cell: cell, key: key)
                        
                    } else {
                        print("SETTINGS: Multi disclosure cell data key could not be found")
                    }
                    
                } else {
                    print("SETTINGS: This index does not have a valid multi disclosure cell")
                }
                
            } else if (displayType == XvSetConstants.DISPLAY_TYPE_CHECKMARK){
                
                //MARK: Checkmark cells
                
                if let cell:XvSetCheckmarkCell = getCheckmarkCell(indexPath: indexPath) {
                    
                    if let key:String = getKey(fromCell: cell) {
                        
                        //deselect row so the grey background flashes
                        tableView.deselectRow(at: indexPath, animated: true)
                        
                        
                        
                        _checkmarkRowSelected(cell: cell, section: indexPath.section)
                        
                        checkmarkRowSelected(cell: cell, key: key)
                        
                        
                        
                    } else {
                        print("SETTINGS: Checkmark cell data key could not be found")
                    }
                    
                } else {
                    print("SETTINGS: This index does not have a valid checkmark cell")
                }
                
            } else if (displayType == XvSetConstants.DISPLAY_TYPE_BUTTON){
                
                //MARK: Button cells
                
                if let cell:XvSetButtonCell = getButtonCell(indexPath: indexPath){
                    
                    if let key:String = getKey(fromCell: cell) {
                        
                        buttonRowSelected(cell: cell, key: key)
                        
                        //deselect row so the grey background flashes
                        tableView.deselectRow(at: indexPath, animated: true)
                        
                    } else {
                        print("SETTINGS: Button cell data key could not be found")
                    }
                    
                } else {
                    print("SETTINGS: This index does not have a valid button cell")
                }
                
            } else {
                print("SETTINGS: Error connecting to data source for SetMain didSelectRowAt")
            }
            
        }
        
    }
    
    //override by app settings classes, which check for app specific keys and execute app specific commands
    open func disclosureRowSelected(cell:XvSetDisclosureCell, key:String){
        
    }
    
    open func multiDisclosureRowSelected(cell:XvSetDisclosureMultiCell, key:String){
        
    }
    
    open func checkmarkRowSelected(cell:XvSetCheckmarkCell, key:String) {
        
        
        
        
    }
    
    open func buttonRowSelected(cell:XvSetButtonCell, key:String) {
        
    }
    
    //MARK: - TOGGLE SWITCH
    
    open func toggleSwitchChanged(_ sender:UISwitch) {
        
        updateValues(fromSwitch: sender)
        refreshTableDisplay(fromSwitch: sender)
        
        //is data valid?
        if (dataSource != nil){
            
            if let key:String = getToggleCellKey(fromSwitch: sender) {
                
                toggleSelected(isOn: sender.isOn, key: key)
                
            } else {
                print("SETTINGS: Error getting toggle cell key SetMain toggleSwitchChanged")
            }
            
        } else {
            
            print("SETTINGS: Error connecting to data source for SetMain toggleSwitchChanged")
            
        }
        
    }
    
    //override in app 
    open func toggleSelected(isOn:Bool, key:String){
        
    }

    
    
    
    //MARK: - PUBLIC API
    
    //MARK:- ACCESSORS
    public func setNav(nav: UINavigationController) {
        self.nav = nav
    }
    
    public func getNav() -> UINavigationController? {
        return nav
    }
    
    //MARK: - VC MANAGEMENT
    public func push(viewController:UIViewController) {
        if (getNav() != nil){
            getNav()!.pushViewController(viewController, animated: true)
        }
    }
    
    

    //MARK: Row / cell getters
    public func getDisplayType(dataSource:XvSetMultiData, indexPath:IndexPath) -> String {
        
        return dataSource.sections[indexPath.section].cells[indexPath.row].displayType
    }
    
    fileprivate func getCells(inSection:Int) -> [UITableViewCell]? {
        
        var cells:[UITableViewCell] = []
        for row in 0..<tableView.numberOfRows(inSection: inSection) {
            
            let newIndexPath:IndexPath = IndexPath(row: row, section: inSection)
            if let cell:UITableViewCell = tableView.cellForRow(at: newIndexPath){
                cells.append(cell)
            }
            
        }
        
        if (cells.count > 0){
            return cells
        } else {
            print("SETTINGS: No cells in section during getCells")
            return nil
        }
        
    }

    
    public func getDisclosureCell(indexPath: IndexPath) -> XvSetDisclosureCell? {
        
        if let cell:XvSetDisclosureCell = tableView.cellForRow(at: indexPath) as? XvSetDisclosureCell {
            
            return cell
            
        } else {
            print("SETTINGS: Error finding SetMultiTable SetDisclosureCell")
            return nil
        }
        
    }
    
    public func getDisclosureMultiCell(indexPath: IndexPath) -> XvSetDisclosureMultiCell? {
        
        if let cell:XvSetDisclosureMultiCell = tableView.cellForRow(at: indexPath) as? XvSetDisclosureMultiCell {
            
            return cell
            
        } else {
            print("SETTINGS: Error finding SetMultiTable SetDisclosureMultiCell")
            return nil
        }
        
    }
    
    public func getCheckmarkCell(indexPath: IndexPath) -> XvSetCheckmarkCell? {
        
        if let cell:XvSetCheckmarkCell = tableView.cellForRow(at: indexPath) as? XvSetCheckmarkCell {
            
            return cell
            
        } else {
            print("SETTINGS: Error finding SetMultiTable SetCheckmarkCell")
            return nil
        }
        
        
    }
    
    fileprivate func getCheckmarkCells(inSection:Int) -> [XvSetCheckmarkCell]? {
        
        if let cells:[UITableViewCell] = getCells(inSection: inSection) {
            
            var checkmarkCells:[XvSetCheckmarkCell] = []
            
            for cell in cells {
                
                if let checkmarkCell:XvSetCheckmarkCell = cell as? XvSetCheckmarkCell {
                    checkmarkCells.append(checkmarkCell)
                }
            }
            
            if (checkmarkCells.count > 0){
                return checkmarkCells
            } else {
                print("SETTINGS: Cell array contains no checkmark cells during getCheckmarkCells")
                return nil
            }
            
        } else {
            return nil
        }
        
    }
    
    public func getButtonCell(indexPath: IndexPath) -> XvSetButtonCell? {
        
        if let cell:XvSetButtonCell = tableView.cellForRow(at: indexPath) as? XvSetButtonCell {
            
            return cell
            
        } else {
            print("SETTINGS: Error finding SetMultiTable SetButtonCell")
            return nil
        }
        
        
    }
    
    public func getKey(fromCell: XvSetCell) -> String? {
        
        if let cellData:XvSetCellData = fromCell.data {
            
            return cellData.key
            
        } else {
            print("SETTINGS: Error accessing SetMultiTable data key")
            return nil
        }
        
    }

    
    
    //MARK: - INTERNAL -
    
    //build out footers
    internal func buildFooters(){
        
        sectionFooterViews = []
        
        //assemble footer objects with data from data class
        if (dataSource != nil){
            
            for i in 0 ..< dataSource!.sections.count {
                
                var setFooter:SetFooter?
                let type:String = dataSource!.sections[i].footerType
                let text:[String]? = dataSource!.sections[i].footerText
                let link:String? = dataSource!.sections[i].footerLink
                
                if (type == XvSetConstants.FOOTER_TYPE_NORMAL){
                    
                    //if text is valid
                    if (text != nil){
                        
                        //... create footer
                        setFooter = SetFooter(withText: text![0])
                        
                        //and append to object's array
                        sectionFooterViews!.append(setFooter)
                        
                    } else {
                        print("SETTINGS: Error creating normal footer")
                        sectionFooterViews!.append(nil)
                    }
                    
                    
                } else if (type == XvSetConstants.FOOTER_TYPE_LINK){
                    
                    //if all data is valid...
                    if (text != nil && link != nil){
                        
                        //... create footer
                        setFooter = SetFooter(
                            preText: text![0],
                            underlinedText: text![1],
                            postText: text![2],
                            link: link!)
                        
                        //enable interaction
                        setFooter!.isUserInteractionEnabled = true
                        
                        //set tap recognizer
                        let setFooterTap = UITapGestureRecognizer(
                            target: self,
                            action: #selector(XvSetTable.footerWithLinkWasTapped)
                        )
                        
                        setFooter!.addGestureRecognizer(setFooterTap)
                        
                        //and append to object's array
                        sectionFooterViews!.append(setFooter)
                        
                    } else {
                        print("SETTINGS: Error creating link footer")
                        sectionFooterViews!.append(nil)
                    }
                    
                } else {
                    
                    //else put in nil
                    sectionFooterViews!.append(nil)
                }
                
            }
            
        } else {
            print("SETTINGS: Error connecting to data source for SetMultiTable buildFooters")
        }

    }
    
    
    
    //MARK: - PRIVATE -
    
   
    //MARK: Checkmark
    
    fileprivate func _checkmarkRowSelected(cell: XvSetCheckmarkCell, section: Int) {
        
        if let data:XvSetCheckmarkCellData = cell.data as? XvSetCheckmarkCellData {
            
            //if not a multi cell, uncheck all others
            if (!data.multi){
                _turnOffCheckmarks(inSection: section)
            }
            
            //turn this cell on in view and data
            cell.accessoryType = .checkmark
            data.selected = true
            
            Utils.postNotification(
                name: XvSetConstants.kSettingsPanelDefaultChanged,
                userInfo: ["key" : data.key, "value" : data.value as Any])
            
        } else {
            print("SETTINGS: Checkmark cell data is invalid")
        }
        
    }
    
    fileprivate func _turnOffCheckmarks(inSection:Int){
        
        if let checkmarkCells:[XvSetCheckmarkCell] = getCheckmarkCells(inSection: inSection) {
            
            for cell in checkmarkCells {
                
                cell.accessoryType = .none
                
                if let data:XvSetCheckmarkCellData = cell.data as? XvSetCheckmarkCellData {
                    data.selected = false
                } else {
                    print("SETTINGS: No data available in checkmark cell")
                }
            }
            
        }
        
    }
    
    
    
    //MARK: Toggle
    
    //update toggle cell's default value and the correspond user default
    fileprivate func updateValues(fromSwitch:UISwitch){
        
        //if cell data is valid...
        if let toggleCellData:XvSetCellData = getToggleCellData(fromSwitch: fromSwitch) {
            
            //set cell data's default value to uiswitch value
            toggleCellData.defaultValue = fromSwitch.isOn
            
            Utils.postNotification(
                name: XvSetConstants.kSettingsPanelDefaultChanged,
                userInfo: ["key" : toggleCellData.key, "value" : fromSwitch.isOn as Any])
            
        } else {
            
            print("SETTINGS: SetMultiTable toggleCellData is nil during user toggle")
            
        }

        
    }
    
    // show / hide sections that rely on specifc toggle switch values
    fileprivate func refreshTableDisplay(fromSwitch:UISwitch){
        
        //is table data valid?
        if (dataSource != nil){
            
            //grab index path from sender (SetCell's data obj)
            if let indexPath:IndexPath = getIndexPath(fromSwitch: fromSwitch) {
                
                //grab targets array, if not nil
                if let visibilityTargets:[Int] = dataSource!.sections[indexPath.section].cells[indexPath.row].visibilityTargets {
                    
                    //... then cycle through them and change their visibility bool in the data
                    for target in visibilityTargets {
                        
                        dataSource!.sections[target].isVisible = fromSwitch.isOn
                        
                    }
                    
                    //create index set from targets
                    let indexSet:IndexSet = IndexSet(visibilityTargets)
                    
                    //reload with anim
                    tableView.reloadSections(indexSet, with: .fade)
                    
                }
                
            } else {
                print("SETTINGS: Error connecting to data source for SetMain during user toggle.")
            }
            
        } else {
            print("SETTINGS: Error connecting to data source for SetMain during user toggle.")
        }

        
    }
    
    
    //general toggle switch accessors
    public func getToggleCellKey(fromSwitch:UISwitch) -> String?{
        
        if let toggleCellData:XvSetCellData = getToggleCellData(fromSwitch: fromSwitch) {
            
            return toggleCellData.key
        
        } else {
            
            print("SETTINGS: SetMultiTable getToggleCellKey not found during user toggle")
            return nil
        }
        
    }
    
    internal func getIndexPath(fromSwitch:UISwitch) -> IndexPath? {
        
        if let toggleCellData:XvSetCellData = getToggleCellData(fromSwitch: fromSwitch) {
            
            return toggleCellData.indexPath
        
        } else {
            
             print("SETTINGS: SetMultiTable getIndexPath not found during user toggle")
            return nil
        
        }
        
    }
    
    fileprivate func getToggleCellData(fromSwitch:UISwitch) -> XvSetCellData? {
    
        //if toggle cell is valid
        if let toggleCell:XvSetToggleCell = fromSwitch.superview!.superview as? XvSetToggleCell {
            
            //if data is valid
            if let data:XvSetCellData = toggleCell.data {
                return data
            } else {
                print("SETTINGS: SetMultiTable Toggle cell data could not be found during user toggle")
            }
            
            
        } else {
            print("SETTINGS: SetMultiTable Toggle cell could not be found during user toggle")
        }
        
        //else nil
        return nil
    
    }
    
    
    //MARK: - DEINT
    deinit {
        sectionFooterViews = nil
    }
    
}
