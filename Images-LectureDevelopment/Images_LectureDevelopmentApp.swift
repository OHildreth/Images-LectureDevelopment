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
    // REMOVE
    
    /*
     var sharedModelContainer: ModelContainer = {
         let schema = Schema([
             Item.self, Node.self, ImageItem.self
         ])
         let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

         do {
             return try ModelContainer(for: schema, configurations: [modelConfiguration])
         } catch {
             fatalError("Could not create ModelContainer: \(error)")
         }
     }()
     */
    
    
    // ADD
    @State var appController = AppController()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        // REMOVE
        //.modelContainer(sharedModelContainer)
        
        // ADD
        .environment(appController)
        
        Settings {
            Preferences()
        }
    }
}
