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
    var fileSize: Int? {
        urlResources()?.totalFileSize
    }
    
    @Transient
    var creationDate: Date? {
        return urlResources()?.creationDate
    }
    
    @Transient
    var contentModificationDate: Date? {
        return urlResources()?.contentModificationDate
    }

}
