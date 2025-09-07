//
//  SMEApp.swift
//  SME
//
//  Created by Grant Vance on 9/6/25.
//

import SwiftUI
import SwiftData

@main
struct MusicManagerApp: App {
    @StateObject private var cloudKitManager = CloudKitManager()
    @StateObject private var audioFileManager = AudioFileManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(cloudKitManager)
                .environmentObject(audioFileManager)
        }
        .modelContainer(for: [Song.self, Album.self])
    }
}
