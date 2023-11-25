//
//  config.swift
//  task_01
//
//  Created by DonHalab on 22.11.2023.
//

import Foundation

let defaultNumberPhone = "88008473824"

struct ZoneInput {
    let coordinates: String
    let shape: ZoneShape
    let phoneNumber: String
    let name: String
    let emergencyDept: String
    let dangerLevel: DangerLevel
}

struct AccidentInput {
    var coordinates: String
    var discription: String
    var phoneNumber: String?
    var type: AccidentType
}

enum AccidentType: String {
    case fire
    case gasLeak = "gas leak"
    case catOnTree = "cat on the tree"
    case unknown
}

enum ZoneShape: String {
    case circle, triangle, quadrilateral, unowned
}

enum DangerLevel: String {
    case low, middle, high, unowned
}
