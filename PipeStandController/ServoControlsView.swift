//
//  ServoControlsView.swift
//  PipeStandController
//
//  Created by Zach Baron on 11/5/26.
//


import SwiftUI

struct ServoControlsView: View {
    @Binding var selectedSpeed: String

    let onClockwise: () -> Void
    let onCounterclockwise: () -> Void
    let onStop: () -> Void

    var body: some View {
        VStack(spacing: 20) {
            Picker("Rotation Speed", selection: $selectedSpeed) {
                Text("Slow").tag("slow")
                Text("Medium").tag("medium")
                Text("Fast").tag("fast")
            }
            .pickerStyle(.segmented)

            HStack(spacing: 16) {
                Button("↺ Counterclockwise", action: onCounterclockwise)

                Button("Clockwise ↻", action: onClockwise)
            }

            Button("Stop Rotation", action: onStop)
                .controlSize(.large)
                .tint(.red)
        }
    }
}