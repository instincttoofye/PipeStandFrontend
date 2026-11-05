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
            }
        }
        .padding(40)
    }
}

