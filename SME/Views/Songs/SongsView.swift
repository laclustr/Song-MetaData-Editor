//
//  SongsView.swift
//  SME
//
//  Created by Grant Vance on 9/6/25.
//

import SwiftUI
import SwiftData

struct SongsView: View {
    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject private var audioFileManager: AudioFileManager
    
    @Query(sort: \Song.title) private var songs: [Song]
    
    @State private var showingImportSheet = false
    @State private var showingEditSheet = false
    @State private var selectedSong: Song?
    
    var body: some View {
        NavigationView {
            List {
                ForEach(songs) { song in
                    SongRowView(song: song) {
                        selectedSong = song
                        showingEditSheet = true
                    }
                }
                .onDelete(perform: deleteSongs)
            }
            .navigationTitle("Songs")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Import") { showingImportSheet = true }
                }
            }
        }
        .sheet(isPresented: $showingImportSheet) {
            ImportSongView()
        }
        .sheet(isPresented: $showingEditSheet) {
            if let song = selectedSong {
                EditSongView(song: song)
            }
        }
    }
    
    private func deleteSongs(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                let song = songs[index]
                if let fileURL = song.fileURL {
                    audioFileManager.deleteAudioFile(at: fileURL)
                }
                modelContext.delete(song)
            }
            try? modelContext.save()
        }
    }
}
