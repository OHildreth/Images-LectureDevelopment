//
//  SourceList.swift
//  Images-LectureDevelopment
//
//  Created by Owen Hildreth on 2/2/24.
//

import SwiftUI
import SwiftData

struct SourceList: View {
    var dataModel: DataModel
    
    @Bindable var selectionManager: SelectionManager
    
    // ADD
    @State private var showingAlert = false
    
    var body: some View {
        List(selection: $selectionManager.selectedNodes) {
            // UPDATE and REMOVE bindings
            OutlineGroup(dataModel.rootNodes, id: \.self, children: \.subNodes) { nextNode in
                HStack {
                    Image(systemName: "folder.fill")
                        .foregroundStyle(.secondary)
                    Text(nextNode.name)
                }
                .dropDestination(for: URL.self) { urls, _  in
                    importURLs(urls, intoNode: nextNode)
                    return true
                }
                .alert(isPresented: $showingAlert) { importAlert }
            }
        }
        .dropDestination(for: URL.self) { urls, _  in
            importURLs(urls, intoNode: nil)
            return true
        }
        .alert(isPresented: $showingAlert) { importAlert }
        
    }
    
    // ADD
    private func importURLs(_ urls: [URL], intoNode parentNode: Node?) {
        do {
            try dataModel.importURLs(urls, intoNode: parentNode)
        } catch {
            if let importError = error as? DataModel.ImportError {
                if importError == .cannotImportFileWithoutANode {
                    self.showingAlert = true
                }
            }
        }
    }
    
    // ADD
    private var importAlert: Alert {
        Alert(title: Text("Import Error"), message: Text("Image Files must be imported into an existing group"))
    }
    
}


