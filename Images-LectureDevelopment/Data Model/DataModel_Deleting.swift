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
        for nextNode in nodes {
            modelContext.delete(nextNode)
        }
        try? modelContext.save()
        
        fetchData()
    }
    
    // ADD Menu
    func delete(_ imageItems: [ImageItem]) {
        for nextItem in imageItems {
            modelContext.delete(nextItem)
        }
        
        try? modelContext.save()
        
        fetchData()
    }
    
    // ADD Menu
    func delete(_ imageItems: [ImageItem], andThenTheNodes nodes: [Node]) {
        delete(imageItems)
        delete(nodes)
    }
}
