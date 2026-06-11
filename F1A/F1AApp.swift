//
//  F1AApp.swift
//  F1A
//
//  Created by Dhan on 28/05/26.
//

import SwiftUI

@main
struct F1AApp: App {
    
    var body: some Scene {
        
        WindowGroup {
            ContentView()
        }
        .windowToolbarStyle(.unifiedCompact)
        .commands {

            CommandGroup(after: .appInfo) {

                Button("Home") {

                    NotificationCenter.default.post(
                        name: NSNotification.Name("GoHome"),
                        object: nil
                    )
                }
                .keyboardShortcut("h")
            }
        }
        .defaultSize(width: 1400, height: 860)
        .windowResizability(.contentSize)
    }
}
