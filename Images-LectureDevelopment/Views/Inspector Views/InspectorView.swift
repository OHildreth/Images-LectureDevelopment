//
//  InspectorView.swift
//  Images-LectureDevelopment
//
//  Created by Owen Hildreth on 3/22/24.
//

import SwiftUI

struct InspectorView: View {
    
    var dataModel: DataModel
    
    @State private var visible = true
    
    var body: some View {
        TabView {
            NodeInspector(nodes: dataModel.selectedNodes)
                .tabItem { Text("􀈕") }
            ImageItemInspector(imageItems: dataModel.selectedImageItems)
                .tabItem { Text("􀏅") }
        }
    }
}

#Preview {
    InspectorView(dataModel: DataModel())
}
