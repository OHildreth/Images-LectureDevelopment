//
//  DataModel_Deleting.swift
//  Images-LectureDevelopment
//
//  Created by Owen Hildreth on 4/29/24.
//

import Foundation

// MARK: - Delete
extension DataModel {
    
    func delete(_ nodes: [Node]) {
        // ADD
        delegate?.preparingToDelete(nodes: nodes)
        
        for nextNode in nodes {
            modelContext.delete(nextNode)
        }
        try? modelContext.save()
        
        fetchData()
    }
    
    // ADD Menu
    func delete(_ imageItems: [ImageItem]) {
        
        // ADD
        delegate?.preparingToDelete(imageItems: imageItems)
        
        for nextItem in imageItems {
            modelContext.delete(nextItem)
        }
        
        try? modelContext.save()
        
        fetchData()
    }
    
    // ADD Menu
    func delete(_ imageItems: [ImageItem], andThenTheNodes nodes: [Node]) {
        
        // It is important to delete the ImageItems first so that the selection manager removes the image items from the selection.
        if imageItems.count > 0 {
            delete(imageItems)
            return
        }
        
        if nodes.count > 0 {
            delete(nodes)
            return
        }
    }
}
