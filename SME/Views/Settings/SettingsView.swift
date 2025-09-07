//
//  SettingsView.swift
//  SME
//
//  Created by Grant Vance on 9/6/25.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var cloudKitManager: CloudKitManager
    
    var body: some View {
        NavigationView {
            List {
                cloudSyncSection
                storageSection
                aboutSection
            }
            .navigationTitle("Settings")
        }
        .task {
            await cloudKitManager.checkAccountStatus()
        }
    }
    
    // MARK: - Sections
    
    private var cloudSyncSection: some View {
        Section("Cloud Sync") {
            HStack {
                Text("iCloud Status")
                Spacer()
                Text(cloudKitManager.isCloudKitAvailable ? "Available" : "Unavailable")
                    .foregroundColor(cloudKitManager.isCloudKitAvailable ? .green : .red)
            }
            
            Button("Sync to iCloud") {
                Task { await cloudKitManager.syncToCloud() }
            }
            .disabled(!cloudKitManager.isCloudKitAvailable || cloudKitManager.isSyncing)
            
            if cloudKitManager.isSyncing {
                HStack {
                    ProgressView().controlSize(.small)
                    Text("Syncing...")
                }
            }
            
            if let lastSync = cloudKitManager.lastSyncDate {
                Text("Last sync: \(lastSync, style: .relative)")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
    }
    
    private var storageSection: some View {
        Section("Storage") {
            Button("Clear Local Cache") {
                // TODO: Implement cache clearing
            }
            
            Button("Export Library") {
                // TODO: Implement export functionality
            }
        }
    }
    
    private var aboutSection: some View {
        Section("About") {
            HStack {
                Text("Version")
                Spacer()
                Text("1.0.0").foregroundColor(.secondary)
            }
        }
    }
}
