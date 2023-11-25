//
//  accidentInputvalidator.swift
//  task_01
//
//  Created by DonHalab on 22.11.2023.
//

import Foundation

class AccidentInputValidator {
    static func validate(_ input: AccidentInput) -> String? {
        // Проверка координат инцидента
        let coordinateComponents = input.coordinates.split(separator: ";").map(String.init)
        if coordinateComponents.count != 2 || !coordinateComponents.allSatisfy({ Int($0) != nil }) {
            return "Неверный формат координат инцидента"
        }

        // Проверка описания инцидента
        if input.discription.isEmpty {
            return "Описание инцидента не может быть пустым"
        }

        // Проверка типа инцидента, если он указан
        if input.type == .unknown {
            return "Неверный тип инцидента. Доступные типы: gas leak, fire, cat on the tree"
        }

        return nil
    }
}
