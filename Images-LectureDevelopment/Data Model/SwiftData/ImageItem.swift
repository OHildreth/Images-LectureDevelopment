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
    
    @Transient
    private var resourceValues: URLResourceValues?
    
    func urlResources() -> URLResourceValues? {
        if resourceValues == nil {
            resourceValues = try? url.resourceValues(forKeys: [.totalFileSizeKey, .creationDateKey, .contentModificationDateKey])
        }
        
        return resourceValues
    }
}

extension ImageItem: Comparable {
    static func < (lhs: ImageItem, rhs: ImageItem) -> Bool {
        lhs.name < rhs.name
    }
}
