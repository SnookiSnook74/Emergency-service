//
//  main.swift
//  task_01
//
//  Created by DonHalab on 21.11.2023.
//

import Foundation

func createZone() -> Zone? {
    let userInptutZone = UserInputHandler.userInput()
    if let errorMassege = ZoneInputValidator.validate(userInptutZone) {
        print("Ошибка: \(errorMassege)")
        return nil
    } else {
        return Zone(coordinates: userInptutZone.coordinates, type: userInptutZone.shape, phoneNumber: userInptutZone.phoneNumber, name: userInptutZone.name, emergencyDeptCode: userInptutZone.emergencyDept, dangerLevel: userInptutZone.dangerLevel)
    }
}

func createAccident() -> AccidentInput? {
    let userInputAccident = UserInputHandler.accidentInput()
    if let errorAccidentMassege = AccidentInputValidator.validate(userInputAccident) {
        print("Ошибка: \(errorAccidentMassege)")
        return nil
    } else {
        return AccidentInput(coordinates: userInputAccident.coordinates, discription: userInputAccident.discription, phoneNumber: userInputAccident.phoneNumber, type: userInputAccident.type)
    }
}

func accidentInfo(accident: AccidentInput) {
    print("""
    The accident info:
    -----------------------------------------------------
    Description: \(accident.discription)
    Phone number: \(accident.phoneNumber?.applyPhoneNumberMask() ?? "")
    Type: \(accident.type.rawValue)
    -----------------------------------------------------
    """)
}

func menu() {
    guard let zoneOne = createZone() else { return }
    guard let accidentOne = createAccident() else { return }
    if zoneOne.beginArea(accident: accidentOne) {
        zoneOne.zoneInfo()
        accidentInfo(accident: accidentOne)
    } else {
        print("""
        ---------------------------------------------------------------
        An accident is not in \(zoneOne.name)
        Switch the applicant to the common number: \(defaultNumberPhone)
        ----------------------------------------------------------------
        """)
    }
}

menu()
