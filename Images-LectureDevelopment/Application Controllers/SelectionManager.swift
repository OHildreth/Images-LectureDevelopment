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
    
    // UPDATE to use ImageItem.ID
    var selectedImageItemIDs: Set<ImageItem.ID> = [] {
        didSet { delegate?.selectedImageItemsDidChange(selectedImageItemIDs) }
    }
}


protocol SelectionManagerDelegate {

    func selectedNodesDidChange(_ nodes: Set<Node>)
    
    // UPDATE to use ImageItem.ID
    func selectedImageItemsDidChange(_ imageItemsIDs: Set<ImageItem.ID>)
}
