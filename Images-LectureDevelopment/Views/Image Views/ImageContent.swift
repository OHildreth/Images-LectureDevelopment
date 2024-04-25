//
//  ImageContent.swift
//  Images-LectureDevelopment
//
//  Created by Owen Hildreth on 3/27/24.
//

import SwiftUI

struct ImageContent: View {
    //REMOVE
    //@Environment(AppController.self) private var appController: AppController
    
    // ADD
    @Bindable var imageContentVM: ImageContentViewModel
    
    @AppStorage("imageContentViewState") var imageContentViewState: ImageContentViewState = .table
    
    var body: some View {
        VSplitView {
            // UPDATE
            itemsViews
                .dropDestination(for: URL.self) { urls, _ in
                    imageContentVM.importURLs(urls)
                }
            // ADD
                .alert(isPresented: $imageContentVM.presentURLImportError, content: { dragAndDropAlert })
            
            ImageDetailList(imageItems: imageContentVM.selectedImageItems)
                .frame(maxWidth: .infinity, minHeight: 100, maxHeight: .infinity)
        }
        .toolbar {
            //  REPLACE
            /*
             ToolbarItem(id: "ImagesViewSelection", placement: .principal) {
                 Picker("Images", selection: $imageContentViewState) {
                     ForEach(ImageContentViewState.allCases) { state in
                         Image(systemName: state.systemName)
                     }
                 }.pickerStyle(.inline)
             }
             */
            
            // ADD
            imageSelectionToolbarItem
        }

    }
    
    @ViewBuilder
    var itemsViews: some View {
        switch imageContentViewState {
        case .table:
            ItemsTable(imageContentVM: imageContentVM)
                .frame(maxWidth: .infinity, minHeight: 300, maxHeight: .infinity)
        case .list:
            ItemsList(imageContentVM: imageContentVM)
                .frame(maxWidth: .infinity, minHeight: 300, maxHeight: .infinity)
        case .grid:
            ImageGrid(imageContentVM: imageContentVM)
                .frame(maxWidth: .infinity, minHeight: 300, maxHeight: .infinity)
        }
    }
    
    // ADD
    @ToolbarContentBuilder
    var imageSelectionToolbarItem:  some ToolbarContent {
        ToolbarItem(id: "ImagesViewSelection", placement: .principal) {
            Picker("Images", selection: $imageContentViewState) {
                ForEach(ImageContentViewState.allCases) { state in
                    Image(systemName: state.systemName)
                }
            }.pickerStyle(.inline)
        }
    }
    
    // ADD
    var dragAndDropAlert: Alert {
        Alert(title: Text("Import Error"), message: Text("Image Files must be imported into an existing group"))
    }
    
}

#Preview {
    ImageContent(imageContentVM: ImageContentViewModel(dataModel: DataModel(withDelegate: nil), selectionManager: SelectionManager()))
}
