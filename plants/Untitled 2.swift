//
//  Untitled 2.swift
//  plants
//
//  Created by noura on 23/10/2025.
//

import Foundation

struct Plant: Identifiable {
    let id = UUID()
    var name: String
    var room: String
    var light: String
    var water: String
    var watering: String
    var lastWatered: Date?
    
    var wateringIntervalDays: Int {
        switch watering {
        case "Every day": return 1
        case "Every 2 days": return 2
        case "Every 3 days": return 3
        case "Once a week": return 7
        case "Every 10 days": return 10
        case "Every 2 weeks": return 14
        default: return 1
        }
    }
}
