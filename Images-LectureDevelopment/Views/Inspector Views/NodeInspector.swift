//
//  NodeInspector.swift
//  Images-LectureDevelopment
//
//  Created by Owen Hildreth on 3/24/24.
//

import SwiftUI

struct NodeInspector: View {
    var nodes: [Node]
    
    var body: some View {
        VStack {
            nodeNameEditor()
            imageNumber()
        }
        
    }
}


// MARK: - Node Name Editor
extension NodeInspector {
    @ViewBuilder
    private func nodeNameEditor() -> some View {
        switch nodes.count {
        case 0: emptyNodesEditor()
        case 1: oneNodeEditor()
        default: multipleNodeEditor()
        }
    }
    
    @ViewBuilder
    private func emptyNodesEditor() -> some View {
        Text("No Groups Selected.  Select a Group from the sidebar")
            .lineLimit(nil)
    }
    
    @ViewBuilder
    private func oneNodeEditor() -> some View {
        if let editableNode = nodes.first {
            @Bindable var bindableNode = editableNode
            HStack {
                Text("Name:")
                TextField("Name", text: $bindableNode.name)
            }
        } else { EmptyView() }
    }
    
    @ViewBuilder
    private func multipleNodeEditor() -> some View {
        Text("\(nodes.count) Groups selected. Cannot edit multiple Groups")
            .lineLimit(nil)
    }
}


// MARK: - Image Information
extension NodeInspector {
    @ViewBuilder
    private func imageNumber() -> some View {
        let nodeCount = nodes.count
        let imageCount = nodes.reduce(0, { current, node in
            current + node.flattenedImageItems().count
        } )
        
        let imageCountString = nodeCount.spelledOut?.capitalized ?? String(imageCount)
        let imageString = "Image".pluralize(imageCount)
        let nodeString = "in selected " + "Group".pluralize(nodeCount)
        let output = imageCountString + " " + imageString + " " + nodeString
        
        Text(output)
            .lineLimit(0)
    }
}



#Preview {
    NodeInspector(nodes: [])
}
