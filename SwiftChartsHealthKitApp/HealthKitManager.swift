//
//  HealthKitManager.swift
//  SwiftChartsHealthKitApp
//
//  Created by Alexander Cooper on 05/04/2025.
//

import SwiftUI
import HealthKit
import HealthKitUI
import Observation

@Observable class HealthKitManager {
    let store = HKHealthStore()
    let types: Set = [
        HKQuantityType(.stepCount),
        HKQuantityType(.bodyMass)
    ]
    
    
//    func addSimulatedData() async {
//        var mockSamples = [HKQuantitySample]()
//        
//        for i in 0..<28 {
//            let startDate = Calendar.current.date(byAdding: .day, value: -i, to: .now)!
//            let endDate = Calendar.current.date(byAdding: .second, value: 1, to: startDate)!
//            
//            // Step
//            let stepQuantity = HKQuantity(unit: .count(), doubleValue: .random(in: 4000...10000))
//            let stepSample = HKQuantitySample(type: HKQuantityType(.stepCount), quantity: stepQuantity, start: startDate, end: endDate)
//            mockSamples.append(stepSample)
//            
//            // Weight Sample
//            let weightQuantity = HKQuantity(unit: .pound(), doubleValue: .random(in: (160 + Double(i/3)...165 + Double(i/3))))
//            let weightSample = HKQuantitySample(type: HKQuantityType(.bodyMass), quantity: weightQuantity, start: startDate, end: endDate)
//            mockSamples.append(weightSample)
//            
//        }
//        
//        try! await store.save(mockSamples)
//        print("📀 Mock Data Saved")
//    }
}
