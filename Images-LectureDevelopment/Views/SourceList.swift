//
//  SourceList.swift
//  Images-LectureDevelopment
//
//  Created by Owen Hildreth on 2/2/24.
//

import SwiftUI
import SwiftData

struct SourceList: View {
    @Binding var nodes: [Node]
    
    // Update
    // Notice that we are using the @Bindable macro to make the passed in selectionManager variable bindable
    @Bindable var selectionManager: SelectionManager
    
    
    var body: some View {
        // UPDATE to use selectionManager
        List(selection: $selectionManager.selectedNodes) {
            

            OutlineGroup($nodes, id: \.self, children: \.subNodes) { $nextNode in
                HStack {
                    Image(systemName: "folder.fill")
                        .foregroundStyle(.secondary)
                    TextField("Name", text: $nextNode.name)
                    
                    // REMOVE
                    // Text(nextNode.parent?.name ?? "No Parent")
                    //  Text("\(nextNode.subNodes?.count ?? 0)")
                }
            }
        }
    }
}


