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
    
}
