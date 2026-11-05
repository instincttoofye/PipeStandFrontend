//
//  ServoStatus.swift
//  PipeStandController
//
//  Created by Zach Baron on 11/5/26.
//

import Foundation

struct ServoStatus: Codable {
    let isMoving: Bool
    let currentPulse: Int
    let targetPulse: Int
    
    var speed: String {
        guard isMoving, targetPulse != 1500 else {
            return "Stopped"
        }
        
        let offset = abs(targetPulse - 1500)
        
        switch offset {
        case 175:
            return "Slow"
        case 225:
            return "Medium"
        case 275:
            return "Fast"
        default:
            return "Unknown"
        }
    }
    
    var direction: String {
        guard isMoving else {
            return "Stopped"
        }
        
        if targetPulse == 1500 {
            return "Stopping"
        }
        
        let currentDirection = currentPulse < 1500 ? -1 :
        currentPulse > 1500 ? 1 : 0
        
        let targetDirection = targetPulse < 1500 ? -1 : 1
        
        if currentDirection != 0 &&
            currentDirection != targetDirection {
            return "Reversing..."
        }
        
        if currentDirection == 0 {
            return "Transitioning..."
        }
        
        return targetDirection == -1
        ? "Clockwise"
        : "Counterclockwise"
    }
}
