//
//  ContentView.swift
//  SME
//
//  Created by Grant Vance on 9/6/25.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var cloudKitManager: CloudKitManager
    @EnvironmentObject private var audioFileManager: AudioFileManager
    
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            SongsView()
                .tabItem {
                    Image(systemName: "music.note")
                    Text("Songs")
                }
                .tag(0)
            
            AlbumsView()
                .tabItem {
                    Image(systemName: "opticaldisc")
                    Text("Albums")
                }
                .tag(1)
            
            SettingsView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
                }
                .tag(2)
        }
    }
}
