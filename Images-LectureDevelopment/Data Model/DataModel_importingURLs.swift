//
//  DataModel_importingURLs.swift
//  Images-LectureDevelopment
//
//  Created by Owen Hildreth on 3/5/24.
//

import Foundation



// MARK: - Importing URLs

extension DataModel {
    // UPDATE
    func importDirectory(_ url: URL, intoNode parentNode: Node?) {
        
        // modelContext is no longer optional.
        // REMOVE
        // guard let localModelContext = modelContext else {return}
        
        // Check that url exists and is a director
        let fm = FileManager.default
        var isDir = ObjCBool(false)
        
        
        guard fm.fileExists(atPath: url.path, isDirectory: &isDir) else {
            print("File does not exist")
            return
        }

        
        let type = URL.URLType(withURL: url)
        
        if type == .file {
            print("Error.  importDirectory should only be seeing directories")
            print("\(url)\n is not a directory")
            return
        }
        
        // Create Node and Insert into context
        let newNode = Node(withURL: url, parentNode)
        
        // UPDATE
        // localModelContext.insert(newNode)
        modelContext.insert(newNode)
        
        // Adding node as subnode to parent node
        // Unwrap parentNode so that the existence of the parentNode's subNode array can be probed
        // Create subNode array if needed and then append self as a subNode.
        if let parentNode {
            if parentNode.subNodes != nil {
                parentNode.subNodes?.append(newNode)
            } else {
                parentNode.subNodes = []
                parentNode.subNodes?.append(newNode)
            }
        }
        
        
        // Get the contenst of the original URL and sort into directories and filesg
        var subdirectories: [URL] = []
        var files: [URL] = []
        
        
        if let contentURLs = try? fm.contentsOfDirectory(at: url, includingPropertiesForKeys: [.isRegularFileKey]) {
            for nextURL in contentURLs {
                
                let nextType = URL.URLType(withURL: nextURL)
                
                switch nextType {
                case .directory:
                    subdirectories.append(nextURL)
                case .file:
                    files.append(nextURL)
                case .fileDoesNotExist:
                    continue
                }
            }
        }
        
        
        // Add any files directly owned by the directory into the new Node
        for nextFile in files {
            self.importFile(nextFile, intoNode: newNode)
        }
        
        
        // Recusively transform any subdirectores into subnodes
        for nextDirectory in subdirectories {
            self.importDirectory(nextDirectory, intoNode: newNode)
        }
        
        // ADD
        fetchData()

    }
    
    
    // UPDATE
    func importFile(_ url: URL, intoNode parentNode: Node) {
        
        // modelContext is no longer optional.
        // REMOVE
        // guard let localModelContext = modelContext else {return}
        
        // Check that the url exists and it is a file
        let fm = FileManager.default
        
        guard fm.fileExists(atPath: url.path) else {
            print("File does not exist at: \(url)")
            return
        }
        
        
        if url.isDirectory {
            print("Trying to add a url as an image")
            return
        }
        
        
        guard let allowedExtensions = UserDefaults.standard.object(forKey: UserDefaults.allowedImageFileExtensions) as? [String] else {
            print("Error needed, no allowed extensions")
            return
        }
        
        // Make the comparison case insensitive to make it easier on the user when adding file extensions in the Preferences
        if (allowedExtensions.contains(where: {$0.caseInsensitiveCompare(url.pathExtension) == .orderedSame }) == false) {
            // Filetype is not allowed to be imported
            return
        }
        
        let newItem = ImageItem(url: url)
        
        // UPDATE
        //  localModelContext.insert(newItem)
        modelContext.insert(newItem)
        
        // Set parent node for ImageItem
        newItem.node = parentNode
    }
}
