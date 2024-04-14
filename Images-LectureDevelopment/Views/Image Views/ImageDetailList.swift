//
//  ImageDetailList.swift
//  Images-LectureDevelopment
//
//  Created by Owen Hildreth on 3/27/24.
//

import SwiftUI

struct ImageDetailList: View {
    
    var imageItems: [ImageItem] = []
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack {
                ForEach(imageItems, id: \.id) { nextItem in
                    if let image = NSImage(contentsOf: nextItem.url) {
                        Image(nsImage: image)
                            .resizable()
                            .scaledToFill()
                    } else {
                        Text("\(nextItem.name) could not be found")
                    }
                }
            }
        }
    }
}



#Preview {
    ImageDetailList()
}
