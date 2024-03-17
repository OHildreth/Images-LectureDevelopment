//
//  AppController.swift
//  Images-LectureDevelopment
//
//  Created by Owen Hildreth on 3/5/24.
//

import Foundation

@Observable
class AppController {
    var dataModel: DataModel
    var selectionManager: SelectionManager
    
    var selectedNodes: Array<Node> = []
    
    init() {
        dataModel = DataModel()
        selectionManager = SelectionManager()
        selectionManager.delegate = self
    }
    
}


extension AppController: SelectionManagerDelegate {
    func selectedNodesDidChange(_ nodes: Set<Node>) {
        let sort = SortDescriptor<Node>(\.name)
        dataModel.selectedNodes = Array(nodes).sorted(using: sort)
    }
}
