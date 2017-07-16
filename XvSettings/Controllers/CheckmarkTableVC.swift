//
//  XvSetCheckmarkTable.swift
//  XvSettings
//
//  Created by Jason Snell on 6/5/17.
//  Copyright © 2017 Jason J. Snell. All rights reserved.
//

import UIKit

//check mark tables are launched with a parent disclosure cell, rather than a data class. The data for the class is inside the incoming cell

public class CheckmarkTableVC:TableVC {

    //parent cell that launched this table
    var parentDisclosureCell:DisclosureCell?
    
    //MARK: - BUILD
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        //refresh control
        buildRefreshControl()
        
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        
        if let checkmarkTableData:CheckmarkTableData = dataSource as? CheckmarkTableData {
            
            if (checkmarkTableData.key == XvSetConstants.kAppGlobalMidiSources){
                
                Utils.postNotification(
                    name: XvSetConstants.kAppGlobalMidiSourcesRequest,
                    userInfo: ["checkmarkTableVC" : self])
            
            } else if (checkmarkTableData.key == XvSetConstants.kAppGlobalMidiDestinations){
                
                Utils.postNotification(
                    name: XvSetConstants.kAppGlobalMidiDestinationsRequest,
                    userInfo: ["checkmarkTableVC" : self])
            
            } else if (checkmarkTableData.key == XvSetConstants.kInstrumentMidiDestinations){
                
                Utils.postNotification(
                    name: XvSetConstants.kInstrumentMidiDestinationsRequest,
                    userInfo: ["checkmarkTableVC" : self])
            }
        }
        
        super.viewWillAppear(animated)
    }
    
    internal func load(withParentDisclosureCell:DisclosureCell){
        
        //retain parent cell for detailTextLabel updates during checkmark selections in the sub table
        self.parentDisclosureCell = withParentDisclosureCell
        
        //load the super class with the data stored in the disclosure cell
        
        //if parent cell data is valid...
        if let parentDisclosureCellData:DisclosureCellData = withParentDisclosureCell.data as? DisclosureCellData {
            
            //if table data is valid...
            if let checkmarkTableDataSource = parentDisclosureCellData.checkmarkTableDataSource {
                
                //load super class
                self.load(withDataSource: checkmarkTableDataSource)
                
            } else {
                print("SETTINGS: Checkmark table data source invalid during load")
            }
            
        } else {
            print("SETTINGS: Parent disclosure cell's data is invalid during load")
        }
    }
    
    
    public func reloadTableAfterMidiUpdate(){
        
        if let checkmarkTableData:CheckmarkTableData = dataSource as? CheckmarkTableData {
            
            if (checkmarkTableData.key == XvSetConstants.kAppGlobalMidiSources){
                
                if let globalMidiSourcesData:GlobalMidiSourcesData = checkmarkTableData as? GlobalMidiSourcesData {
                    
                    //refresh table data
                    globalMidiSourcesData.refresh()
                    
                    // reload this table vc with new data
                    load(withDataSource: globalMidiSourcesData)
                    
                } else {
                    
                    print("SETTINGS: Unable to cast checkmark table data as GlobalMidiSourcesData during reloadTableAfterMidiUpdate")
                }
                
            } else if (checkmarkTableData.key == XvSetConstants.kAppGlobalMidiDestinations){
                
                if let globalMidiDestinationsData:GlobalMidiDestinationsData = checkmarkTableData as? GlobalMidiDestinationsData {
                    
                    //refresh table data
                    globalMidiDestinationsData.refresh()
                    
                    // reload this table vc with new data
                    load(withDataSource: globalMidiDestinationsData)
                    
                } else {
                    
                    print("SETTINGS: Unable to cast checkmark table data as GlobalMidiSourcesData during reloadTableAfterMidiUpdate")
                }
            
            } else if (checkmarkTableData.key == XvSetConstants.kInstrumentMidiDestinations){
                
                if let instrumentMidiDestinationsData:InstrumentMidiDestinationsData = checkmarkTableData as? InstrumentMidiDestinationsData {
                    
                    //refresh table data
                    instrumentMidiDestinationsData.refresh()
                    
                    // reload this table vc with new data
                    load(withDataSource: instrumentMidiDestinationsData)
                    
                } else {
                    
                    print("SETTINGS: Unable to cast checkmark table data as InstrumentMidiDestinationsData during reloadTableAfterMidiUpdate")
                }
            }
            
            //reload data on tableview
            tableView.reloadData()
            
        } else {
            
            print("SETTINGS: Unable to cast table data as checkmark table data during reloadTableAfterMidiUpdate")
        }
        
    }

    
    
    
    
    //MARK: - REFRESH CONTROL
    
    fileprivate func buildRefreshControl(){
        
        //only add refresh controls on midi checkmark tables
        if let checkmarkTableData:CheckmarkTableData = dataSource as? CheckmarkTableData {
            
            if (checkmarkTableData.key == XvSetConstants.kAppGlobalMidiSources ||
                checkmarkTableData.key == XvSetConstants.kAppGlobalMidiDestinations ||
                checkmarkTableData.key == XvSetConstants.kInstrumentMidiDestinations){
                
                // set up the refresh control
                let refreshControl:UIRefreshControl = UIRefreshControl()
                refreshControl.addTarget(self, action: #selector(refresh(_:)), for: UIControlEvents.valueChanged)
                tableView.addSubview(refreshControl)
            }
        }
    }
    
    internal func refresh(_ sender:AnyObject) {
       
        if (debug){
            print("SETTINGS: Refresh table")
        }
        
        if let checkmarkTableData:CheckmarkTableData = dataSource as? CheckmarkTableData {
            
            if (checkmarkTableData.key == XvSetConstants.kAppGlobalMidiSources){
                
                Utils.postNotification(
                    name: XvSetConstants.kAppGlobalMidiSourcesRequest,
                    userInfo: ["checkmarkTableVC" : self])
            
            } else if (checkmarkTableData.key == XvSetConstants.kAppGlobalMidiDestinations){
                
                Utils.postNotification(
                    name: XvSetConstants.kAppGlobalMidiDestinationsRequest,
                    userInfo: ["checkmarkTableVC" : self])
            
            } else if (checkmarkTableData.key == XvSetConstants.kInstrumentMidiDestinations){
                
                Utils.postNotification(
                    name: XvSetConstants.kInstrumentMidiDestinationsRequest,
                    userInfo: ["checkmarkTableVC" : self])
            }
        }
        
        if let refreshControl:UIRefreshControl = sender as? UIRefreshControl {
            refreshControl.endRefreshing()
        }
    }
    
    
    //MARK: - USER INPUT
    
    //when the local checkmark func is executed, update the parent cells detailTextLabel on non-multi tables
    override internal func checkmarkRowSelected(cell: CheckmarkCell, indexPath:IndexPath) {
        
        super.checkmarkRowSelected(cell: cell, indexPath: indexPath)
        
        if let cellData:CheckmarkCellData = cell.data as? CheckmarkCellData {
            
            if (!cellData.multi) {
                
                //if there is a parent cell...
                if (parentDisclosureCell != nil){
                    
                    //if parent cell data is valid...
                    if let parentDisclosureCellData:DisclosureCellData = parentDisclosureCell!.data as? DisclosureCellData {
                        
                        //update detail text label
                        parentDisclosureCellData.updateDetailTextLabel(withRow: indexPath.row)
                        
                        //update view
                        parentDisclosureCell!.set(label: parentDisclosureCellData.detailTextLabel)
                        
                    } else {
                        print("SETTINGS: Error: Parent cell data is invalid during checkmarkRowSelected")
                    }
                }
            }
            
            
            //post notifications for checkmark tables based on key
            
            if (cellData.key == XvSetConstants.kAppMidiSync) {
                
                Utils.postNotification(
                    name: XvSetConstants.kAppMidiSyncChanged,
                    userInfo: nil
                )
            
            } else if (cellData.key == XvSetConstants.kAppGlobalMidiSources){
                
                Utils.postNotification(
                    name: XvSetConstants.kAppGlobalMidiSourcesChanged,
                    userInfo: nil
                )
                
            } else if (cellData.key == XvSetConstants.kAppMusicalScale){
                
                Utils.postNotification(
                    name: XvSetConstants.kAppMusicalScaleChanged,
                    userInfo: nil
                )
            }
            
        } else {
            print("SETTINGS: Error: Unable to get checkmark cell data during checkmarkRowSelected")
        }
    }

}
