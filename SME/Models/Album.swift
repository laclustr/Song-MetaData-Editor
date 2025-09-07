//
//  Album.swift
//  SME
//
//  Created by Grant Vance on 9/6/25.
//

import Foundation
import SwiftData

@Model
final class Album {
    var name: String
    var artist: String
    var year: Int
    var createdAt: Date
    @Relationship(deleteRule: .nullify, inverse: \Song.album) var songs: [Song] = []
    
    var sortedSongs: [Song] {
        songs.sorted { $0.trackNumber < $1.trackNumber }
    }
    
    init(name: String, artist: String, year: Int = 0) {
        self.name = name
        self.artist = artist
        self.year = year
        self.createdAt = Date()
    }
}
