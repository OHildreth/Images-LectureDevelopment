//
//  DataModel.swift
//  Images-LectureDevelopment
//
//  Created by Owen Hildreth on 2/2/24.
//

import Foundation
import SwiftUI
import SwiftData
// ADD
import OrderedCollections

@Observable
class DataModel {
    
    private var container: ModelContainer
    
    var modelContext: ModelContext
    
    var rootNodes: [Node] = []
    
    var sortNodesKeyPaths: [KeyPathComparator<Node>] = [
        .init(\.name)]
    
    // This is temporary and used to make the visibleItems a computed property
    // TODO: Remove when visibleItems transitioned to stored property that is updated manually
    @Transient
    var selectedNodes: [Node] = []
    
    // @Transient is used to tell SwiftData that this property should not be stored
    @Transient
    var visableItems: [ImageItem] {
        
        // For initial simplicity, we will make this a computed property
        // TODO: Switch visibleItems to stored property that is updated manually
        get {
            // UPDATE
            // Make this an OrderedSet to ensure that items aren't duplicated
            var items: OrderedSet<ImageItem> = []
            
            for nextNode in selectedNodes {
                items.append(contentsOf: nextNode.flattenedImageItems())
            }
            
            // UPDATE
            return Array(items)
        }
    }
    
    
    init() {
        let sharedModelContainer: ModelContainer = {
            let schema = Schema([
                Item.self, Node.self, ImageItem.self
            ])
            let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

            do {
                return try ModelContainer(for: schema, configurations: [modelConfiguration])
            } catch {
                fatalError("Could not create ModelContainer: \(error)")
            }
        }()
        
        container = sharedModelContainer
        
        modelContext = ModelContext(sharedModelContainer)
        
    }
    
    
    // MARK: - Fetching Data
    func fetchData() {
        do {
            let sortOrder = [SortDescriptor<Node>(\.name)]
            let predicate = #Predicate<Node>{ $0.nodeType == 0}
            
            let descriptor = FetchDescriptor<Node>(predicate: predicate, sortBy: sortOrder)
            rootNodes = try modelContext.fetch(descriptor)
        } catch {
            print("Fetch failed")
        }
    }
}
