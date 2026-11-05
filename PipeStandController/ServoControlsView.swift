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
    
    let isConnected: Bool

    var body: some View {
        VStack(spacing: 20) {
            VStack(alignment: .leading, spacing: 10) {
                Text("ROTATION SPEED")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .tracking(2)
                    .foregroundStyle(WoodshopTheme.brass)
                HStack(spacing: 4) {
                    ForEach(["slow", "medium", "fast"], id: \.self) { speed in
                        Button {
                            selectedSpeed = speed
                        } label: {
                            Text(speed.capitalized)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 8)
                                .background(
                                    selectedSpeed == speed
                                    ? WoodshopTheme.brass
                                    : Color.clear
                                )
                                .foregroundStyle(
                                    selectedSpeed == speed
                                    ? WoodshopTheme.background
                                    : WoodshopTheme.ivory
                                )
                                .clipShape(RoundedRectangle(cornerRadius: 6))
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(4)
                .background(WoodshopTheme.surface)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            }

            HStack(spacing: 16) {
                Button(action: onCounterclockwise) {
                    Label("Counterclockwise", systemImage: "arrow.counterclockwise")
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 10)
                }
                .buttonStyle(.borderedProminent)
                .tint(WoodshopTheme.brass)

                Button(action: onClockwise) {
                    Label("Clockwise", systemImage: "arrow.clockwise")
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 10)
                }
                .buttonStyle(.borderedProminent)
                .tint(WoodshopTheme.brass)
            }

            Button(action: onStop) {
                Label("Stop Rotation", systemImage: "stop.fill")
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
            }
            .buttonStyle(.borderedProminent)
            .tint(Color(red: 0.55, green: 0.24, blue: 0.20))
        }
        .disabled(!isConnected)
    }
}
