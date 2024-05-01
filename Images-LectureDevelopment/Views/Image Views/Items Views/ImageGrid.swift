//
//  ImageGrid.swift
//  Images-LectureDevelopment
//
//  Created by Owen Hildreth on 4/14/24.
//

import SwiftUI

struct ImageGrid: View {
    @Bindable var imageContentVM: ImageContentViewModel
    
    // Define grid columns
    var columns = [ GridItem(.adaptive(minimum: 200, maximum: 300), spacing: 0) ]
    
    var body: some View {
        
        ScrollView(.vertical) {
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(imageContentVM.imageItems) { imageItem in
                    
                    VStack(alignment: .center) {
                        AsyncImage(url: imageItem.url) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                //.frame(minWidth: 100, height: 150)
                                .border(Color.blue, width: selectionWidth(forItem: imageItem))
                                
                        } placeholder: {
                            ProgressView()
                        }
                        Text(imageItem.name)
                    }
                    // ADD
                    .contextMenu {
                        Button("Delete") { imageContentVM.deleteSelectedImages() }
                            .disabled(imageContentVM.selection.count == 0)
                    }
                    
                    .padding()
                    /*
                     .onTapGesture {
                         imageContentVM.imageItemTapped(imageItem)
                     }
                     */
                    
                    // MARK: - Handling Selection
                    .gesture(TapGesture().modifiers([.command]).onEnded {
                        print("Tap with Modifier")
                        imageContentVM.imageTappedWithModifiers(imageItem, modifiers: [.control, .command, .shift])
                    })
                    .gesture(TapGesture().modifiers([.control]).onEnded {
                        print("Tap with Modifier")
                        imageContentVM.imageTappedWithModifiers(imageItem, modifiers: [.control, .command, .shift])
                    })
                    .gesture(TapGesture().modifiers([.shift]).onEnded {
                        print("Tap with Modifier")
                        imageContentVM.imageTappedWithModifiers(imageItem, modifiers: [.control, .command, .shift])
                    })
                    
                    // Must handle the tap without modifiers last
                    // Otherwise it will handle the response and the modifier versions won't occur
                    .gesture(TapGesture().modifiers([]).onEnded {
                        print("Tapped")
                        imageContentVM.imageItemTapped(imageItem)
                    })
                    
                }
            }
            .padding()
        }
        
        // Remove selection is tap occurs off of an image
        .onTapGesture {
            print("tapped in empty space")
            imageContentVM.selection = []
        }
    }
    
    
    func itemIsSelected(_ item: ImageItem) -> Bool {
        return imageContentVM.itemIsSelected(item)
    }
    
    func selectionWidth(forItem item: ImageItem) -> Double {
        if itemIsSelected(item) {
            return 4.0
        } else {
            return 0.0
        }
    }
}

/*
 #Preview {
 ImageGrid()
 }
 */

