//
//  ImageItemInspector.swift
//  Images-LectureDevelopment
//
//  Created by Owen Hildreth on 3/24/24.
//

import SwiftUI

struct ImageItemInspector: View {
    
    var imageItems: [ImageItem]
    
    var body: some View {
        VStack {
            nodeNameEditor()
            fileInfo()
        }
    }
}


// MARK: - Image Name Editor
extension ImageItemInspector {
    
    @ViewBuilder
    private func nodeNameEditor() -> some View {
        switch imageItems.count {
        case 0: emptyImagesEditor()
        case 1: oneImageEditor()
        default: multipleImageEditor()
        }
    }
    
    @ViewBuilder
    private func emptyImagesEditor() -> some View {
        VStack(alignment: .center) {
            Text("No Images Selected")
            Text("Select a Image from the Image List")
        }
    }
    
    
    @ViewBuilder
    private func oneImageEditor() -> some View {
        if let editableItem = imageItems.first {
            @Bindable var bindableItem = editableItem
            VStack {
                HStack {
                    Text("Name:")
                    TextField("Name", text: $bindableItem.name)
                }
            }
            
        } else { EmptyView() }
    }
    
    
    @ViewBuilder
    private func multipleImageEditor() -> some View {
        VStack {
            Text("\(imageItems.count) Images selected")
            Text("Cannot edit multiple Items")
        }
    }
}


// MARK: - File Information
extension ImageItemInspector {
    @ViewBuilder
    private func fileInfo() -> some View {
        switch imageItems.count {
        case 0: EmptyView()
        case 1: singleFileInfo()
        default: EmptyView()
        }
    }
    
    @ViewBuilder
    private func singleFileInfo() -> some View {
        if let item = imageItems.first {
            VStack(alignment: .leading) {
                //let fileSize = (item.fileSize)
                let fileSizeString = item.scaledFileSize
                
                Text("File Size: \(fileSizeString) MB")
                let creationDateString = item.creationDate.formatted(date: .numeric, time: .omitted)
                Text("Creation Date: \(creationDateString)")
                let modifedDateString = item.contentModificationDate.formatted(date: .numeric, time: .omitted)
                Text("Last Modified: \(modifedDateString)")
            }
        } else {
            EmptyView()
        }
    }
    
    private func fileSizeFormatter() -> NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        
        formatter.maximumSignificantDigits = 3
        formatter.minimumSignificantDigits = 3
        
        return formatter
    }
    
    private func formatedFileSize(_ fileSize: Int) -> String {
        let size = Double(fileSize) / 1_000_000.0
        
        let sizeNumber = NSNumber(value: size)
        
        return fileSizeFormatter().string(from: sizeNumber) ?? "N/A"
    }
}


// MARK: - Preview
#Preview {
    ImageItemInspector(imageItems: [])
}
