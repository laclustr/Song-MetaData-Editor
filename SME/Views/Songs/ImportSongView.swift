//
//  ImportSongView.swift
//  SME
//
//  Created by Grant Vance on 9/6/25.
//

import SwiftUI
import SwiftData

struct ImportSongView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject private var audioFileManager: AudioFileManager
    
    @State private var isImporting = false
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                Button(action: { isImporting = true }) {
                    Label("Select Audio File", systemImage: "square.and.arrow.down")
                        .padding()
                        .background(Color.blue.opacity(0.2))
                        .cornerRadius(8)
                }
                Spacer()
            }
            .navigationTitle("Import Song")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") { dismiss() }
                }
            }
        }
        .fileImporter(
            isPresented: $isImporting,
            allowedContentTypes: [.audio],
            allowsMultipleSelection: false
        ) { result in
            switch result {
            case .success(let urls):
                if let url = urls.first {
                    handleImport(url: url)
                }
            case .failure(let error):
                print("File import failed: \(error.localizedDescription)")
            }
        }
    }
    
    private func handleImport(url: URL) {
        if let metadata = audioFileManager.extractMetadata(from: url) {
            let song = Song(
                title: metadata.title,
                artist: metadata.artist,
                duration: metadata.duration,
                genre: metadata.genre,
                year: metadata.year,
                trackNumber: metadata.trackNumber,
                fileURL: url
            )
            modelContext.insert(song)
            try? modelContext.save()
        }
        dismiss()
    }
}
