//
//  HealthKitPermissionView.swift
//  SwiftChartsHealthKitApp
//
//  Created by Alexander Cooper on 05/04/2025.
//

import SwiftUI

struct HealthKitPermissionView: View {
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
                print("Did tap")
            }
            .buttonStyle(.borderedProminent)
            .tint(.pink)
        }
        .padding(30)
    }
}

#Preview("English") {
    HealthKitPermissionView()
}

#Preview("Korean") {
    HealthKitPermissionView()
        .environment(\.locale, Locale(identifier: "ko"))
}
