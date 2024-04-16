//
//  ItemsList.swift
//  Images-LectureDevelopment
//
//  Created by Owen Hildreth on 4/13/24.
//


import SwiftUI

// ADD
import SwiftData

struct ItemsList: View {
    
    @Bindable var imageContentVM: ImageContentViewModel
    
    
    var body: some View {
        List(imageContentVM.imageItems, id: \.id, selection: $imageContentVM.selection) { imageItem in
            
            HStack {
                AsyncImage(url: imageItem.url) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 50, height: 75)
                .clipped()
                .padding(.trailing)
                
                Text(imageItem.name)
                    .padding(.horizontal)
                Spacer()
                Text(imageItem.nodeName)
                    .padding(.horizontal)
                Spacer()
                Button(action: {
                    imageItem.url.showInFinder()
                },
                       label: {Image(systemName: "link")})
            }
            
        }
    }
}

