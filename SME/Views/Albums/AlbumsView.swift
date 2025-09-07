//
//  AlbumsView.swift
//  SME
//
//  Created by Grant Vance on 9/6/25.
//

import SwiftUI
import SwiftData

struct AlbumsView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var showingCreateSheet = false
    @Query(sort: \Album.name) private var albums: [Album]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(albums) { album in
                    NavigationLink(destination: AlbumDetailView(album: album)) {
                        AlbumRowView(album: album)
                    }
                }
                .onDelete(perform: deleteAlbums)
            }
            .navigationTitle("Albums")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("New Album") { showingCreateSheet = true }
                }
            }
        }
        .sheet(isPresented: $showingCreateSheet) {
            CreateAlbumView()
        }
    }
    
    private func deleteAlbums(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(albums[index])
            }
            try? modelContext.save()
        }
    }
}
