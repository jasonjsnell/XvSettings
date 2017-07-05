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
        
        _refreshTableDisplay(fromCheckmarkCell: cell)
        
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
        
        } else if (key == XvSetConstants.kKitRearrange){
            
            Utils.postNotification(
                name: XvSetConstants.kKitRearrangeButtonTapped,
                userInfo: nil)
        }
    }
    
    //MARK: - SLIDER
    
    //update the text label when the slider is being dragged
    internal func sliderChanged(_ sender:UISlider) {
        
        if let sliderCell:SliderCell = sender.superview?.superview as? SliderCell {
            
            let _:Any? = sliderCell.set(withSliderValue: sender.value)
            
        } else {
            
            print("SETTINGS: Error getting sliderCell during sliderChanged")
        }
        
    }
    
    //save the slider value when the user has released it
    internal func sliderEnded(_ sender:UISlider) {
        
        if let sliderCell:SliderCell = sender.superview?.superview as? SliderCell {
            
            if let sliderCellData:SliderCellData = sliderCell.data as? SliderCellData {
                
                if let newValue:Any = sliderCell.set(withSliderValue: sender.value) {
                    
                    _setCoreData(
                        level: sliderCellData.levelType,
                        value: newValue,
                        key: sliderCellData.key,
                        multi: false)
                    
                    //if there is a linked cell...
                    if let linkedSliderCellData:SliderCellData = sliderCellData.linkedSliderCellData {
                        
                        //save its data too
                        _setCoreData(
                            level: linkedSliderCellData.levelType,
                            value: linkedSliderCellData.value,
                            key: linkedSliderCellData.key,
                            multi: false)
                        
                    }
                    
                }
                
            } else {
                
                print("SETTINGS: Error getting sliderCellData during sliderChanged")
            }
            
        } else {
            
            print("SETTINGS: Error getting sliderCell during sliderChanged")
        }
    }


    


    //MARK: - TOGGLE SWITCH

    internal func toggleSwitchChanged(_ sender:UISwitch) {
        
        _updateValues(fromSwitch: sender)
        _refreshTableDisplay(fromSwitch: sender)
        
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
        
        if let _nav:UINavigationController = getNav() {
            
            let kitTableData:KitTableData = KitTableData(kitDataObj: fromDataObj)
            let vc:KitTableVC = KitTableVC()
            vc.load(withDataSource: kitTableData)
            vc.setNav(nav: _nav)
            push(viewController: vc)
            
        } else {
            
            print("SETTINGS: Nav is nil during loadKitTable. Blocking push")
        }
    }
    
    internal func loadInstrumentTable(fromDataObj: NSManagedObject) {
        
        if let _nav:UINavigationController = getNav() {
            
            let instrTableData:InstrumentTableData = InstrumentTableData(instrumentDataObj: fromDataObj)
            let vc:InstrumentTableVC = InstrumentTableVC()
            vc.load(withDataSource: instrTableData)
            vc.setNav(nav: _nav)
            push(viewController: vc)
            
        } else {
            
            print("SETTINGS: Nav is nil during loadInstrumentTable. Blocking push")
        }
        
    }

    
    
    //MARK: - GETTERS
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

    
    
    //MARK: - INTERNAL -
    
    //MARK: Footer
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
        
        if let checkmarkCellData:CheckmarkCellData = cell.data as? CheckmarkCellData {
            
            //grab value from cell data
            var _value:Any = checkmarkCellData.value
            
            //if a multi cell...
            if (checkmarkCellData.multi){
                
                //if not current checked...
                if (!checkmarkCellData.selected){
                    
                    //turn this cell on in view and data
                    cell.accessoryType = .checkmark
                    checkmarkCellData.selected = true
                
                } else {
                    
                    //else if currently checked...
                    //turn off cell and data
                    cell.accessoryType = .none
                    checkmarkCellData.selected = false
                }
                
                
                _value = _getArrayOfValues(level: checkmarkCellData.levelType, key: checkmarkCellData.key, value: checkmarkCellData.value)
                
            } else {
                
                //if not a multi cell...
            
                //uncheck all others
                _turnOffCheckmarks(inSection: indexPath.section)
                
                //and check this one
                cell.accessoryType = .checkmark
                checkmarkCellData.selected = true
            }
            
            _setCoreData(
                level: checkmarkCellData.levelType,
                value: _value,
                key: checkmarkCellData.key,
                multi: checkmarkCellData.multi)
            
        } else {
            print("SETTINGS: Checkmark cell data is invalid")
        }
        
    }

    
    
    
    //MARK: - PRIVATE -
    //MARK: Checkmark
    
    
    
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
        
        //1. get existing values based on level type (app, kit, instrument)
        //var to populate and return
        var existingValueArray:[Any] = []
        
        if (level == XvSetConstants.LEVEL_TYPE_APP) {
            
            // if app...
            if let app:NSManagedObject = xvcdm.getApp() {
                
                // get value for key with this kit
                if let existingAppValue:Any = xvcdm.getAny(forKey: key, forObject: app) {
                    
                    //is this value an array?
                    if let existingAppValueArray:[Any] = existingAppValue as? [Any] {
                        
                        existingValueArray = existingAppValueArray
                    }
                    
                } else {
                    
                    print("SETTINGS: Error getting app value during _getArrayOfValues")
                }
                
            } else {
                
                print("SETTINGS: Error getting app during _getArrayOfValues")
            }
            
        } else if (level == XvSetConstants.LEVEL_TYPE_KIT) {
            
            // if kit...
            if let currKit:NSManagedObject = xvcdm.getCurrKit() {
                
                // get value for key with this kit
                if let existingKitValue:Any = xvcdm.getAny(forKey: key, forObject: currKit) {
                    
                    //is this value an array?
                    if let existingKitValueArray:[Any] = existingKitValue as? [Any] {
                        
                        existingValueArray = existingKitValueArray
                    }
                    
                } else {
                    
                    print("SETTINGS: Error getting curr kit value during _getArrayOfValues")
                }
                
            } else {
                
                print("SETTINGS: Error getting curr kit during _getArrayOfValues")
            }
            
        } else if (level == XvSetConstants.LEVEL_TYPE_INSTRUMENT) {
            
            // if instrument...
            if let currInstrument:NSManagedObject = xvcdm.getCurrInstrument() {
                
                // get value for key with this instrument
                if let existingInstrumentValue:Any = xvcdm.getAny(forKey: key, forObject: currInstrument) {
                    
                    //is this value an array?
                    if let existingInstrumentValueArray:[Any] = existingInstrumentValue as? [Any] {
                        
                        existingValueArray = existingInstrumentValueArray
                    }
                    
                } else {
                    
                    print("SETTINGS: Error getting curr instrument value during _getArrayOfValues")
                }
                
            } else {
                
                print("SETTINGS: Error getting curr instrument during _getArrayOfValues")
            }
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

    
    
    
    //MARK: Toggle
    
    //update toggle cell's default value and the correspond user default
    fileprivate func _updateValues(fromSwitch:UISwitch){
        
        //if cell data is valid...
        if let toggleCellData:CellData = getToggleCellData(fromSwitch: fromSwitch) {
            
            //set cell data's default value to uiswitch value
            toggleCellData.value = fromSwitch.isOn
            
            _setCoreData(
                level: toggleCellData.levelType,
                value: fromSwitch.isOn,
                key: toggleCellData.key,
                multi: false)
            
        } else {
            
            print("SETTINGS: Error getting toggleCellData during _updateValues")
        }
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
    
    
    //MARK: - Core Data
    
    

    fileprivate func _setCoreData(level:String, value:Any, key:String, multi:Bool){
        
        if (debug){
            print("SETTINGS: TableVC: Set CoreData", level, value, key, multi)
        }
        
        //set core data value based on level (app, kit, or instrument)
        
        if (level == XvSetConstants.LEVEL_TYPE_APP){
        
            xvcdm.setApp(value: value, forKey: key)
            
        } else if (level == XvSetConstants.LEVEL_TYPE_KIT){
            
            xvcdm.setCurrKit(value: value, forKey: key)
            
        } else if (level == XvSetConstants.LEVEL_TYPE_INSTRUMENT){
            
            xvcdm.setCurrInstrument(value: value, forKey: key)
        }
        
        let _:Bool = xvcdm.save()
        
    }
    
    //MARK: - DEINT
    deinit {
        sectionFooterViews = nil
    }
    
}
