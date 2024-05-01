//
//  MenuBarViewModel.swift
//  Images-LectureDevelopment
//
//  Created by Owen Hildreth on 4/29/24.
//

import Foundation
import SwiftData
import Cocoa

@Observable
class MenuBarViewModel {
    var dataModel: DataModel
    var selectionManager: SelectionManager
    
    init(dataModel: DataModel, selectionManager: SelectionManager) {
        self.dataModel = dataModel
        self.selectionManager = selectionManager
    }
    
    // MARK: - Importing
    func importButtonAction() {
        
        // Check to see how many nodes are selected
        
        let selectedNodes = self.selectionManager.selectedNodes
        
        if selectedNodes.count > 1 { return }
        
        let parentNode = selectedNodes.first
        
        let panel = NSOpenPanel()
        panel.canChooseFiles = true
        panel.canChooseDirectories = true
        panel.allowsMultipleSelection = true
        
        if panel.runModal() == .OK {
            let urls = panel.urls
                
            try? dataModel.importURLs(urls, intoNode: parentNode)
        }
    }
    
    var importButtonIsDisabled: Bool {
        let numberOfNodes = selectionManager.selectedNodes.count
                
        if numberOfNodes > 1 {
            return true
        } else {
            return false
        }
    }
    
    var importHelp: String {
        let numberOfSelectedNodes = self.dataModel.selectedNodes.count
        
        switch numberOfSelectedNodes {
        case 0: return "Import New Files and Directories"
        case 1: return "Import New Files and Directories"
        default: return "Please Select only one Folder from SideBar"
        }
        
    }
    
    
    // MARK: - Delete
    func deleteButtonAction() {
        let imageItemsToDelete = Array(self.dataModel.selectedImageItems)
        let nodesToDelete = Array(self.dataModel.selectedNodes)
        
        dataModel.delete(imageItemsToDelete, andThenTheNodes: nodesToDelete)
    }
    
    var deleteButtonIsDisabled: Bool {
        let imageItemsCount = self.dataModel.selectedImageItems.count
        let nodesCount = self.dataModel.selectedNodes.count
        
        if imageItemsCount == 0 && nodesCount == 0 {
            return true
        } else {
            return false
        }
    }
    
    var deleteHelp: String {
        let imageItemsCount = self.dataModel.selectedImageItems.count
        let nodesCount = self.dataModel.selectedNodes.count
        
        if imageItemsCount == 0 && nodesCount == 0 {
            return "Select Something to Delete"
        } else {
            return "Delete \(nodesCount) Folders and \(imageItemsCount) Images"
        }
    }
    
    
    // MARK: - Deselect
    func deselectButtonAction() {
        selectionManager.deselectAll()
    }
    
    
    var deselectButtonIsDisabled: Bool {
        let imageItemsCount = self.dataModel.selectedImageItems.count
        let nodesCount = self.dataModel.selectedNodes.count
        
        if imageItemsCount == 0 && nodesCount == 0 {
            return true
        } else {
            return false
        }
    }
    
    var deselectAllHelp: String {
        if deselectButtonIsDisabled {
            return "Nothing to deselect"
        } else {
            return "Deselect All Folders and Images"
        }
    }
}
