//
//  CloudKitManager.swift
//  SME
//
//  Created by Grant Vance on 9/6/25.
//

import Foundation
import CloudKit

@MainActor
class CloudKitManager: ObservableObject {
    private let container = CKContainer.default()
    @Published var isSyncing = false
    @Published var lastSyncDate: Date?
    @Published var isCloudKitAvailable = false
    
    init() {
        Task { await checkAccountStatus() }
    }
    
    func checkAccountStatus() async {
        do {
            let status = try await container.accountStatus()
            isCloudKitAvailable = status == .available
        } catch {
            print("CloudKit account error: \(error)")
            isCloudKitAvailable = false
        }
    }
    
    func syncToCloud() async {
        isSyncing = true
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        isSyncing = false
        lastSyncDate = Date()
    }
}
