//
//  ImageContent.swift
//  Images-LectureDevelopment
//
//  Created by Owen Hildreth on 3/27/24.
//

import SwiftUI

struct ImageContent: View {
    @Environment(AppController.self) private var appController: AppController
    
    @AppStorage("imageContentViewState") var imageContentViewState: ImageContentViewState = .table
    
    var body: some View {
        VSplitView {
            // UPDATE
            itemsViews
                
                        
            ImageDetailList(imageItems: appController.dataModel.selectedImageItems)
                .frame(maxWidth: .infinity, minHeight: 100, maxHeight: .infinity)
        }
        .toolbar {
            ToolbarItem(id: "ImagesViewSelection", placement: .principal) {
                Picker("Images", selection: $imageContentViewState) {
                    ForEach(ImageContentViewState.allCases) { state in
                        Image(systemName: state.systemName)
                    }
                }.pickerStyle(.inline)
            }
        }

    }
    
    @ViewBuilder
    var itemsViews: some View {
        switch imageContentViewState {
        case .table:
            ItemsTable(imageContentVM: appController.imageContentViewModel)
                .frame(maxWidth: .infinity, minHeight: 300, maxHeight: .infinity)
        case .list:
            ItemsList(imageContentVM: appController.imageContentViewModel)
                .frame(maxWidth: .infinity, minHeight: 300, maxHeight: .infinity)
        case .grid:
            ImageGrid(imageContentVM: appController.imageContentViewModel)
                .frame(maxWidth: .infinity, minHeight: 300, maxHeight: .infinity)
        }
    }
}

#Preview {
    ImageContent()
}
