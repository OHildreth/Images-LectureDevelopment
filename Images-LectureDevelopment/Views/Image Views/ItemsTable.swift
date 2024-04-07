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
    
    // ADD
    @Bindable var selectionManager: SelectionManager
    
    var body: some View {
        // UPDATE
        Table(items, selection: $selectionManager.selectedImageItemIDs) {
            TableColumn("Name", value: \.name)
        }
    }
}


