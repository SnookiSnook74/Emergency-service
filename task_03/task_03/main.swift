//
//  main.swift
//  task_03
//
//  Created by DonHalab on 24.11.2023.
//

import Foundation

func menu() {
    print("Enter an accident coordinates:")
    let coordinates = readLine() ?? "Нет данных"
    let accident = AccidentInput(coordinates: coordinates, discription: "the woman said her cat can't get off the tree", phoneNumber: "+7 934 736-28-26", type: .catOnTree)
    if AccidentInputValidator.validate(accident) != nil {
        print("Не правильный формат координат.")
        return
    }
    let zoneOne = Zone(coordinates: "7;7 1", type: .circle, phoneNumber: "89090902490", name: "Sovetsky district", emergencyDeptCode: "454084", dangerLevel: .low)
    let zoneTwo = Zone(coordinates: "11;11 12;12 12;11", type: .triangle, phoneNumber: "88080802480", name: "Kalinisky district", emergencyDeptCode: "454012", dangerLevel: .middle)
    let zoneThree = Zone(coordinates: "0;0 0;-2 -2;0 -1;1", type: .quadrilateral, phoneNumber: "87070702470", name: "Kirovsky district", emergencyDeptCode: "454012", dangerLevel: .middle)
    let novosibirsk = City(nameCity: "Novosibirsk", emergencyPhoneNumber: defaultNumberPhone)
    novosibirsk.getCityInfo()
    novosibirsk.accidentInfo(accident: accident)
    novosibirsk.addZone(zoneOne)
    novosibirsk.addZone(zoneTwo)
    novosibirsk.addZone(zoneThree)
    if let resutl = novosibirsk.findZoneForAccident(accident) {
        resutl.zoneInfo()
    }
}

menu()
