//
//  ItemsTable.swift
//  Images-LectureDevelopment
//
//  Created by Owen Hildreth on 2/3/24.
//

import SwiftUI
import SwiftData

struct ItemsTable: View {
    var items: [ImageItem]
    
    @Bindable var selectionManager: SelectionManager
    
    // ADD
    @State private var sortOrder = [KeyPathComparator(\ImageItem.name)]
    
    var body: some View {
        // UPDATE
        Table(items, selection: $selectionManager.selectedImageItemIDs, sortOrder: $sortOrder) {
            TableColumn("Name", value: \.name)
            
            // ADD
            TableColumn("Folder", value: \.nodeName)
            // ADD
            // NOTE: This will fail if value: exist without adding a sortOrder
            TableColumn("File Size", value: \.fileSize) {              Text($0.scaledFileSize)
            }
            
            TableColumn("Creation Date", value: \.creationDate) {
                Text($0.creationDate.formatted(date: .numeric, time: .omitted))
            }
            
            
            TableColumn("Modified Date", value: \.contentModificationDate) {
                Text($0.contentModificationDate.formatted(date: .numeric, time: .omitted))
            }
            
            TableColumn("Open in Finder", value: \.url.relativePath) { imageItem in
                Button(action: {
                    imageItem.url.showInFinder()
                },
                       label: {Image(systemName: "link")})
            }
            
        }
    }
}


