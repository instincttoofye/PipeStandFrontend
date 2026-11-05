//
//  ServoController.swift
//  PipeStandController
//
//  Created by Zach Baron on 11/4/26.
//


import Foundation

@MainActor
@Observable
final class ServoController {

    private let baseURL = "http://10.0.0.9"
    
    private(set) var status: ServoStatus?
    private(set) var connectionState: ConnectionState = .connecting

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
    
    func fetchStatus() async -> ServoStatus? {
        guard let url = URL(string: "\(baseURL)/rack/status") else {
            return nil
        }

        do {
            var request = URLRequest(url: url)
            request.timeoutInterval = 2

            let (data, response) = try await URLSession.shared.data(for: request)

            guard let response = response as? HTTPURLResponse,
                  response.statusCode == 200 else {
                return nil
            }

            return try JSONDecoder().decode(ServoStatus.self, from: data)
        } catch {
            print("Failed to fetch servo status: \(error)")
            return nil
        }
    }
    
    func refreshStatus() async {
        if let newStatus = await fetchStatus() {
            status = newStatus
            connectionState = .connected
        } else {
            status = nil
            connectionState = .disconnected
        }
    }
}
