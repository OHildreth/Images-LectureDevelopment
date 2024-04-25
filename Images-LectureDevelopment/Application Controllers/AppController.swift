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
    
    var sourceListViewModel: SourceListViewModel
    
    init() {
        
        let localDataModel = DataModel(withDelegate: nil)
        
        let localSelectionManager = SelectionManager()
        
        dataModel = localDataModel
        selectionManager = localSelectionManager

        imageContentViewModel = ImageContentViewModel(dataModel: localDataModel, selectionManager: localSelectionManager)
        
        // ADD
        sourceListViewModel = SourceListViewModel(dataModel: localDataModel, selectionManager: localSelectionManager)
        
        // Accessing self must be done after all variables are initialized
        localSelectionManager.delegate = self
        
        localDataModel.delegate = self
    }
    
}

// ADD
extension AppController: DataModelDelegate {
    func newData(nodes: [Node], andImages imageItems: [ImageItem]) {
        // Pass the information down to the Selection Manager because the selectionManager is responsible for knowing how selection state should be udpated
        selectionManager.newData(nodes: nodes, andImages: imageItems)
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
