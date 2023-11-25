//
//  phonenumbermask.swift
//  task_01
//
//  Created by DonHalab on 23.11.2023.
//

import Foundation

extension String {
    func applyPhoneNumberMask() -> String {
        // Удаление всех символов, кроме цифр
        let digits = filter { $0.isNumber }

        // Определение длины и начальной цифры номера
        if (digits.count == 11 && (digits.first == "7" || digits.first == "8")) || (hasPrefix("+7") && filter { $0.isNumber }.count == 11) {
            // Определение кода оператора
            let operatorCode = String(digits.prefix(4).suffix(3))
            // Применение маски в зависимости от кода оператора
            if operatorCode == "800" {
                // Маска для номера с кодом оператора 800
                return "8 (\(operatorCode)) \(digits.suffix(7).prefix(3)) \(digits.suffix(4).prefix(2)) \(digits.suffix(2))"
            } else {
                // Маска для других номеров
                let mainPart = digits.hasPrefix("8") ? String(digits.dropFirst()) : digits
                return "+7 \(mainPart.prefix(3)) \(mainPart.dropFirst(3).prefix(3))-\(mainPart.dropFirst(6).prefix(2))-\(mainPart.suffix(2))"
            }
        } else {
            // Если номер не соответствует условиям, возвращаем оригинальный
            return self
        }
    }
}
