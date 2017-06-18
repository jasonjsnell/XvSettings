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

public class TableVC: UITableViewController {
    
    //MARK: - VARIABLES -
    
    internal let xvcdm:XvCoreDataManager = XvCoreDataManager.sharedInstance
    
    //table data
    public var dataSource:TableData?
    
    
    internal var nav:UINavigationController?
    internal let debug:Bool = false

    
    internal var sectionFooterViews:[Footer?]?
    
    //MARK: - PUBLIC API
    //MARK:   LOAD -
    
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
    
    //MARK:- ROWS -
    //number of rows in each section
    override public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
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
    override public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
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
    
    override public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
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
                
                //return object
                return toggleCell
                
            } else if (cellDataObj.displayType == XvSetConstants.DISPLAY_TYPE_BUTTON){
                
                return ButtonCell(
                    style: .default,
                    reuseIdentifier: cellDataObj.key,
                    data: cellDataObj)
                
                
            } else if (cellDataObj.displayType == XvSetConstants.DISPLAY_TYPE_CHECKMARK){
                
                return CheckmarkCell(
                    style: .default,
                    reuseIdentifier: cellDataObj.key,
                    data: cellDataObj as! CheckmarkCellData)
                                
                
            } else if (cellDataObj.displayType == XvSetConstants.DISPLAY_TYPE_DISCLOSURE){
                
                //disclosure - leads to subview
                
                return DisclosureCell(
                    style: .value1,
                    reuseIdentifier: cellDataObj.key,
                    data: cellDataObj as! DisclosureCellData)
                
                
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

    //MARK: - PUBLIC API
    //MARK:   USER INPUT -
    
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
                    
                    if let key:String = getKey(fromCell: cell) {
                        
                        //deselect row so the grey background flashes
                        tableView.deselectRow(at: indexPath, animated: true)
                        
                        _checkmarkRowSelected(cell: cell, indexPath: indexPath)
                        
                        checkmarkRowSelected(cell: cell, key: key)
                        
                        
                        
                    } else {
                        print("SETTINGS: Checkmark cell data key could not be found")
                    }
                    
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
    
    //override by app settings classes, which check for app specific keys and execute app specific commands
    internal func disclosureRowSelected(cell:DisclosureCell, key:String){
        
    }
    
    internal func checkmarkRowSelected(cell:CheckmarkCell, key:String) {
        
        
        
        
    }
    
    //MARK: - Buttons cells
    internal func buttonRowSelected(cell:ButtonCell, key:String) {
        
        if (key == XvSetConstants.kKitArtificialIntelligence){
            
            Utils.postNotification(
                name: XvSetConstants.kKitResetAIButtonTapped,
                userInfo: nil)
            
        } else if (key == XvSetConstants.kKitFactorySettings){
            
            Utils.postNotification(
                name: XvSetConstants.kKitRestoreFactorySettingsButtonTapped,
                userInfo: nil)
        }
    }
    
    //MARK: - TOGGLE SWITCH
    
    internal func toggleSwitchChanged(_ sender:UISwitch) {
        
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
    internal func toggleSelected(isOn:Bool, key:String){
        
    }

    
    
    
    //MARK: - PUBLIC API -
    
    //MARK: LOAD
    
    public func load(withDataSource:TableData){
        
        if (debug){
            print("SETTINGS TABLE: Load data source", withDataSource)
        }
        
        self.dataSource = withDataSource
        title = withDataSource.title
    }
    
    
    //MARK:- ACCESSORS
    public func setNav(nav: UINavigationController) {
        self.nav = nav
    }
    
    internal func getNav() -> UINavigationController? {
        return nav
    }
    
    //MARK: - VC MANAGEMENT
    
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
    
    internal func loadKitTable(fromDataObj: NSManagedObject) {
        
        let setKitTableData:KitTableData = KitTableData(kitDataObj: fromDataObj)
        let vc:TableVC = TableVC()
        vc.load(withDataSource: setKitTableData)
        push(viewController: vc)
        
    }

    
    
    //MARK: Row / cell getters
    internal func getDisplayType(dataSource:TableData, indexPath:IndexPath) -> String {
        
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

    
    internal func getDisclosureCell(indexPath: IndexPath) -> DisclosureCell? {
        
        if let cell:DisclosureCell = tableView.cellForRow(at: indexPath) as? DisclosureCell {
            
            return cell
            
        } else {
            print("SETTINGS: Error finding SetMultiTable SetDisclosureCell")
            return nil
        }
        
    }
    
    internal func getCheckmarkCell(indexPath: IndexPath) -> CheckmarkCell? {
        
        if let cell:CheckmarkCell = tableView.cellForRow(at: indexPath) as? CheckmarkCell {
            
            return cell
            
        } else {
            print("SETTINGS: Error finding SetMultiTable SetCheckmarkCell")
            return nil
        }
        
        
    }
    
    fileprivate func getCheckmarkCells(inSection:Int) -> [CheckmarkCell]? {
        
        if let cells:[UITableViewCell] = getCells(inSection: inSection) {
            
            var checkmarkCells:[CheckmarkCell] = []
            
            for cell in cells {
                
                if let checkmarkCell:CheckmarkCell = cell as? CheckmarkCell {
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
    
    public func getButtonCell(indexPath: IndexPath) -> ButtonCell? {
        
        if let cell:ButtonCell = tableView.cellForRow(at: indexPath) as? ButtonCell {
            
            return cell
            
        } else {
            print("SETTINGS: Error finding SetMultiTable SetButtonCell")
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

    
    
    //MARK: - INTERNAL -
    
    //build out footers
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
    
    //user taps link is settings footer
    internal func footerWithLinkWasTapped(sender:UITapGestureRecognizer){
        
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
    
    //MARK: Checkmark
    //overridden in checkmark table class
    internal func _checkmarkRowSelected(cell: CheckmarkCell, indexPath:IndexPath) {
        
        if let data:CheckmarkCellData = cell.data as? CheckmarkCellData {
            
            //if not a multi cell, uncheck all others
            if (!data.multi){
                _turnOffCheckmarks(inSection: indexPath.section)
            }
            
            //turn this cell on in view and data
            cell.accessoryType = .checkmark
            data.selected = true
            
            Utils.postNotification(
                name: XvSetConstants.kSettingsPanelDefaultChanged,
                userInfo: [
                    "key" : data.key,
                    "value" : data.value as Any,
                    "level" : data.levelType
                ])
            
        } else {
            print("SETTINGS: Checkmark cell data is invalid")
        }
        
    }

    
    
    
    //MARK: - PRIVATE -
    //MARK: Checkmark
    
    fileprivate func _turnOffCheckmarks(inSection:Int){
        
        if let checkmarkCells:[CheckmarkCell] = getCheckmarkCells(inSection: inSection) {
            
            for cell in checkmarkCells {
                
                cell.accessoryType = .none
                
                if let data:CheckmarkCellData = cell.data as? CheckmarkCellData {
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
        if let toggleCellData:CellData = getToggleCellData(fromSwitch: fromSwitch) {
            
            //set cell data's default value to uiswitch value
            toggleCellData.value = fromSwitch.isOn
            
            Utils.postNotification(
                name: XvSetConstants.kSettingsPanelDefaultChanged,
                userInfo: [
                    "key" : toggleCellData.key,
                    "value" : fromSwitch.isOn as Any,
                    "level" : toggleCellData.levelType
                ])
            
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
    
    
    //TODO: refresh midi destinations?
    /*
     fileprivate func _refreshMidiDestinations(withCellData:DisclosureCellData){
     
     //refresh midi destination data
     XvMidi.sharedInstance.refreshMidiDestinations()
     
     //get names of currently available midi destinations
     let midiDestinationNames:[String] = XvMidi.sharedInstance.getMidiDestinationNames()
     
     //get indexes of user selected destinations
     let activeDestinationIndexes = XvMidi.sharedInstance.getActiveMidiDestinationIndexes()
     
     //init data obj with this up-to-date destination data
     withCellData.initSubArrays(values: midiDestinationNames, labels: midiDestinationNames)
     withCellData.setNewDefaults(newIndexes: activeDestinationIndexes)
     
     }
     */
    
    
    //MARK: - DEINT
    deinit {
        sectionFooterViews = nil
    }
    
}
