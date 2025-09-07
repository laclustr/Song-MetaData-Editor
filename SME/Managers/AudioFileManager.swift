//
//  AudioFileManager.swift
//  SME
//
//  Created by Grant Vance on 9/6/25.
//

import Foundation
import AVFoundation

@MainActor
class AudioFileManager: ObservableObject {
    func importAudioFile() async -> URL? {
        return nil // Placeholder
    }
    
    func extractMetadata(from url: URL) -> (title: String, artist: String, duration: Double, genre: String?, year: Int, trackNumber: Int)? {
        let asset = AVAsset(url: url)
        
        var title = url.deletingPathExtension().lastPathComponent
        var artist = "Unknown Artist"
        var duration: Double = 0
        var genre: String?
        var year: Int = 0
        var trackNumber: Int = 0
        
        duration = CMTimeGetSeconds(asset.duration)
        
        let metadata = asset.metadata
        for item in metadata {
            guard let key = item.commonKey?.rawValue,
                  let value = item.value else { continue }
            
            switch key {
            case "title": title = value as? String ?? title
            case "artist": artist = value as? String ?? artist
            case "genre": genre = value as? String
            case "creationDate":
                if let dateString = value as? String {
                    let formatter = DateFormatter()
                    formatter.dateFormat = "yyyy"
                    year = Int(dateString.prefix(4)) ?? 0
                }
            case "trackNumber": trackNumber = value as? Int ?? 0
            default: break
            }
        }
        
        return (title, artist, duration, genre, year, trackNumber)
    }
    
    func deleteAudioFile(at url: URL) {
        try? FileManager.default.removeItem(at: url)
    }
}
