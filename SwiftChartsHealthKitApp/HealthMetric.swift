//
//  HealthMetric.swift
//  SwiftChartsHealthKitApp
//
//  Created by Alexander Cooper on 15/04/2025.
//

import Foundation

struct HealthMetric: Identifiable {
    let id: UUID = UUID()
    let date: Date
    let value: Double
}
