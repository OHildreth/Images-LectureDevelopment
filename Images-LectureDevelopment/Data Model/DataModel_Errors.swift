//
//  DataModel_Errors.swift
//  Images-LectureDevelopment
//
//  Created by Owen Hildreth on 3/23/24.
//

import Foundation


extension DataModel {
    enum ImportError: Error {
        case cannotImportFileWithoutANode
        case noURLsToImport
    }
}
