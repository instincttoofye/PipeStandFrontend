//
//  ServoStatusView.swift
//  PipeStandController
//
//  Created by Zach Baron on 11/5/26.
//


import SwiftUI

struct ServoStatusView: View {
    let status: ServoStatus?
    let connectionState: ConnectionState
    
    private var connectionColor: Color {
        switch connectionState {
        case .connecting:
            return .orange
        case .connected:
            return WoodshopTheme.sage
        case .disconnected:
            return .red
        }
    }

    private var connectionLabel: String {
        switch connectionState {
        case .connecting:
            return "Connecting..."
        case .connected:
            return "Connected"
        case .disconnected:
            return "Disconnected"
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Motor Status")
                    .font(.headline)

                Spacer()

                HStack(spacing: 8) {
                    Circle()
                        .fill(connectionColor)
                        .frame(width: 10, height: 10)

                    Text(connectionLabel)
                }
            }

            Divider()

            HStack(spacing: 32) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Direction")
                        .font(.caption)
                        .foregroundStyle(.secondary)

                    Text(status?.direction ?? "Unavailable")
                        .font(.title3)
                        .bold()
                }

                Spacer()

                VStack(alignment: .leading, spacing: 4) {
                    Text("Speed")
                        .font(.caption)
                        .foregroundStyle(.secondary)

                    Text(status?.speed ?? "Unavailable")
                        .font(.title3)
                        .bold()
                }
            }

            if connectionState == .connected {
                Text(status?.isMoving == true ? "Motor: Rotating" : "Motor: Stopped")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .padding(20)
        .background(WoodshopTheme.surface)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay {
            RoundedRectangle(cornerRadius: 16)
                .strokeBorder(
                    WoodshopTheme.brass.opacity(0.35),
                    lineWidth: 1
                )
        }    }
}
