//
//  SelectionManagerDelegate.swift
//  Images-LectureDevelopment
//
//  Created by Owen Hildreth on 4/15/24.
//

import Foundation


protocol SelectionManagerDelegate {

    func selectedNodesDidChange(_ nodes: Set<Node>)
    
    // UPDATE to use ImageItem.ID
    func selectedImageItemsDidChange(_ imageItemsIDs: Set<ImageItem.ID>)
}
