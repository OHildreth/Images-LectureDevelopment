//
//  ImageItem_fileInformation.swift
//  Images-LectureDevelopment
//
//  Created by Owen Hildreth on 3/24/24.
//

import Foundation
import SwiftData

extension ImageItem {
    
    @Transient
    var fileSize: Int {
        urlResources()?.totalFileSize ?? 0
    }
    
    
    @Transient
    var scaledFileSize: String {
        //Source: https://stackoverflow.com/questions/42722498/print-the-size-megabytes-of-data-in-swift
        let bcf = ByteCountFormatter()
        bcf.allowedUnits = [.useKB, .useMB, .useGB]
        bcf.countStyle = .file
        
        return bcf.string(fromByteCount: Int64(fileSize))
    }
    
    @Transient
    var creationDate: Date {
        return urlResources()?.creationDate ?? .distantPast
    }
    
    
    @Transient
    var contentModificationDate: Date {
        return urlResources()?.contentModificationDate ?? .distantPast
    }
    
    @Transient
    var nodeName: String {
        return node?.name ?? "No Folder"
    }

}
