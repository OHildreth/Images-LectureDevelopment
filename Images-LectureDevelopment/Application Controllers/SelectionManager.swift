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
    func deselectAll() {
        selectedImageItemIDs = []
        selectedNodes = []
    }
}






