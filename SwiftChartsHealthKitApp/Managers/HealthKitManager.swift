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
    
    var stepData = [HealthMetric]()
    var weightData = [HealthMetric]()
    
    
    func fetchStepCount() async {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: .now)
        let endDate = calendar.date(byAdding: .day, value: 1, to: today)!
        let startDate = calendar.date(byAdding: .day, value: -28, to: endDate)!
        
        let queryPredicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate)
        let quantityType = HKQuantityType(.stepCount)
        let samplePredicate = HKSamplePredicate.quantitySample(type: quantityType, predicate: queryPredicate)
        
        let stepsQuery = HKStatisticsCollectionQueryDescriptor(
            predicate: samplePredicate,
            options: .cumulativeSum,
            anchorDate: endDate,
            intervalComponents: DateComponents(day: 1)
        )
        
        do {
            let stepCounts = try await stepsQuery.result(for: store)
            stepData = stepCounts.statistics().compactMap { stepData in
                HealthMetric(date: stepData.startDate, value: stepData.sumQuantity()?.doubleValue(for: .count()) ?? 0)
            }
        } catch {
            print("Fetch step count error!")
        }
    }
    
    
    func fetchWeightData() async {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: .now)
        let endDate = calendar.date(byAdding: .day, value: 1, to: today)!
        let startDate = calendar.date(byAdding: .day, value: -28, to: endDate)!
        
        let queryPredicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate)
        let quantityType = HKQuantityType(.bodyMass)
        let samplePredicate = HKSamplePredicate.quantitySample(type: quantityType, predicate: queryPredicate)
        
        let weightQuery = HKStatisticsCollectionQueryDescriptor(
            predicate: samplePredicate,
            options: .mostRecent,
            anchorDate: endDate,
            intervalComponents: DateComponents(day: 1)
        )
        
        do {
            let weights = try await weightQuery.result(for: store)
            weightData = weights.statistics().compactMap { weightData in
                HealthMetric(date: weightData.startDate, value: weightData.mostRecentQuantity()?.doubleValue(for: .gram()) ?? 0)
            }
        } catch {
            print("Fetch weight error!")
        }
    }
    
    
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
