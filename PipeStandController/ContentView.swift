//
//  ContentView.swift
//  PipeStandController
//
//  Created by Zach Baron on 11/4/26.
//

import SwiftUI

struct ContentView: View {

    @State private var controller = ServoController()
    @State private var selectedSpeed: String = "slow"

    var body: some View {
        VStack(spacing: 24) {

            Text("Pipe Stand Controller")
                .font(.title)
            
            Picker("Rotation Speed", selection: $selectedSpeed) {
                Text("Slow").tag( "slow" )
                Text("Medium").tag( "medium" )
                Text("Fast").tag( "fast" )
            }
            .pickerStyle(.segmented)

            HStack(spacing: 20) {

                Button("↺ Counterclockwise") {
                    Task {
                        await controller.sendCommand("counterclockwise", speed: selectedSpeed)
                    }
                }

                Button("Stop") {
                    Task {
                        await controller.sendCommand("stop")
                    }
                }

                Button("Clockwise ↻") {
                    Task {
                        await controller.sendCommand("clockwise", speed: selectedSpeed)
                    }
                }
                
                Button("Check Status") {
                    Task {
                        if let status = await controller.fetchStatus() {
                            print("Moving: \(status.isMoving)")
                            print("Current pulse: \(status.currentPulse)")
                            print("Target pulse: \(status.targetPulse)")
                        }
                    }
                }
            }
            
            Divider()
            
            HStack(spacing: 8) {
                Circle()
                    .fill(controller.status?.isMoving == true ? .green : .gray)
                    .frame(width: 10, height: 10)

                Text(controller.status?.isMoving == true ? "Rotating" : "Stopped")
                
                Text("Speed: \(controller.status?.speed ?? "unknown")")
                
                Text("Direction: \(controller.status?.direction ?? "unknown")")
            }
        }
        .task {
            while !Task.isCancelled {
                await controller.refreshStatus()

                try? await Task.sleep(for: .milliseconds(250))
            }
        }
        .padding(40)
    }
}

