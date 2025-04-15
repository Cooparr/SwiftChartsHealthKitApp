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
    
    static var Mockdata: [HealthMetric] {
        var array: [HealthMetric] = []
        for i in 0..<28 {
            array.append(HealthMetric(date: Calendar.current.date(byAdding: .day, value: -i, to: .now)!, value: Double.random(in: 4000...10000)))
        }
        return array
    }
}
