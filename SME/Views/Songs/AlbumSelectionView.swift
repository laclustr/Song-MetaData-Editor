//
//  AlbumSelectionView.swift
//  SME
//
//  Created by Grant Vance on 9/6/25.
//

import SwiftUI
import SwiftData

struct AlbumSelectionView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    var song: Song
    @Query(sort: \Album.name) private var albums: [Album]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(albums) { album in
                    Button {
                        song.album = album
                        try? modelContext.save()
                        dismiss()
                    } label: {
                        HStack {
                            Text(album.name)
                            Spacer()
                            if song.album == album {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.blue)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Select Album")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") { dismiss() }
                }
            }
        }
    }
}
