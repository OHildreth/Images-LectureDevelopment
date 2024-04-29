//
//  SourceListViewModel.swift
//  Images-LectureDevelopment
//
//  Created by Owen Hildreth on 4/24/24.
//

import Foundation

@Observable
class SourceListViewModel {
    
    private var dataModel: DataModel
    private var selectionManager: SelectionManager
    
    
    var selection: Set<Node> {
        get { selectionManager.selectedNodes }
        set { selectionManager.selectedNodes = newValue }
    }
    
    var rootNodes: [Node] {
        dataModel.rootNodes
    }
    
    var presentURLImportError = false
    
    var sort: [KeyPathComparator<ImageItem>] = [.init(\.name), .init(\.nodeName)]
    
    // MARK: - Initialization
    init(dataModel: DataModel, selectionManager: SelectionManager) {
        self.dataModel = dataModel
        self.selectionManager = selectionManager
    }
}


extension SourceListViewModel {
    
    func shouldAllowDrop(ofURLs urls: [URL]) -> Bool {
        
        if urls.count == 0 { return false }
        
        let numberOfNodes = selectionManager.selectedNodes.count
                
        switch numberOfNodes {
        case 0: return false
        case 1: return true
        default: return false
        }
    }
    
    func importURLs(_ urls: [URL], intoNode parentNode: Node?) -> Bool {
        do {
            try dataModel.importURLs(urls, intoNode: parentNode)
            
            return true
        } catch {
            if let importError = error as? DataModel.ImportError {
                if importError == .cannotImportFileWithoutANode {
                    self.presentURLImportError = true
                    return false
                }
            }
            return false
        }
    }
    
    
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

// MARK: - Deleting and Adding Nodes
extension SourceListViewModel {
    func deleteSelectedNodes() {
        let nodes = Array(selection)
        dataModel.delete(nodes)
    }
    
    func createEmptyNode(withParent parent: Node?) {
        dataModel.createEmptyNode(withParent: parent)
    }
}
