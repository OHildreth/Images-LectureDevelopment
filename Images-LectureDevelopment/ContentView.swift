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
    
    @State private var visibility_sourceList: NavigationSplitViewVisibility = .all
    @State private var visibility_inspector = true
    
    
    var dataModel: DataModel { appController.dataModel }
    
    #if DEBUG
    var deleteData = false
    #endif
    
    var body: some View {
        // REMOVE
        //@Bindable var dataModel = appController.dataModel
        
         VStack {
             NavigationSplitView(columnVisibility: $visibility_sourceList) {
                 
                 // UPDATE
                 SourceList(sourceListVM: appController.sourceListViewModel)
             } detail: {
                 ImageContent(imageContentVM: appController.imageContentViewModel)
             }
             .inspector(isPresented: $visibility_inspector) {
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
            if deleteData == true {
                try? dataModel.modelContext.delete(model: Node.self)
                try? dataModel.modelContext.delete(model: ImageItem.self)
            }
            
            #endif
        }
        .navigationTitle("")
    }
}

#Preview {
    ContentView()
    
}
