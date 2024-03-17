//
//  ContentView.swift
//  Images-LectureDevelopment
//
//  Created by Owen Hildreth on 1/24/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    // REMOVE
    //@Environment(\.modelContext) private var modelContext
    
    // REMOVE
    // @State var dataModel = DataModel()
    
    // ADD
    @Environment(AppController.self) private var appController: AppController
    
    var dataModel: DataModel {
        appController.dataModel
    }
    
    var body: some View {
        // ADD
        // We need a bindable version of dataModel.  This is how the new Observation macros create bindable values if you don't have direct access to the original @State of @Environment macro created objects
        @Bindable var dataModel = appController.dataModel
        
         VStack {
             HStack {
                 importButton
                 
                 // UPDATE to use dataModel
                 Text("Root Nodes: \(dataModel.rootNodes.count)")
             }
             .padding()
             
             Divider()
             
             HSplitView {
                 SourceList(nodes: $dataModel.rootNodes, selectionManager: appController.selectionManager)
                     .frame(minHeight: 200, maxHeight: .infinity)
                 
                 // UPDATE to use visibleItems
                 ItemsTable(items: dataModel.visableItems)
                     .frame(minHeight: 200, maxHeight: .infinity)
             }
         }
        .onAppear() {
            // This will automatically clear the modelContext so that we have a clean slate each time we run the application.
            #if DEBUG
            // UPDATE to use dataModel
            try? dataModel.modelContext.delete(model: Node.self)
            try? dataModel.modelContext.delete(model: ImageItem.self)
            #endif
        }
    }
    
    
    
    // UPDATE
    @ViewBuilder
    var importButton:  some View {
        Button("Select URL") {
            let panel = NSOpenPanel()
            panel.canChooseFiles = false
            panel.canChooseDirectories = true
            panel.allowsMultipleSelection = false
            
            if panel.runModal() == .OK {
                if let url = panel.url {
                    // UPDATE to use dataModel
                    dataModel.importDirectory(url, intoNode: nil)
                }
            }
            
        }
    }
}

#Preview {
    ContentView()
    
}
