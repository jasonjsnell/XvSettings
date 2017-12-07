//
//  SettingsTableViewController.swift
//  RF Settings
//
//  Created by Jason Snell on 8/30/16.
//  Copyright © 2016 Jason J. Snell. All rights reserved.
//

// a table of sections. Sections can have any kind of cells (button, checkmark, disclosure, toggle)

import UIKit
import CoreData

//TODO: if RF is started, I open the Settings Panel, then I go to AB and relaunch it from there, it will crash.

public class TableVC: UITableViewController {
    
    //MARK: - VARIABLES -
    
    public var dataSource:TableData?
    
    internal let xvcdm:XvCoreDataManager = XvCoreDataManager.sharedInstance
    internal var nav:UINavigationController?
    internal var sectionFooterViews:[Footer?]?
    
    internal let debug:Bool = false
    
    //MARK: - BUILD -
    
    public func load(withDataSource:TableData){
        
        if (debug){
            print("")
            print("SETTINGS TABLE: Load table with data source", withDataSource)
        }
        
        self.dataSource = nil
        self.dataSource = withDataSource
        title = withDataSource.title
    }
    
    override public func viewDidLoad() {
        
        super.viewDidLoad()
        
        //init size of view. X is 20 for status bar
        let tableFrame:CGRect = CGRect(x: 0, y: 20, width: self.view.bounds.width, height: self.view.bounds.height)
        tableView = UITableView(frame: tableFrame, style: .grouped)
        
        //set delegate to self
        tableView.delegate = self
        tableView.dataSource = self
        
        //build footers
        buildFooters()
        
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
    }
    
    
    //MARK: - SECTIONS
    // number of section(s)
    override public func numberOfSections(in tableView: UITableView) -> Int {
        
        if (dataSource != nil){
            return dataSource!.sections.count
        } else {
            print("SETTINGS: Error connecting to data source for SetMultiTable numberOfSections")
            return 0
        }
        
    }
    
    //MARK: - ROWS
    //number of rows in each section
    override public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if (dataSource != nil){
            
            let sectionData:SectionData = dataSource!.sections[section]
            
            //if section is visible...
            if (sectionData.isVisible){
                
                return sectionData.cells.count
                
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
    override public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if (dataSource != nil){
            
            let sectionData:SectionData = dataSource!.sections[indexPath.section]
            let cellData:CellData = sectionData.cells[indexPath.row]
            
            //if both the section and the cell is visible...
            if (sectionData.isVisible && cellData.isVisible) {
                
                //return default
                return UITableViewAutomaticDimension
                
            } else {
                
                //else an invisible height
                return 0.1
            }
            
        } else {
            print("SETTINGS: Error connecting to data source for SetMultiTable heightForRowAt")
            return 0.1
        }
        
    }
    
    //MARK: Main build
    override public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        func setVisibility(cell:Cell, cellData:CellData){
            if (!cellData.isVisible){
                cell.isHidden = true
            }
        }
        
        if (dataSource != nil){
            
            //get cell data
            let cellDataObj:CellData = dataSource!.sections[indexPath.section].cells[indexPath.row]
            
            //set the index path into the object so it can be referred to later
            //example: toggle switch requires it to set isSectionVisible bool in data class
            cellDataObj.indexPath = indexPath
            
            if (cellDataObj.displayType == XvSetConstants.DISPLAY_TYPE_SWITCH){
                
                //create toggle cell
                let toggleCell:ToggleCell = ToggleCell(
                    style: .default,
                    reuseIdentifier: cellDataObj.key,
                    data: cellDataObj)
                
                //add listener
                toggleCell.toggleSwitch.addTarget(
                    self,
                    action: #selector(toggleSwitchChanged),
                    for: UIControlEvents.valueChanged)
                
                setVisibility(cell: toggleCell, cellData: cellDataObj)
                
                //return object
                return toggleCell
                
            } else if (cellDataObj.displayType == XvSetConstants.DISPLAY_TYPE_SLIDER){
                
                //cast data
                if let sliderCellDataObj:SliderCellData = cellDataObj as? SliderCellData {
                    
                    //create slider cell
                    let sliderCell:SliderCell = SliderCell(
                        style: .default,
                        reuseIdentifier: cellDataObj.key,
                        data: cellDataObj as! SliderCellData)
                    
                    //create ref of cell in data (used later in linked slider cells)
                    sliderCellDataObj.set(sliderCell: sliderCell)
                    
                    //add listeners
                    sliderCell.slider.addTarget(
                        self,
                        action: #selector(sliderChanged),
                        for: UIControlEvents.valueChanged)
                    
                    sliderCell.slider.addTarget(
                        self,
                        action: #selector(sliderEnded),
                        for: UIControlEvents.touchUpInside)
                    
                    setVisibility(cell: sliderCell, cellData: cellDataObj)
                    
                    //return object
                    return sliderCell
                    
                } else {
                    
                    print("SETTINGS: Error: Unable to cast cellDataObj as SliderCellData during cellForRowAt")
                    return UITableViewCell()
                }
                
            } else if (cellDataObj.displayType == XvSetConstants.DISPLAY_TYPE_BUTTON){
                
                let buttonCell:ButtonCell = ButtonCell(
                    style: .default,
                    reuseIdentifier: cellDataObj.key,
                    data: cellDataObj)
                
                setVisibility(cell: buttonCell, cellData: cellDataObj)
                
                return buttonCell
                
                
            } else if (cellDataObj.displayType == XvSetConstants.DISPLAY_TYPE_CHECKMARK){
                
                let checkmarkCell:CheckmarkCell = CheckmarkCell(
                    style: .default,
                    reuseIdentifier: cellDataObj.key,
                    data: cellDataObj as! CheckmarkCellData)
                
                setVisibility(cell: checkmarkCell, cellData: cellDataObj)
                
                return checkmarkCell
                                
                
            } else if (cellDataObj.displayType == XvSetConstants.DISPLAY_TYPE_DISCLOSURE){
                
                //disclosure - leads to subview
                
                let disclosureCell:DisclosureCell = DisclosureCell(
                    style: .value1,
                    reuseIdentifier: cellDataObj.key,
                    data: cellDataObj as! DisclosureCellData)
                
                setVisibility(cell: disclosureCell, cellData: cellDataObj)
            
                return disclosureCell
                
                
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
    override public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
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
    override public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
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
    override public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
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
    
    override public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
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
    
    internal func buildFooters(){
        
        sectionFooterViews = []
        
        //assemble footer objects with data from data class
        if (dataSource != nil){
            
            for i in 0 ..< dataSource!.sections.count {
                
                var setFooter:Footer?
                let type:String = dataSource!.sections[i].footerType
                let text:[String]? = dataSource!.sections[i].footerText
                let link:String? = dataSource!.sections[i].footerLink
                
                if (type == XvSetConstants.FOOTER_TYPE_NORMAL){
                    
                    //if text is valid
                    if (text != nil){
                        
                        //... create footer
                        setFooter = Footer(withText: text![0])
                        
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
                        setFooter = Footer(
                            preText: text![0],
                            underlinedText: text![1],
                            postText: text![2],
                            link: link!)
                        
                        //enable interaction
                        setFooter!.isUserInteractionEnabled = true
                        
                        //set tap recognizer
                        let setFooterTap = UITapGestureRecognizer(
                            target: self,
                            action: #selector(footerWithLinkWasTapped)
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


    //MARK: - USER INPUT -
    
    //MARK: ROWS
    
    //prevents clicks on rows with toggle switches from firing
    //this fixes errors where toggle switches were getting stuck in one position
    override public func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        
        let cell:Cell = tableView.cellForRow(at: indexPath) as! Cell
        if let cellData:CellData = cell.data {
            
            //return nil on toggle cells, making their background not clickable
            if (cellData.displayType == XvSetConstants.DISPLAY_TYPE_SWITCH){
                return nil
            }
        }
        
        return indexPath
    }

    
    // when user selects a row, do the error checking then call the more usable rowSelected funcs that are specific to each row type (a disclosure cell, a checkmark cell, a button cell, etc...)
    
    override public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //is data valid?
        if (dataSource != nil){
            
            let displayType:String = getDisplayType(dataSource:dataSource!, indexPath:indexPath)
            
            if (displayType == XvSetConstants.DISPLAY_TYPE_DISCLOSURE){
                
                //MARK: Disclosure cells
                
                if let cell:DisclosureCell = getDisclosureCell(indexPath: indexPath){
                    
                    //get the key
                    if let key:String = getKey(fromCell: cell) {
                        
                        disclosureRowSelected(cell: cell, key: key)
                        
                    } else {
                        print("SETTINGS: Disclosure cell data key could not be found")
                    }
                    
                } else {
                    print("SETTINGS: This index does not have a valid disclosure cell")
                }
                
            } else if (displayType == XvSetConstants.DISPLAY_TYPE_CHECKMARK){
                
                //MARK: Checkmark cells
                
                if let cell:CheckmarkCell = getCheckmarkCell(indexPath: indexPath) {
                    
                    //deselect row so the grey background flashes
                    tableView.deselectRow(at: indexPath, animated: true)
                    
                    checkmarkRowSelected(cell: cell, indexPath: indexPath)
                    _refreshTableDisplay(fromCheckmarkCell: cell)
                    
                } else {
                    print("SETTINGS: This index does not have a valid checkmark cell")
                }
                
            } else if (displayType == XvSetConstants.DISPLAY_TYPE_BUTTON){
                
                //MARK: Button cells
                
                if let cell:ButtonCell = getButtonCell(indexPath: indexPath){
                    
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
    
    
    //MARK: - BUTTON CELL
    internal func buttonRowSelected(cell:ButtonCell, key:String) {
        
        if (key == XvSetConstants.kConfigRearrange){
            
            Utils.postNotification(
                name: XvSetConstants.kConfigRearrangeButtonTapped,
                userInfo: nil)
            
        } else if (key == XvSetConstants.kConfigArtificialIntelligence){
            
            let alert = UIAlertController(
                title: "Reset",
                message: "Are you sure you want to reset the AI memory?",
                preferredStyle: UIAlertControllerStyle.alert)
            
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                UIAlertAction in
                
                Utils.postNotification(
                    name: XvSetConstants.kConfigResetAIButtonTapped,
                    userInfo: nil)
                
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) {
                UIAlertAction in
                //
            }
            
            alert.addAction(okAction)
            alert.addAction(cancelAction)
            self.present(alert, animated: true, completion: nil)
            
            
        } else if (key == XvSetConstants.kTracksFactorySettings){
            
            let alert = UIAlertController(
                title: "Restore",
                message: "Are you sure you want to restore the tracks to their factory settings?",
                preferredStyle: UIAlertControllerStyle.alert)
            
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                UIAlertAction in
                
                Utils.postNotification(
                    name: XvSetConstants.kTracksRestoreFactorySettingsButtonTapped,
                    userInfo: nil)
                
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) {
                UIAlertAction in
                //
            }
            
            alert.addAction(okAction)
            alert.addAction(cancelAction)
            self.present(alert, animated: true, completion: nil)
            
        }
    }
    
    
    //MARK: - CHECKMARK
    
    //overriden in checkmark table class
    internal func checkmarkRowSelected(cell: CheckmarkCell, indexPath:IndexPath) {
        
        if let cellData:CheckmarkCellData = cell.data as? CheckmarkCellData {
            
            //grab value from cell data
            var _value:Any = cellData.value
            
            //if a multi cell...
            if (cellData.multi){
                
                //if not current checked...
                if (!cellData.selected){
                    
                    //turn this cell on in view and data
                    cell.accessoryType = .checkmark
                    cellData.selected = true
                    
                } else {
                    
                    //else if currently checked...
                    //turn off cell and data
                    cell.accessoryType = .none
                    cellData.selected = false
                }
                
                
                _value = _getArrayOfValues(level: cellData.levelType, key: cellData.key, value: cellData.value)
                print("array of values", _value)
                
            } else {
                
                //if not a multi cell...
                
                //uncheck all others
                _turnOffCheckmarks(inSection: indexPath.section)
                
                //and check this one
                cell.accessoryType = .checkmark
                cellData.selected = true
            }
            
            
            //save value to disk
            _setCoreData(
                level: cellData.levelType,
                value: _value,
                key: cellData.key,
                multi: cellData.multi)
            
            //post notification to app can make updates
            Utils.postNotification(
                name: XvSetConstants.kSettingsValueChanged,
                userInfo: ["type" : cellData.levelType, "key" : cellData.key]
            )
            
            
        } else {
            print("SETTINGS: Checkmark cell data is invalid")
        }
        
    }
    
    fileprivate func _turnOffCheckmarks(inSection:Int){
        
        if let checkmarkCells:[CheckmarkCell] = _getCheckmarkCells(inSection: inSection) {
            
            for cell in checkmarkCells {
                
                cell.accessoryType = .none
                
                if let data:CheckmarkCellData = cell.data as? CheckmarkCellData {
                    data.selected = false
                } else {
                    print("SETTINGS: Error: No data available in checkmark cell")
                }
            }
            
        }
        
    }
    
    fileprivate func _hideAllCells(inSection:Int){
        
        //is table data valid?
        if (dataSource != nil){
            
            for cellData in dataSource!.sections[inSection].cells {
                
                cellData.isVisible = false
            }
            
            //create index set from targets
            let indexSet:IndexSet = IndexSet([inSection])
            
            //reload
            tableView.reloadSections(indexSet, with: .none)
            
        } else {
            print("SETTINGS: Error connecting to data source for SetMain during _hideAllCells.")
        }
    }
    
    
    
    // show / hide sections that rely on specifc checkmark cells being selected
    
    fileprivate func _refreshTableDisplay(fromCheckmarkCell:CheckmarkCell){
        
        //is table data valid?
        if (dataSource != nil){
            
            // cast cell data as checkmark
            if let cellData:CheckmarkCellData = fromCheckmarkCell.data as? CheckmarkCellData {
                
                //if there are visibility targets in this cell
                if let visibilityTargets:[[Int]] = cellData.visibilityTargets {
                    
                    //loop through them
                    for visibilityTarget in visibilityTargets {
                        
                        //and hide the cells in the visibility target's section
                        _hideAllCells(inSection: visibilityTarget[0])
                    }
                    
                    //grab index path from sender (SetCell's data obj) and data type the data
                    if let indexPath:IndexPath = _getIndexPath(fromCheckmarkCell: fromCheckmarkCell) {
                        
                        //show the visibility target
                        _updateVisibilityTargets(indexPath: indexPath, isOn: true)
                        
                    } else {
                        print("SETTINGS: Error getting indexPath during _refreshTableDisplay.")
                    }
                    
                }
                
                //else no visibility targets, do nothing
                
            } else {
                print("SETTINGS: Error casting cell data during _refreshTableDisplay.")
            }
            
        } else {
            print("SETTINGS: Error connecting to data source for SetMain during _refreshTableDisplay.")
        }
        
        
    }
    
    
    
    fileprivate func _getArrayOfValues(level:String, key:String, value:Any) -> [Any]{
        
        //1. get existing values based on level type (app or track)
        //var to populate and return
        var existingValueArray:[Any] = []
        
        if (level == XvSetConstants.LEVEL_TYPE_CONFIG) {
            
            // if config...
            if let currConfigFile:NSManagedObject = xvcdm.currConfigFile {
                
                // get value for key
                if let existingConfigValue:Any = xvcdm.getAny(forKey: key, forObject: currConfigFile) {
                    
                    //is this value an array?
                    if let existingConfigValueArray:[Any] = existingConfigValue as? [Any] {
                        
                        existingValueArray = existingConfigValueArray
                    }
                    
                } else {
                    
                    print("SETTINGS: Error getting config array during _getArrayOfValues")
                }
                
            } else {
                
                print("SETTINGS: Error getting config during _getArrayOfValues")
            }
            
        } else if (level == XvSetConstants.LEVEL_TYPE_TRACK) {
            
            // if track...
            if let currTrack:NSManagedObject = xvcdm.currTrack {
                
                // get value for key with this track
                if let existingTrackValue:Any = xvcdm.getAny(forKey: key, forObject: currTrack) {
                    
                    //is this value an array?
                    if let existingTrackValueArray:[Any] = existingTrackValue as? [Any] {
                        
                        existingValueArray = existingTrackValueArray
                    }
                    
                } else {
                    
                    print("SETTINGS: Error getting track array during _getArrayOfValues")
                }
                
            } else {
                
                print("SETTINGS: Error getting curr track during _getArrayOfValues")
            }
        
        } else if (level == XvSetConstants.LEVEL_TYPE_SAMPLE) {
            
            // if sample...
            if let currSampleBank:NSManagedObject = xvcdm.currSampleBank {
                
                // get value for key with this sample bank
                if let existingSampleBankValue:Any = xvcdm.getAny(forKey: key, forObject: currSampleBank) {
                    
                    //is this value an array?
                    if let existingSampleBankValueArray:[Any] = existingSampleBankValue as? [Any] {
                        
                        existingValueArray = existingSampleBankValueArray
                    }
                    
                } else {
                    
                    print("SETTINGS: Error getting sample bank array during _getArrayOfValues")
                }
                
            } else {
                
                print("SETTINGS: Error getting curr sample bank during _getArrayOfValues")
            }
            
        } else {
            
            print("SETTINGS: Error recognizing type during _getArrayOfValues")
            
        }
        
        //2. Is the new value already in the existing array
        
        var indexOfValueInArray:Int = -1
        
        for i in 0..<existingValueArray.count {
            if (String(describing: existingValueArray[i]) == String(describing: value)) {
                indexOfValueInArray = i
            }
        }
        
        //3. Add or remove value
        if (indexOfValueInArray == -1){
            
            existingValueArray.append(value)
            
        } else {
            
            existingValueArray.remove(at: indexOfValueInArray)
        }
        
        //4. Return result
        return existingValueArray
        
    }
    
    //MARK: - DISCLOSURE CELL
    
    //overriden by track tables
    internal func disclosureRowSelected(cell:DisclosureCell, key:String){
        
    }
    
    
    //MARK: - FOOTER
    //user taps link is settings footer
    @objc internal func footerWithLinkWasTapped(sender:UITapGestureRecognizer){
        
        if let footer:Footer = sender.view as? Footer {
            
            if (debug){
                print("SETTINGS: Launch", footer.url)
            }
            
            let url = URL(string: footer.url)!
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
            
        }
    }

    
    //MARK: - SLIDER
    
    /*
     Update the core data and track / app value when the slider is being dragged, as long as it is a new value. Slider values reset when the handle is reset
     */
    fileprivate var currSliderValue:Any  = -99999
    fileprivate let SLIDER_NON_VALUE:Int = -99999
    
    @objc internal func sliderChanged(_ sender:UISlider) {
        
        //validate cell
        if let sliderCell:SliderCell = sender.superview?.superview as? SliderCell {
            
            //validate data
            if let sliderCellData:SliderCellData = sliderCell.data as? SliderCellData {
                
                //set slider cell
                
                if let sliderValue:Any = sliderCell.set(withSliderValue: sender.value) {
                    
                    //if new...
                    if (_isSliderValueNew(newValue: sliderValue)){
                        
                        //set core data
                        _setCoreData(
                            level: sliderCellData.levelType,
                            value: sliderValue,
                            key: sliderCellData.key,
                            multi: false)
                        
                        /*
                         //TODO: Future: uncomment if there are linked sliders
                        //if there is a linked cell...
                        if let linkedSliderCellData:SliderCellData = sliderCellData.linkedSliderCellData {
                            
                            //save its data too
                            _setCoreData(
                                level: linkedSliderCellData.levelType,
                                value: linkedSliderCellData.value,
                                key: linkedSliderCellData.key,
                                multi: false)
                        }*/
                        
                        //post notification to app can make updates
                        
                        Utils.postNotification(
                            name: XvSetConstants.kSettingsValueChanged,
                            userInfo: ["type" : sliderCellData.levelType, "key" : sliderCellData.key]
                        )
                    }
                    
                } else {
                    print("SETTINGS: Error setting slideCell with slider value during sliderChanged")
                }
                
            } else {
                
                print("SETTINGS: Error getting sliderCellData during sliderChanged")
            }

        } else {
            
            print("SETTINGS: Error getting sliderCell during sliderChanged")
        }
        
    }
    
    //save the slider value when the user has released it
    @objc internal func sliderEnded(_ sender:UISlider) {
        
        //reset slider var
        currSliderValue = SLIDER_NON_VALUE
    }
    
    fileprivate func _isSliderValueNew(newValue:Any) -> Bool {
        
        //compare values as strings
        if (String(describing: newValue) != String(describing: currSliderValue)) {
            
            //if the same, return true
            currSliderValue = newValue
            return true
        }
        
        return false
    }

    //MARK: - TOGGLE SWITCH

    @objc internal func toggleSwitchChanged(_ sender:UISwitch) {
        
        //if cell data is valid...
        if let toggleCellData:CellData = getToggleCellData(fromSwitch: sender) {
            
            //set cell data's default value to uiswitch value
            toggleCellData.value = sender.isOn
            
            _setCoreData(
                level: toggleCellData.levelType,
                value: sender.isOn,
                key: toggleCellData.key,
                multi: false)
            
            //post notification to app can make updates
            Utils.postNotification(
                name: XvSetConstants.kSettingsValueChanged,
                userInfo: ["type" : toggleCellData.levelType, "key" : toggleCellData.key]
            )
            
            
        } else {
            
            print("SETTINGS: Error getting toggleCellData during _updateValues")
        }
        
        _refreshTableDisplay(fromSwitch: sender)
        
    }
    
    
    fileprivate func _refreshTableDisplay(fromSwitch:UISwitch){
        
        //is table data valid?
        if (dataSource != nil){
            
            //grab index path from sender (SetCell's data obj)
            if let indexPath:IndexPath = getIndexPath(fromSwitch: fromSwitch) {
                
                _updateVisibilityTargets(indexPath: indexPath, isOn: fromSwitch.isOn)
                
            } else {
                print("SETTINGS: Error connecting to data source for SetMain during user toggle.")
            }
            
        } else {
            print("SETTINGS: Error connecting to data source for SetMain during user toggle.")
        }
    }

    
    //MARK: - VC MANAGEMENT -
    
    //called internally and by settings helper
    public func push(viewController:UIViewController) {
        if (getNav() != nil){
            getNav()!.pushViewController(viewController, animated: true)
        } else {
            print("SETTINGS: Nav is nil during VC push")
        }
    }
    
    internal func loadCheckmarkTable(fromCell:DisclosureCell) {
        
        let vc:CheckmarkTableVC = CheckmarkTableVC()
        vc.load(withParentDisclosureCell: fromCell)
        push(viewController: vc)
        
    }
    
    internal func loadTrackTable(position:Int) {
        
        if let _nav:UINavigationController = getNav() {
            
            let data:TrackTableData = TrackTableData(position: position)
            let vc:TrackTableVC = TrackTableVC()
            vc.load(withDataSource: data)
            vc.setNav(nav: _nav)
            push(viewController: vc)
            
        } else {
            
            print("SETTINGS: Error: Nav is nil during loadTrackTable. Blocking push")
        }
        
    }
    
    internal func loadMusicalScaleTable(){
        
        if let _nav:UINavigationController = getNav() {
            
            if let musicalScaleTableData:MusicalScaleData = MusicalScaleData() {
                
                let vc:TableVC = TableVC()
                vc.load(withDataSource: musicalScaleTableData)
                vc.setNav(nav: _nav)
                push(viewController: vc)
                
            } else {
                
                print("SETTINGS: Error when init MusicalScaleData during loadMusicalScaleTable")
            }
            
            
        } else {
            
            print("SETTINGS: Error: Nav is nil during loadMusicalScaleTable. Blocking push")
        }
    }
    

    
    
    //MARK:- ACCESSORS -
    
    
    internal func getDisplayType(dataSource:TableData, indexPath:IndexPath) -> String {
        
        return dataSource.sections[indexPath.section].cells[indexPath.row].displayType
    }
    
    fileprivate func _getCells(inSection:Int) -> [UITableViewCell]? {
        
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
            print("SETTINGS: No cells in section during _getCells")
            return nil
        }
        
    }
    
    public func getKey(fromCell: Cell) -> String? {
        
        if let cellData:CellData = fromCell.data {
            
            return cellData.key
            
        } else {
            print("SETTINGS: Error accessing SetMultiTable data key")
            return nil
        }
        
    }
    
    public func getCell(fromKey:String) -> Cell? {
        
        for section:Int in 0..<tableView.numberOfSections {
            
            for row:Int in 0..<tableView.numberOfRows(inSection: section) {
                
                let indexPath:IndexPath = IndexPath(row: row, section: section)
                
                //if cell can be cast as SetCell object
                if let cell:Cell = tableView.cellForRow(at: indexPath) as? Cell {
                    
                    //if data is valid
                    if let data:CellData = cell.data {
                        
                        if (data.key == fromKey){
                            return cell
                        }
                    }
                }
            }
        }
        
        print("SETTINGS: Found no cell with key", fromKey, "during getCell")
        return nil
        
    }
    
    //MARK: - BUTTON CELL
    public func getButtonCell(indexPath: IndexPath) -> ButtonCell? {
        
        if let cell:ButtonCell = tableView.cellForRow(at: indexPath) as? ButtonCell {
            
            return cell
            
        } else {
            print("SETTINGS: Error finding SetMultiTable SetButtonCell")
            return nil
        }
        
        
    }
    
    
    //MARK: - CHECKMARK CELLS
    
    internal func getCheckmarkCell(indexPath: IndexPath) -> CheckmarkCell? {
        
        if let cell:CheckmarkCell = tableView.cellForRow(at: indexPath) as? CheckmarkCell {
            
            return cell
            
        } else {
            print("SETTINGS: Error finding SetMultiTable SetCheckmarkCell")
            return nil
        }
        
        
    }
    
    fileprivate func _getCheckmarkCells(inSection:Int) -> [CheckmarkCell]? {
        
        if let cells:[UITableViewCell] = _getCells(inSection: inSection) {
            
            var checkmarkCells:[CheckmarkCell] = []
            
            for cell in cells {
                
                if let checkmarkCell:CheckmarkCell = cell as? CheckmarkCell {
                    checkmarkCells.append(checkmarkCell)
                }
            }
            
            if (checkmarkCells.count > 0){
                return checkmarkCells
            } else {
                print("SETTINGS: Cell array contains no checkmark cells during _getCheckmarkCells")
                return nil
            }
            
        } else {
            return nil
        }
        
    }

    
    fileprivate func _getIndexPath(fromCheckmarkCell:CheckmarkCell) -> IndexPath? {
        
        if let checkmarkCellData:CellData = _getData(fromCheckmarkCell: fromCheckmarkCell) {
            
            return checkmarkCellData.indexPath
            
        } else {
            
            print("SETTINGS: Error: Checkmark cell data not found during getIndexPath fromCheckmarkCell")
            return nil
            
        }
        
    }
    
    fileprivate func _getData(fromCheckmarkCell:CheckmarkCell) -> CellData? {
        
        //if data is valid
        if let data:CellData = fromCheckmarkCell.data {
            return data
        } else {
            print("SETTINGS: Error getting data from checkmark cell")
        }
        
        //else nil
        return nil
        
    }
    
    //MARK: - DISCLOSURE CELL
    internal func getDisclosureCell(indexPath: IndexPath) -> DisclosureCell? {
        
        if let cell:DisclosureCell = tableView.cellForRow(at: indexPath) as? DisclosureCell {
            
            return cell
            
        } else {
            print("SETTINGS: Error finding SetMultiTable SetDisclosureCell")
            return nil
        }
        
    }
    
    //MARK: - NAV
    public func setNav(nav: UINavigationController) {
        self.nav = nav
    }
    
    internal func getNav() -> UINavigationController? {
        return nav
    }

    
    //MARK: - TOGGLE CELLS
    //general toggle switch accessors
    public func getToggleCellKey(fromSwitch:UISwitch) -> String?{
        
        if let toggleCellData:CellData = getToggleCellData(fromSwitch: fromSwitch) {
            
            return toggleCellData.key
            
        } else {
            
            print("SETTINGS: SetMultiTable getToggleCellKey not found during user toggle")
            return nil
        }
        
    }
    
    internal func getIndexPath(fromSwitch:UISwitch) -> IndexPath? {
        
        if let toggleCellData:CellData = getToggleCellData(fromSwitch: fromSwitch) {
            
            return toggleCellData.indexPath
            
        } else {
            
            print("SETTINGS: SetMultiTable getIndexPath not found during user toggle")
            return nil
            
        }
        
    }
    
    fileprivate func getToggleCellData(fromSwitch:UISwitch) -> CellData? {
        
        //if toggle cell is valid
        if let toggleCell:ToggleCell = fromSwitch.superview!.superview as? ToggleCell {
            
            //if data is valid
            if let data:CellData = toggleCell.data {
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
    
    
 
    //MARK: - VISIBILITY TARGETS -
    
    
    fileprivate func _updateVisibilityTargets(indexPath:IndexPath, isOn:Bool){
    
        //grab targets array, if not nil
        if let visibilityTargets:[[Int]] = dataSource!.sections[indexPath.section].cells[indexPath.row].visibilityTargets {
            
            //format: [[section1, row1, row2], [section2, row3], [allOfSection3]]
            
            //create blank array of sections
            var targetSections:[Int] = []
            
            //loop through all targets
            for vt in 0..<visibilityTargets.count {
                
                //grab the visibility target array
                let visibilityTarget:[Int] = visibilityTargets[vt]
                
                //grab the section (first element) and store it for later
                let targetSection:Int = visibilityTarget[0]
                targetSections.append(targetSection)
                
                //if only 1 item in target, it's to hide a whole section
                if (visibilityTarget.count == 1){
                    
                    dataSource!.sections[targetSection].isVisible = isOn
                    
                } else {
                    
                    //else it's to hide specific rows in a visible section
                    
                    //make sure section is visible
                    dataSource!.sections[targetSection].isVisible = true
                    
                    //(start at 1 to skip section)
                    for r in 1..<visibilityTarget.count {
                        
                        let row:Int = visibilityTarget[r]
                        
                        let cellData:CellData = dataSource!.sections[targetSection].cells[row]
                        
                        cellData.isVisible = isOn
                    }
                }
            }
            
            //create index set from targets
            let indexSet:IndexSet = IndexSet(targetSections)
            
            //reload
            tableView.reloadSections(indexSet, with: .automatic)
        }
        
    }
    
    

    
    //MARK: - CORE DATA -
    
    //when a value is changed in the settings panel, this func saves it to core data and notifies parent app so it can update the track
    fileprivate func _setCoreData(level:String, value:Any, key:String, multi:Bool){
        
        //if (debug){
            print("SETTINGS: TableVC: Set CoreData", level, value, key)
        //}
        
        //set core data value based on level (app, config, track, sample)
        var targetObject:NSManagedObject?
        
        switch level {
            
        case XvSetConstants.LEVEL_TYPE_APP:
            targetObject = xvcdm.app
            
        case XvSetConstants.LEVEL_TYPE_CONFIG:
            targetObject = xvcdm.currConfigFile
            
        case XvSetConstants.LEVEL_TYPE_TRACK:
            targetObject = xvcdm.currTrack
            
        case XvSetConstants.LEVEL_TYPE_SAMPLE:
            targetObject = xvcdm.currSampleBank
            
        default:
            targetObject = nil
        }
        
        if (targetObject != nil){
         
            xvcdm.set(value: value, forKey: key, forObject: targetObject!)
            
            if (!xvcdm.save()){
                print("SETTINGS: TableVC: Error saving during _setCoreData")
            }
            
        } else {
            
            print("SETTINGS: TableVC: Error: targetObject is nil during _setCoreData")
        }
        
        
    }
    
    //MARK: - ALERTS
    internal func _showAudiobusMidiBypassError(){
        
        let alert = UIAlertController(
            title: "Alert",
            message: "Internal MIDI routing cannot be used while Audiobus is active.",
            preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    //MARK: - DEINT
    deinit {
        sectionFooterViews = nil
    }
    
}
