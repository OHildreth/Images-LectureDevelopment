//
//  SourceList.swift
//  Images-LectureDevelopment
//
//  Created by Owen Hildreth on 2/2/24.
//

import SwiftUI
import SwiftData

struct SourceList: View {
    
    @Bindable var sourceListVM: SourceListViewModel
    
    // REMOVE
    //var dataModel: DataModel
    
    // REMOVE
    //@Bindable var selectionManager: SelectionManager
    
    // REMOVE
    //@State private var showingAlert = false
    
    var body: some View {
        List(selection: $sourceListVM.selection) {
            // UPDATE
            OutlineGroup(sourceListVM.rootNodes, id: \.self, children: \.subNodes) { nextNode in
                HStack {
                    Image(systemName: "folder.fill")
                        .foregroundStyle(.secondary)
                    Text(nextNode.name)
                }
                // ADD
                .contextMenu {
                    Button("Create New Folder") {
                        sourceListVM.createEmptyNode(withParent: nextNode)
                    }
                    Button("Delete \(sourceListVM.selection.count) Folders") {
                        sourceListVM.deleteSelectedNodes()
                    }
                }
                .dropDestination(for: URL.self) { urls, _  in
                    
                    // UPDATE
                    let success = sourceListVM.importURLs(urls, intoNode: nextNode)
                    return success
                }
                // UPDATE
                .alert(isPresented: $sourceListVM.presentURLImportError) { importAlert }
            }
            
        }
        
        // ADD
        .contextMenu {
            Button("Create New Folder") {
                sourceListVM.createEmptyNode(withParent: nil)
            }
        }
        // UPDATE
        .dropDestination(for: URL.self) { urls, _  in
            // UPDATE
            let success = sourceListVM.importURLs(urls, intoNode: nil)
            return success
        }
        .alert(isPresented: $sourceListVM.presentURLImportError) { return importAlert }
    }
    
    // REMOVE
    /*
    private func importURLs(_ urls: [URL], intoNode parentNode: Node?) {
         do {
             try sourceListVM.importURLs(urls, intoNode: parentNode)
         } catch {
             if let importError = error as? DataModel.ImportError {
                 if importError == .cannotImportFileWithoutANode {
                     self.showingAlert = true
                 }
             }
         }
    }
     
     */
    
    
    private var importAlert: Alert {
        Alert(title: Text("Import Error"), message: Text("Image Files must be imported into an existing group"))
    }
}


