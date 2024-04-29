//
//  ImportCommand.swift
//  Images-LectureDevelopment
//
//  Created by Owen Hildreth on 4/28/24.
//

import SwiftUI


struct ImportCommand: Commands {
    var menuVM: MenuBarViewModel
    
    init(_ menuVM: MenuBarViewModel) {
        self.menuVM = menuVM
    }
    
    var body: some Commands {
        CommandGroup(replacing: .importExport) {
            Button("Import") {
                menuVM.importButtonAction()
            }
            .disabled(menuVM.importButtonIsDisabled)
            .help(menuVM.importHelp)
        }
    }
}


struct DeleteCommand: Commands {
    var menuVM: MenuBarViewModel
    
    init(_ menuVM: MenuBarViewModel) {
        self.menuVM = menuVM
    }
    
    var body: some Commands {
        CommandGroup(replacing: CommandGroupPlacement.pasteboard) {
                Button("Delete", action: {
                    menuVM.deleteButtonAction()
                })
                .keyboardShortcut(.delete, modifiers: [])
                .disabled(menuVM.deleteButtonIsDisabled)
                .help(menuVM.deleteHelp)
            }
    }
}

struct DeselectAllCommand: Commands {
    var menuVM: MenuBarViewModel
    
    init(_ menuVM: MenuBarViewModel) {
        self.menuVM = menuVM
    }
    
    var body: some Commands {
        CommandGroup(after: .textEditing) {
                Button("Deselect All", action: {
                    menuVM.deselectButtonAction()
                })
                .keyboardShortcut(.escape, modifiers: [])
                .disabled(menuVM.deselectButtonIsDisabled)
                .help(menuVM.deselectAllHelp)
            }
    }
}


