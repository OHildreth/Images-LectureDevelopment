//
//  ImageContent.swift
//  Images-LectureDevelopment
//
//  Created by Owen Hildreth on 3/27/24.
//

import SwiftUI

struct ImageContent: View {
    @Environment(AppController.self) private var appController: AppController
    
    var body: some View {
        VSplitView {
            ItemsTable(items: appController.dataModel.visableItems, selectionManager: appController.selectionManager)
                .frame(minHeight: 100, maxHeight: .infinity)
            ImageDetailList(imageItems: appController.dataModel.selectedImageItems)
                .frame(minHeight: 100, maxHeight: .infinity)
        }
    }
}

#Preview {
    ImageContent()
}
