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
            
            ServoStatusView(
                status: controller.status,
                connectionState: controller.connectionState
            )
            
            ServoControlsView(
                selectedSpeed: $selectedSpeed,
                onClockwise: {
                    Task {
                        await controller.sendCommand("clockwise", speed: selectedSpeed)
                    }
                },
                onCounterclockwise: {
                    Task {
                        await controller.sendCommand("counterclockwise", speed: selectedSpeed)
                    }
                },
                onStop: {
                    Task {
                        await controller.sendCommand("stop")
                    }
                },
                isConnected: controller.connectionState == .connected
            )
        }
        .task {
            while !Task.isCancelled {
                await controller.refreshStatus()

                try? await Task.sleep(for: .milliseconds(250))
            }
        }
        .padding(40)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(WoodshopTheme.background)
        .foregroundStyle(WoodshopTheme.ivory)
        .preferredColorScheme(.dark)
    }
}

