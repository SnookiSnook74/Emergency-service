//
//  userInputhandler.swift
//  task_03
//
//  Created by DonHalab on 24.11.2023.
//

import Foundation

class UserInputHandler {
    static func userInput() -> ZoneInput {
        print("Enter zone parameters:")
        let zoneCoordinates = readLine() ?? "Нет данных"
        print("Enter zone info:")
        print("Enter the shape of area:")
        let shapeInput = readLine() ?? ""
        let shapeArea = ZoneShape(rawValue: shapeInput.lowercased()) ?? .unowned

        print("Enter phone number:")
        let phoneNumber = readLine() ?? "Нет данных"

        print("Enter name:")
        let name = readLine() ?? "Нет данных"

        print("Enter emergency dept:")
        let emergencyDept = readLine() ?? "Нет данных"

        print("Enter danger level:")
        let dangerLevelInput = readLine() ?? ""
        let dangerLevel = DangerLevel(rawValue: dangerLevelInput.lowercased()) ?? .unowned

        return ZoneInput(coordinates: zoneCoordinates, shape: shapeArea, phoneNumber: phoneNumber, name: name, emergencyDept: emergencyDept, dangerLevel: dangerLevel)
    }

    static func accidentInput() -> AccidentInput {
        print("Enter an accident coordinates:")
        let coordinates = readLine() ?? "Нет данных"
        print("Enter the accident info:")
        print("Enter description:")
        let description = readLine() ?? "Нет данных"

        print("Enter phone number: ")
        let phoneNumber = readLine() // nil если пользователь не ввел данные

        print("Enter type:")
        let typeInput = readLine() ?? "Нет данных"

        let type = AccidentType(rawValue: typeInput.lowercased()) ?? AccidentType.unknown

        return AccidentInput(coordinates: coordinates, discription: description, phoneNumber: phoneNumber, type: type)
    }
}
