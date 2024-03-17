//
//  PreferencesController.swift
//  Images-LectureDevelopment
//
//  Created by Owen Hildreth on 2/15/24.
//

import Foundation
import Observation

@Observable
class PreferencesController {
    var allowedImageFileExtensions: [AllowedFileExtension] {
        didSet { save()  }
    }
    
    
    init() {
        let fileExtensionStrings = UserDefaults.standard.value(forKey: UserDefaults.allowedImageFileExtensions) as? [String] ?? []

        self.allowedImageFileExtensions = []
        
        self.allowedImageFileExtensions = extensions(fromStrings: fileExtensionStrings).sorted(by: {$0.fileExtension < $1.fileExtension})
    }
    
    
    func addExtension() {
        let newExtension = AllowedFileExtension()
        allowedImageFileExtensions.append(newExtension)
    }
    
    func removeExtension(_ fileExtensions: [AllowedFileExtension]) {
        for nextExtension in fileExtensions {
            self.allowedImageFileExtensions.removeAll(where: { $0 == nextExtension })
        }
        
    }
    
    
    func save() {
        let extensionsToSave = self.extensionStrings( self.allowedImageFileExtensions)
        UserDefaults.standard.setValue(extensionsToSave, forKey: UserDefaults.allowedImageFileExtensions)
    }
    
    
    private func extensions(fromStrings strings: [String]) -> [AllowedFileExtension] {
        var allowedExtensions: [AllowedFileExtension] = []
        
        for nextString in strings {
            let nextExtension = AllowedFileExtension(fileExtension: nextString)
            allowedExtensions.append(nextExtension)
        }
        
        return allowedExtensions
    }
    
    
    private func extensionStrings(_ extensions: [AllowedFileExtension]) -> [String] {
        var output: [String] = []
        
        for nextExtension in extensions {
            output.append(nextExtension.fileExtension)
        }
        
        return output
    }
}
