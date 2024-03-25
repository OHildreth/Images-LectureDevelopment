//
//  DataModel_importingURLs.swift
//  Images-LectureDevelopment
//
//  Created by Owen Hildreth on 3/5/24.
//

import Foundation



// MARK: - Importing URLs

extension DataModel {
    
    func importURLs(_ urls: [URL], intoNode parentNode: Node?) throws  {
        // No need to do anything if there aren't any URLs in the array
        if urls.isEmpty {throw ImportError.noURLsToImport}
        
        // Import Files first because we want to exit scope if the user is trying to import a
        let files = urls.filter( { !$0.isDirectory})
        
        // NOTE: importing files without a parentNode isn't allowed.  Files need to be stored somewhere.
        // NOTE: Currently we will throw an error.  One way to fix this would be to create a default Node automatically for the User.  However, this is complex to do correctly, for example, what if you make a default Node called "Home", but that a Node called "Home" already exists.  Should you put the files in the existing "Home" node? or make another "Home" node, or a new node called "Home 2"?  Making decisions for the User is difficult and should not be done lightly.
        if files.count != 0 && parentNode == nil {
            throw ImportError.cannotImportFileWithoutANode
        }
        
        // Notice that we are using an if let to unwrap the optional parentNode instead of a guard let.  This is because we have already checked that the state is correct above and we don't want to exit the function because directories can be imported without a parentNode.
        if let parentNode {
            for nextFile in files {
                importFile(nextFile, intoNode: parentNode)
            }
        }
        
        
        let directories = urls.filter( { $0.isDirectory } )
        
        for nextDirectory in directories {
            importDirectory(nextDirectory, intoNode: parentNode)
        }
        
        fetchData()
    }
    
    // UPDATE to private
    private func importDirectory(_ url: URL, intoNode parentNode: Node?) {
        
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
        
        modelContext.insert(newNode)
        
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
        
        // REMOVE
        // fetchData()
    }
    
    // UPDATE to private
    private func importFile(_ url: URL, intoNode parentNode: Node) {
        
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



