//
//  Preferences.swift
//  Images-LectureDevelopment
//
//  Created by Owen Hildreth on 2/14/24.
//

import SwiftUI
import Observation

struct Preferences: View {
    // Using @State instead of @StateObject because the PreferencesController is using the @Observable macro, which eliminates the use of @StateObject and replaces it with just @State
    @State var preferencesController = PreferencesController()
    
    
    @State var selection: Set<AllowedFileExtension.ID> = []
    
    var body: some View {
        
        List($preferencesController.allowedImageFileExtensions, 
             id: \.id,
             editActions: [.delete, .move],
             selection: $selection) { $nextExtension in
            HStack {
                Text("􀏅")
                TextField("", text: $nextExtension.fileExtension)
                    .onSubmit {
                        self.preferencesController.save()
                    }
            }
            .contextMenu {
                Button("Delete", action: deleteSelection)
            }
            .frame(width: 100, alignment: .center)
        }
        .toolbar() {
            ToolbarItem {
                Button("", systemImage: "plus", action: addNewFileExtension)
                    .help("Add new File Extension")
            }
            ToolbarItem {
                Button("", systemImage: "minus", action: deleteSelection)
                    .help( selection.count == 0 ? "Select File Extensions to Delete" : "Delete \(selection.count) File Extensions")
                    .disabled(selection.count == 0)
            }
        }
        .frame(maxWidth: .infinity)
    }
    
    private func deleteSelection() {
        let selectionArray = Array(selection)
        let extensionsToDelete = preferencesController.allowedImageFileExtensions.filter({selectionArray.contains($0.id)})
        
        preferencesController.removeExtension(extensionsToDelete)
    }
    
    private func addNewFileExtension() {
        preferencesController.addExtension()
    }
    
}



#Preview {
    Preferences()
}
