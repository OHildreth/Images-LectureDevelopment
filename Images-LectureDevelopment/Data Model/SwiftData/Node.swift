//
//  Node.swift
//  Images-LectureDevelopment
//
//  Created by Owen Hildreth on 1/24/24.
//

import Foundation
import SwiftData

// https://www.hackingwithswift.com/quick-start/swiftdata/how-to-create-many-to-many-relationships

// https://www.hackingwithswift.com/quick-start/swiftdata/how-to-create-one-to-many-relationships

@Model
final class Node: Identifiable, Hashable {
    var id: UUID
    
    var name: String
    
    @Relationship(deleteRule: .cascade, inverse: \ImageItem.node)
    var items: [ImageItem]
    
    
    var parent: Node? {
        didSet {
            setNodeType()
            print("parent of: \(self.name) set to \(parent?.name)")
        }
    }
    
    @Relationship(deleteRule: .cascade, inverse: \Node.parent)
    var subNodes: [Node]?
    
    // We need to store nodeType so that we can only pull in the root nodes
    // Normally, I would store this as an enum.  However, hard to use in Query predicates, so I'll store the values as an integer
        
    /// Determines if the node is a Root (nodeType == 0, and there is no parent node) or if it is a child (nodeType != 0 and there is a parent node)
    /// This needs to be a stored property because we can't search against nil in an @Query's predicate.  Since we can't search that parent == nil during the @Query's predicate, we will store this value as a nodetype.
    var nodeType: Int
    
    // UPDATE.  Make name optional and use default Name
    init(_ name: String?, _ parent: Node?) {
        self.id = UUID()
         // UPDATE
        self.name = name ?? Node.defaultName
        self.parent = parent
        self.items = []
        self.subNodes = []
        if parent != nil {
            nodeType = 1
        } else {
            nodeType = 0
        }
    }
    
    convenience init(withURL url: URL, _ parent: Node?) {
        let urlName =  url.deletingPathExtension().lastPathComponent
        
        self.init(urlName, parent)
    }
    

    private func setNodeType() {
        if parent == nil {
            self.nodeType = 0
        } else {
            self.nodeType = 1
        }
        
        print("Node Type = \(nodeType)")
    }
    
    func flattenedImageItems() -> [ImageItem] {
        var localItems: [ImageItem] = self.items
        
        guard let localSubNodes = self.subNodes else {
            return localItems
        }
        
        for nextSubNode in localSubNodes {
            localItems.append(contentsOf: nextSubNode.flattenedImageItems())
        }
        
        return localItems
    }
}

/*
 // Codable is needed to be compatible with SwiftData
 enum NodeType: Int, Identifiable, Codable {
     var id: Self { self }
     
     case rootNode = 0
     case childNode = 1
 }
 */

// ADD
extension Node {
    static let defaultName = "New Node"
}
