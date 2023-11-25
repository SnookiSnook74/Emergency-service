//
//  city.swift
//  task_03
//
//  Created by DonHalab on 24.11.2023.
//

import Foundation

class City {
    private var zones: [Zone]
    let nameCity: String
    let emergencyPhoneNumber: String

    init(nameCity: String, emergencyPhoneNumber: String) {
        zones = []
        self.nameCity = nameCity
        self.emergencyPhoneNumber = emergencyPhoneNumber
    }

    func addZone(_ zone: Zone) {
        zones.append(zone)
    }

    func findZoneForAccident(_ accident: AccidentInput) -> Zone? {
        var closestZone: Zone?
        var minDistance = Double.greatestFiniteMagnitude

        for zone in zones {
            if zone.beginArea(accident: accident) {
                // Если инцидент находится в зоне, возвращаем эту зону
                return zone
            }
            // Вычисляем расстояние до зоны
            let distance = zone.distanceTo(accident: accident)
            if distance < minDistance {
                minDistance = distance
                closestZone = zone
            }
        }
        print("The accident didn't match with any zone. The nearest zone: \(closestZone!.name)")
        return closestZone
    }

    func getCityInfo() {
        print("""
        The city info:
        -----------------------------------------------------
        Name: \(nameCity)
        Type: \(emergencyPhoneNumber.applyPhoneNumberMask())
        -----------------------------------------------------
        """)
    }

    func accidentInfo(accident: AccidentInput) {
        print("""
        The accident info:
        -----------------------------------------------------
        Description: \(accident.discription)
        Phone number: \(accident.phoneNumber?.applyPhoneNumberMask() ?? "")
        Type: \(accident.type?.rawValue ?? "")
        -----------------------------------------------------
        """)
    }
}
