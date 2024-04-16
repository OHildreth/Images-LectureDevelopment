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
                    AsyncImage(url: imageItem.url) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            //.frame(minWidth: 100, height: 150)
                            .border(Color.red, width: 2)
                            
                    } placeholder: {
                        ProgressView()
                    }
                    .padding()
                    /*
                     .onTapGesture {
                         imageContentVM.imageItemTapped(imageItem)
                     }
                     */
                    
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
                    .gesture(TapGesture().modifiers([]).onEnded {
                        print("Tapped")
                        imageContentVM.imageItemTapped(imageItem)
                    })
                    
                }
            }
            .padding()
        }
        .onTapGesture {
            print("tapped in empty space")
            imageContentVM.selection = []
        }
    }
    
}

/*
 #Preview {
 ImageGrid()
 }
 */

