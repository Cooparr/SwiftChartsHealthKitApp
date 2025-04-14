//
//  SwiftChartsHealthKitApp.swift
//  SwiftChartsHealthKitApp
//
//  Created by Alexander Cooper on 04/04/2025.
//

import SwiftUI

@main
struct SwiftChartsHealthKitApp: App {
    
    let healthKitManager = HealthKitManager()
    
    var body: some Scene {
        WindowGroup {
            DashboardView()
                .environment(healthKitManager)
        }
    }
}
