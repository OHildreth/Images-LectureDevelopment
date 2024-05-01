//
//  SelectionManager.swift
//  Images-LectureDevelopment
//
//  Created by Owen Hildreth on 3/5/24.
//

import Foundation
import OrderedCollections


@Observable
class SelectionManager {
    
    @ObservationIgnored var delegate: SelectionManagerDelegate?
    
    var selectedNodes: Set<Node> = [] {
        didSet { delegate?.selectedNodesDidChange(selectedNodes) }
    }
    
    
    var selectedImageItemIDs: Set<ImageItem.ID> = [] {
        didSet { delegate?.selectedImageItemsDidChange(selectedImageItemIDs) }
    }
    
    func newData(nodes: [Node], andImages imageItems: [ImageItem]) {
        
        // A single new node has been added.  Make that the selection
        if let firstNode = nodes.first {
            if firstNode.name == Node.defaultName {
                selectedNodes = [firstNode]
                return
            }
        }

        
        // Only image items have been created.  Update the imageItems
        if !nodes.isEmpty {
            
            let imageItemIDs = imageItems.map( {$0.id} )
            
            if imageItems.isEmpty {
                return
            }
            
            let completeSelection = selectedImageItemIDs.union(imageItemIDs)
            selectedImageItemIDs = completeSelection
            return
        } else {
            // Only update selection of the selectedNodes
            let completeSelection = selectedNodes.union(nodes)
            
            selectedNodes = completeSelection
        }
    }
    
    // ADD
    func preparingToDelete(nodes: [Node]) {
        // Next Clear out any deleted Nodes
        if nodes.count > 0 {
            let remainingNodes = selectedNodes.subtracting(nodes)
            selectedNodes = remainingNodes
            return
        }

    }
    
    // ADD
    func preparingToDelete(imageItems: [ImageItem]) {
        // Next Clear out any deleted Nodes
        if imageItems.count > 0 {
            let imageItemIDsToDeleted = imageItems.map( {$0.id} )
            
            let remiainingIds = selectedImageItemIDs.subtracting(imageItemIDsToDeleted)
            selectedImageItemIDs = remiainingIds
            return
        }
    }
    
    // ADD Menu
    func deselectAll() {
        selectedImageItemIDs = []
        selectedNodes = []
    }
}






