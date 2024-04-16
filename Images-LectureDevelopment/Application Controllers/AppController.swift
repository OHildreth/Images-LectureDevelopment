//
//  AppController.swift
//  Images-LectureDevelopment
//
//  Created by Owen Hildreth on 3/5/24.
//

import Foundation
// ADD
import OrderedCollections

@Observable
class AppController {
    var dataModel: DataModel
    var selectionManager: SelectionManager
    
    // ADD
    var imageContentViewModel: ImageContentViewModel
    
    init() {
        // UPDATE
        
        let localDataModel = DataModel()
        let localSelectionManager = SelectionManager()
        
        dataModel = localDataModel
        selectionManager = localSelectionManager
        
        
        imageContentViewModel = ImageContentViewModel(dataModel: localDataModel, selectionManager: localSelectionManager)
        
        // Accessing self must be done after all variables are initialized
        localSelectionManager.delegate = self
    }
    
}


extension AppController: SelectionManagerDelegate {
    
    
    func selectedNodesDidChange(_ nodes: Set<Node>) {
        let sort = SortDescriptor<Node>(\.name)
        dataModel.selectedNodes = Array(nodes).sorted(using: sort)
    }
    
    // UPDATE to use ImageItem.ID
    func selectedImageItemsDidChange(_ imageItemsIDs: Set<ImageItem.ID>) {
        // UPDATE
        dataModel.selectedImageItemIDs = Array(imageItemsIDs)
    }
}
