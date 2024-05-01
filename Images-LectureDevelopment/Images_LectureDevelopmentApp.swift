//
//  Images_LectureDevelopmentApp.swift
//  Images-LectureDevelopment
//
//  Created by Owen Hildreth on 1/24/24.
//

import SwiftUI
import SwiftData

@main
struct Images_LectureDevelopmentApp: App {
    
    // ADD
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    @State var appController = AppController()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        // ADD Menu
        .commands {
            ImportCommand(appController.menuBarViewModel)
            DeleteCommand(appController.menuBarViewModel)
            DeselectAllCommand(appController.menuBarViewModel)
        }
        .environment(appController)
        
        Settings {
            Preferences()
        }
    }
}




