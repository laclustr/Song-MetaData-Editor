//
//  EditSongView.swift
//  SME
//
//  Created by Grant Vance on 9/6/25.
//

import SwiftUI
import SwiftData

struct EditSongView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    @Bindable var song: Song
    @State private var showingAlbumSelection = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Song Details")) {
                    TextField("Title", text: $song.title)
                    TextField("Artist", text: $song.artist)
                    TextField("Genre", text: Binding(
                        get: { song.genre ?? "" },
                        set: { song.genre = $0.isEmpty ? nil : $0 }
                    ))

                    Stepper("Year: \(song.year)", value: $song.year, in: 0...2100)
                    Stepper("Track #: \(song.trackNumber)", value: $song.trackNumber, in: 0...99)
                }
                
                Section(header: Text("Album")) {
                    if let album = song.album {
                        Text(album.name)
                        Button("Change Album") { showingAlbumSelection = true }
                    } else {
                        Button("Assign to Album") { showingAlbumSelection = true }
                    }
                }
            }
            .navigationTitle("Edit Song")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        try? modelContext.save()
                        dismiss()
                    }
                }
            }
            .sheet(isPresented: $showingAlbumSelection) {
                AlbumSelectionView(song: song)
            }
        }
    }
}
