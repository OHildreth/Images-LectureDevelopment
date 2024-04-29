//
//  ImageContentViewModel.swift
//  Images-LectureDevelopment
//
//  Created by Owen Hildreth on 4/13/24.
//

import Foundation

// ADD
import SwiftUI
import SwiftData
import OrderedCollections

@Observable
class ImageContentViewModel {
    
    private var dataModel: DataModel
    private var selectionManager: SelectionManager
    
    var selection: Set<ImageItem.ID> {
        /*
         didSet {
             selectionManager.selectedImageItemIDs = selection
         }
         */
        get { selectionManager.selectedImageItemIDs }
        set { selectionManager.selectedImageItemIDs = newValue }
    }
    
    var imageItems: [ImageItem] {
        visibleItems()
    }
    
    // ADD
    var selectedImageItems: [ImageItem] {
        dataModel.selectedImageItems
    }
    
    // ADD
    var presentURLImportError = false
    
    
    var sort: [KeyPathComparator<ImageItem>] = [.init(\.name), .init(\.nodeName)]
    
    
    // MARK: - Initialization
    init(dataModel: DataModel, selectionManager: SelectionManager) {
        self.dataModel = dataModel
        self.selectionManager = selectionManager
    }
    
    
    // MARK: - Items
    private func visibleItems() -> [ImageItem] {
        var items: OrderedSet<ImageItem> = []
        
        for nextNode in dataModel.selectedNodes {
            items.append(contentsOf: nextNode.flattenedImageItems())
        }
        
        return Array(items).sorted(using: sort)
    }
}

// ADD
// MARK: - Drag and Drop
extension ImageContentViewModel {
    func shouldAllowDrop(ofURLs urls: [URL]) -> Bool {
        
        if urls.count == 0 { return false }
        
        let numberOfNodes = selectionManager.selectedNodes.count
                
        switch numberOfNodes {
        case 0: return false
        case 1: return true
        default: return false
        }
    }
    
    // ADD
    func importURLs(_ urls: [URL]) -> Bool {
        
        if shouldAllowDrop(ofURLs: urls) == false {
            self.presentURLImportError = true
            return false
        }
        
        guard let parentNode = selectionManager.selectedNodes.first else {return false}
        
        do {
            try dataModel.importURLs(urls, intoNode: parentNode)
            return true
        } catch {
            self.presentURLImportError = true
            return false
        }
    }
}


// MARK: - Handling ImageGrid Selection
extension ImageContentViewModel {
    func imageItemTapped(_ item: ImageItem) {
        selection  = Set(arrayLiteral: item.id)
    }
    
    func imageTappedWithModifiers(_ item: ImageItem, modifiers: EventModifiers) {
        if modifiers.contains([.control, .command, .shift]) {
            if selectionManager.selectedImageItemIDs.contains(item.id) {
                selection.remove(item.id)
            } else {
                selection.insert(item.id)
            }

        } else {
            selection = Set(arrayLiteral: item.id)
        }
        
        
    }
    
    func itemIsSelected(_ item: ImageItem) -> Bool {
        selectionManager.selectedImageItemIDs.contains(item.id) ? true : false
    }
}
