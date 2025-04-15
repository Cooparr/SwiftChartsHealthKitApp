//
//  HealthKitPermissionView.swift
//  SwiftChartsHealthKitApp
//
//  Created by Alexander Cooper on 05/04/2025.
//

import SwiftUI

struct HealthKitPermissionView: View {
    
    @Environment(HealthKitManager.self) private var healthKitManager
    @Environment(\.dismiss) private var dismiss
    @State private var isShowingHealthKitPermissions: Bool = false
    @Binding var hasSeen: Bool
    
    var body: some View {
        VStack(spacing: 130) {
            VStack(alignment: .leading, spacing: 12) {
                Image(.healthKitIcon)
                    .resizable()
                    .frame(width: 100, height: 100)
                    .shadow(color: .gray.opacity(0.3), radius: 16)
                    .padding(.bottom, 12)
                
                Text("HealthKitPermissionTitle")
                    .font(.title2)
                    .fontWeight(.bold)
                
                Text("HealthKitPermissionSubtitle")
                    .foregroundStyle(.secondary)
            }
            
            Button("HealthKitPermissionButtonTitle") {
                isShowingHealthKitPermissions = true
            }
            .buttonStyle(.borderedProminent)
            .tint(.pink)
        }
        .padding(30)
        .interactiveDismissDisabled()
        .onAppear {
            hasSeen = true
        }
        .healthDataAccessRequest(
            store: healthKitManager.store,
            shareTypes: healthKitManager.types,
            readTypes: healthKitManager.types,
            trigger: isShowingHealthKitPermissions) { permissionResult in
                switch permissionResult {
                case .success:
                    dismiss()
                case .failure:
                    //TODO: Add error handling
                    dismiss()
                }
            }
    }
}

#Preview("English") {
    HealthKitPermissionView(hasSeen: .constant(true))
        .environment(HealthKitManager())
}

#Preview("Korean") {
    HealthKitPermissionView(hasSeen: .constant(true))
        .environment(\.locale, .init(identifier: "ko"))
        .environment(HealthKitManager())
}
