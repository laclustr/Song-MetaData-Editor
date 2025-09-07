//
//  AlbumRowView.swift
//  SME
//
//  Created by Grant Vance on 9/6/25.
//

import SwiftUI

struct AlbumRowView: View {
    var album: Album
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(album.name).font(.headline)
            Text(album.artist).font(.subheadline).foregroundColor(.secondary)
            
            HStack {
                Text("\(album.songs.count) songs")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                if album.year > 0 {
                    Spacer()
                    Text("\(album.year)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
        }
    }
}
