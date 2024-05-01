//
//  ItemsTable.swift
//  Images-LectureDevelopment
//
//  Created by Owen Hildreth on 2/3/24.
//

import SwiftUI
import SwiftData

struct ItemsTable: View {
    
    @Bindable var imageContentVM: ImageContentViewModel
    
    var body: some View {
        // UPDATE in 2 places
        // remove: imageContentVM.imageItems
        Table(selection: $imageContentVM.selection,
              sortOrder: $imageContentVM.sort) {
            TableColumn("Name", value: \.name)
            
            
            TableColumn("Folder", value: \.nodeName)
            
            TableColumn("File Size", value: \.fileSize) {
                Text($0.scaledFileSize)
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
        // ADD
    rows: {
        ForEach(imageContentVM.imageItems) { imageItem in
            TableRow(imageItem)
                .contextMenu {
                    Button("Delete") { imageContentVM.deleteSelectedImages() }
                        .disabled(imageContentVM.selection.count == 0)
                }
            }
        }
    }
}


