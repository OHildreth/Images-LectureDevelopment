//
//  ContentView.swift
//  Images-LectureDevelopment
//
//  Created by Owen Hildreth on 1/24/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @Environment(AppController.self) private var appController: AppController
    
    // ADD
    @State private var visibility_sourceList: NavigationSplitViewVisibility = .all
    @State private var visibility_inspector = true

    var dataModel: DataModel { appController.dataModel }
    
    var body: some View {
        @Bindable var dataModel = appController.dataModel
        
         VStack {
             //REMOVE
             /*
              HStack {
                  importButton
                  Text("Root Nodes: \(dataModel.rootNodes.count)")
              }
              .padding()
              
              Divider()
              */
             
            
             NavigationSplitView(columnVisibility: $visibility_sourceList) {
                 // UPDATE
                 SourceList(dataModel: dataModel, selectionManager: appController.selectionManager)
             } detail: {
                 ItemsTable(items: dataModel.visableItems, selectionManager: appController.selectionManager)
             }
             .inspector(isPresented: $visibility_inspector) {
                 // ADD
                 InspectorView(dataModel: dataModel)
                     .toolbar() {
                         ToolbarItem(id: "inspector") {
                             Button {
                                 visibility_inspector.toggle()
                             } label: {
                                 Image(systemName: "sidebar.right")
                             }
                         }
                         
                     }
             }
             .navigationSplitViewStyle(.prominentDetail)
         }
        .onAppear() {
            // This will automatically clear the modelContext so that we have a clean slate each time we run the application.
            #if DEBUG
            // UPDATE to use dataModel
            try? dataModel.modelContext.delete(model: Node.self)
            try? dataModel.modelContext.delete(model: ImageItem.self)
            #endif
        }
        .navigationTitle("")
    }
    
    
    // REMOVE
    /*
     @ViewBuilder
     var importButton:  some View {
         Button("Select URL") {
             let panel = NSOpenPanel()
             panel.canChooseFiles = false
             panel.canChooseDirectories = true
             panel.allowsMultipleSelection = false
             
             if panel.runModal() == .OK {
                 do {
                     let urls = panel.urls
                     try dataModel.importURLs(urls, intoNode: nil)
                 } catch {
                     if let importError = error as? DataModel.ImportError {
                         if importError == .cannotImportFileWithoutANode {
                             Alert(title: Text("Import Error"), message: Text("Image Files must be imported into an existing group"))
                         }
                     }
                 }
             }
             
         }
     }
     */
}

#Preview {
    ContentView()
    
}
