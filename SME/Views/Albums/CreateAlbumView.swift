//
//  CreateAlbumView.swift
//  SME
//
//  Created by Grant Vance on 9/6/25.
//

import SwiftUI
import SwiftData

struct CreateAlbumView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    @State private var name = ""
    @State private var artist = ""
    @State private var year = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section("Album Info") {
                    TextField("Album Name", text: $name)
                    TextField("Artist", text: $artist)
                    TextField("Year", text: $year)
                        .keyboardType(.numberPad)
                }
            }
            .navigationTitle("New Album")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Create") { createAlbum() }
                        .disabled(name.isEmpty || artist.isEmpty)
                }
            }
        }
    }
    
    private func createAlbum() {
        let album = Album(
            name: name,
            artist: artist,
            year: Int(year) ?? 0
        )
        modelContext.insert(album)
        try? modelContext.save()
        dismiss()
    }
}
