//
//  InspectorView.swift
//  Images-LectureDevelopment
//
//  Created by Owen Hildreth on 3/22/24.
//

import SwiftUI

struct InspectorView: View {
    @State private var visible = true
    
    var body: some View {
        TabView {
            Text("Node Inspector")
                .tabItem { Text("􀈕") }
            Text("Image Inspector")
                .tabItem { Text("􀏅") }
        }
    }
}

#Preview {
    InspectorView()
}
