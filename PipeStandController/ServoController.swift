//
//  ServoController.swift
//  PipeStandController
//
//  Created by Zach Baron on 11/4/26.
//


import Foundation

@Observable
final class ServoController {

    private let baseURL = "http://10.0.0.9"

    func sendCommand(_ command: String, speed: String = "slow") async {
        guard let url = URL(string: "\(baseURL)/rack/\(command)?speed=\(speed)") else {
            return
        }

        do {
            let (_, response) = try await URLSession.shared.data(from: url)

            if let response = response as? HTTPURLResponse {
                print("Servo command: \(command)")
                print("HTTP status: \(response.statusCode)")
            }
        } catch {
            print("Servo request failed: \(error)")
        }
    }
}
