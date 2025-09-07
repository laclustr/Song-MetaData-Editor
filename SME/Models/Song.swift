//
//  Song.swift
//  SME
//
//  Created by Grant Vance on 9/6/25.
//

import Foundation
import SwiftData

@Model
final class Song {
    var title: String
    var artist: String
    var duration: Double
    var genre: String?
    var year: Int
    var trackNumber: Int
    var fileURL: URL?
    var createdAt: Date
    var album: Album?
    
    init(
        title: String,
        artist: String,
        duration: Double = 0,
        genre: String? = nil,
        year: Int = 0,
        trackNumber: Int = 0,
        fileURL: URL? = nil
    ) {
        self.title = title
        self.artist = artist
        self.duration = duration
        self.genre = genre
        self.year = year
        self.trackNumber = trackNumber
        self.fileURL = fileURL
        self.createdAt = Date()
    }
}
