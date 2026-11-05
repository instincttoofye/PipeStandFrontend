//
//  ServoStatusView.swift
//  PipeStandController
//
//  Created by Zach Baron on 11/5/26.
//


import SwiftUI

struct ServoStatusView: View {
    let status: ServoStatus?

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Motor Status")
                    .font(.headline)

                Spacer()

                HStack(spacing: 8) {
                    Circle()
                        .fill(status?.isMoving == true ? .green : .gray)
                        .frame(width: 10, height: 10)

                    Text(status?.isMoving == true ? "Rotating" : "Stopped")
                }
            }

            Divider()

            HStack(spacing: 32) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Direction")
                        .font(.caption)
                        .foregroundStyle(.secondary)

                    Text(status?.direction ?? "Unknown")
                        .font(.title3)
                        .bold()
                }

                Spacer()

                VStack(alignment: .leading, spacing: 4) {
                    Text("Speed")
                        .font(.caption)
                        .foregroundStyle(.secondary)

                    Text(status?.speed ?? "Unknown")
                        .font(.title3)
                        .bold()
                }
            }
        }
        .padding(20)
        .background(.regularMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}