//
//  DashboardView.swift
//  SwiftChartsHealthKitApp
//
//  Created by Alexander Cooper on 04/04/2025.
//

import SwiftUI
import Charts

enum HealthMetricContext: CaseIterable, Identifiable {
    case steps, weight
    
    var id: Self { self }
    
    var title: String {
        switch self {
        case .steps:
            return String(localized: "Steps")
            
        case .weight:
            return String(localized: "Weight")
        }
    }
    
    var metricColor: Color {
        switch self {
        case .steps:
            return .pink
            
        case .weight:
            return .indigo
        }
    }
}


struct DashboardView: View {
    
    @Environment(HealthKitManager.self) private var hkManager
    @AppStorage("hasSeenPermissionRequest") private var hasSeenPermissionRequest = false
    @State private var isShowingPermissionSheet = false
    @State private var selectedStat: HealthMetricContext = .steps
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    
                    Picker("Selected Stat", selection: $selectedStat) {
                        ForEach(HealthMetricContext.allCases) { metric in
                            Text(metric.title)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    // Steps
                    StepsBarChartView(selectedStat: selectedStat, chartData: hkManager.stepData)
                    
                    
                    // Averages
                    VStack(alignment: .leading) {
                        VStack(alignment: .leading) {
                            Label("Averages", systemImage: "calendar")
                                .font(.title3.bold())
                                .foregroundStyle(.pink)
                            
                            Text("Last 28 Days")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        .padding(.bottom, 12)
                        
                        RoundedRectangle(cornerRadius: 12)
                            .foregroundStyle(.secondary)
                            .frame(height: 240)
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 12).fill(Color(.secondarySystemBackground)))
                }
            }
            .padding()
            .task {
                await hkManager.fetchStepCount()
                isShowingPermissionSheet = !hasSeenPermissionRequest
            }
            .navigationTitle("Dashboard")
            .navigationDestination(for: HealthMetricContext.self) { healthMetricContext in
                HealthDataListView(metric: healthMetricContext)
            }
            .sheet(isPresented: $isShowingPermissionSheet) {
                //TODO: Fetch health data
            } content: {
                HealthKitPermissionView(hasSeen: $hasSeenPermissionRequest)
            }
            
        }
        .tint(selectedStat.metricColor)
    }
    
    
}

#Preview("English") {
    DashboardView()
        .environment(HealthKitManager())
}

#Preview("Korean") {
    DashboardView()
        .environment(\.locale, Locale(identifier: "ko"))
        .environment(HealthKitManager())
}
