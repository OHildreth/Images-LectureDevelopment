//
//  URL_isDirectory.swift
//  Images-LectureDevelopment
//
//  Created by Owen Hildreth on 2/28/24.
//

import Foundation

extension URL {
    var isDirectory: Bool {
       (try? resourceValues(forKeys: [.isDirectoryKey]))?.isDirectory == true
    }
    
    enum URLType {
        case file
        case directory
        case fileDoesNotExist
        
        init(withURL url: URL) {
            
            if url.isDirectory {
                self = .directory
                return
            }
            
            let fm = FileManager()
            if fm.fileExists(atPath: url.path) {
                self = .file
                return
            } else {
                self = .fileDoesNotExist
                return
            }
        }
    }
}
