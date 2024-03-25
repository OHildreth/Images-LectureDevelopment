//
//  ImageItem.swift
//  Images-LectureDevelopment
//
//  Created by Owen Hildreth on 1/24/24.
//

import Foundation
import SwiftData

@Model
final class ImageItem: Identifiable {
    var id: UUID
    
    var name: String
    
    var url: URL
    
    var node: Node?
    

    init(url: URL) {
        self.id = UUID()
        self.url = url
        
        self.name = url.deletingPathExtension().lastPathComponent
    }
}
