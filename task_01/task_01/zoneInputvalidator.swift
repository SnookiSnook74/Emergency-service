//
//  zoneInputvalidator.swift
//  task_01
//
//  Created by DonHalab on 22.11.2023.
//

import Foundation

class ZoneInputValidator {
    static func validate(_ input: ZoneInput) -> String? {
        let coordinateComponents = input.coordinates.split(separator: " ").map { $0.split(separator: ";").map(String.init) }
        switch input.shape {
        case .circle:
            if coordinateComponents.count != 2 || coordinateComponents[0].count != 2 || !coordinateComponents[0].allSatisfy({ Int($0) != nil }) {
                return "Неверный формат координат для круга"
            }
            let radiusPart = coordinateComponents[1].joined(separator: ";")
            if Int(radiusPart) == nil {
                return "Неверный формат радиуса для круга"
            }
        case .triangle:
            if coordinateComponents.count != 3 || !coordinateComponents.allSatisfy({ $0.count == 2 && $0.allSatisfy { Int($0) != nil } }) {
                return "Неверный формат координат для треугольника"
            }
        case .quadrilateral:
            if coordinateComponents.count != 4 || !coordinateComponents.allSatisfy({ $0.count == 2 && $0.allSatisfy { Int($0) != nil } }) {
                return "Неверный формат координат для четырехугольника"
            }
        default:
            return "Неизвестный тип зоны! Введите: circle, triangle, quadrilateral"
        }

        if input.phoneNumber.isEmpty || input.name.isEmpty || input.emergencyDept.isEmpty {
            return "Телефон, имя или код департамента не могут быть пустыми"
        }

        if input.dangerLevel == .unowned {
            return "Неизвестный уровень опасности! Ввведите: low, middle, high"
        }

        return nil
    }
}
