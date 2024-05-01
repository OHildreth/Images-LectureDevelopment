//
//  DataModelDelegate.swift
//  Images-LectureDevelopment
//
//  Created by Owen Hildreth on 4/25/24.
//

import Foundation

protocol DataModelDelegate {
    func newData(nodes: [Node], andImages imageItems: [ImageItem])
    
    // Add
    func preparingToDelete(nodes: [Node])
    
    // ADD
    func preparingToDelete(imageItems: [ImageItem])
}
