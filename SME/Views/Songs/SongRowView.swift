//
//  SongRowView.swift
//  SME
//
//  Created by Grant Vance on 9/6/25.
//

import SwiftUI

struct SongRowView: View {
    let song: Song
    let onEdit: () -> Void
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(song.title).font(.headline)
                Text(song.artist).font(.subheadline).foregroundColor(.secondary)
                
                HStack {
                    if let genre = song.genre {
                        Text(genre)
                            .font(.caption)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 2)
                            .background(Color.blue.opacity(0.2))
                            .cornerRadius(4)
                    }
                    
                    if song.year > 0 {
                        Text("\(song.year)")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    
                    Spacer()
                    Text(formatDuration(song.duration))
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            Spacer()
            Button("Edit") { onEdit() }
                .buttonStyle(.bordered)
                .controlSize(.small)
        }
    }
    
    private func formatDuration(_ duration: Double) -> String {
        let minutes = Int(duration) / 60
        let seconds = Int(duration) % 60
        return String(format: "%d:%02d", minutes, seconds)
    }
}
