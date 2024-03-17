//
//  SelectionManager.swift
//  Images-LectureDevelopment
//
//  Created by Owen Hildreth on 3/5/24.
//

import Foundation

// SwiftData uses the @Observable Macro, so we will use that throughout our project
@Observable
class SelectionManager {
    
    // Views don't interact with the delegate and this property isn't likely to change in a manner tha requires observation
    @ObservationIgnored var delegate: SelectionManagerDelegate?
    
    // Let the delegate know that the node selection has changed
    var selectedNodes: Set<Node> = [] {
        didSet {
            for nextNode in selectedNodes {
                print(nextNode.name)
            }
            
            delegate?.selectedNodesDidChange(selectedNodes)
        }
    }
    
}


protocol SelectionManagerDelegate {
    func selectedNodesDidChange(_ nodes: Set<Node>)
}
