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
    
    var body: some View {
        Table(items) {
            TableColumn("Name", value: \.name)
        }
    }
}


