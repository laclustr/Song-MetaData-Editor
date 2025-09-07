//
//  AlbumDetailView.swift
//  SME
//
//  Created by Grant Vance on 9/6/25.
//

import SwiftUI
import SwiftData

struct AlbumDetailView: View {
    @Bindable var album: Album
    
    var body: some View {
        List {
            Section {
                VStack(alignment: .leading, spacing: 8) {
                    Text(album.name).font(.title2).bold()
                    Text(album.artist).font(.title3).foregroundColor(.secondary)
                    if album.year > 0 {
                        Text("\(album.year)").font(.caption).foregroundColor(.secondary)
                    }
                }
                .padding(.vertical)
            }
            
            Section("Songs (\(album.songs.count))") {
                ForEach(album.sortedSongs) { song in
                    HStack {
                        if song.trackNumber > 0 {
                            Text("\(song.trackNumber)")
                                .font(.caption)
                                .foregroundColor(.secondary)
                                .frame(width: 20)
                        }
                        VStack(alignment: .leading) {
                            Text(song.title).font(.headline)
                            if song.artist != album.artist {
                                Text(song.artist)
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                        }
                        Spacer()
                        Text(formatDuration(song.duration))
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
            }
        }
        .navigationTitle("Album")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func formatDuration(_ duration: Double) -> String {
        let minutes = Int(duration) / 60
        let seconds = Int(duration) % 60
        return String(format: "%d:%02d", minutes, seconds)
    }
}
