//
//  zone.swift
//  task_01
//
//  Created by DonHalab on 23.11.2023.
//

import Foundation

class Zone {
    let coordinates: String
    let type: ZoneShape
    let phoneNumber: String
    let name: String
    let emergencyDeptCode: String
    let dangerLevel: DangerLevel

    init(coordinates: String, type: ZoneShape, phoneNumber: String, name: String, emergencyDeptCode: String, dangerLevel: DangerLevel) {
        self.coordinates = coordinates
        self.type = type
        self.phoneNumber = phoneNumber
        self.name = name
        self.emergencyDeptCode = emergencyDeptCode
        self.dangerLevel = dangerLevel
    }

    func beginArea(accident: AccidentInput) -> Bool {
        switch type {
        case .circle:
            return isAccidentInCircle(accident: accident)
        case .triangle:
            return isAccidentInTriangle(accident: accident)
        case .quadrilateral:
            return isAccidentInQuadrilateral(accident: accident)
        case .unowned:
            return false
        }
    }

    func zoneInfo() {
        print("""
        Zone info:
        ----------------------------------------------------
        The snape of Area: \(type)
        Phone Number: \(phoneNumber.applyPhoneNumberMask())
        Name: \(name)
        Emergency Dept: \(emergencyDeptCode)
        Danger level: \(dangerLevel)
        ----------------------------------------------------
        """)
    }

    private func isAccidentInCircle(accident: AccidentInput) -> Bool {
        // Разделяем строку на компоненты координат центра и радиуса
        let components = coordinates.split(separator: " ")
        guard components.count == 2,
              let centerPart = components.first?.split(separator: ";").compactMap({ Int($0) }),
              centerPart.count == 2,
              let radius = Int(components.last!)
        else {
            return false
        }
        let center = (x: centerPart[0], y: centerPart[1])
        // Разбиваем координаты инцидента на компоненты
        let accidentCoords = accident.coordinates.split(separator: ";").compactMap { Int($0) }
        guard accidentCoords.count == 2 else { return false }

        let point = (x: accidentCoords[0], y: accidentCoords[1])
        // Вычисляем, находится ли точка внутри круга
        return isPointInCircle(point: point, center: center, radius: radius)
    }

    private func isAccidentInTriangle(accident: AccidentInput) -> Bool {
        let vertexStrings = coordinates.split(separator: " ")
        guard vertexStrings.count == 3 else { return false }

        let v1 = vertexStrings[0].split(separator: ";").compactMap { Int($0) }
        let v2 = vertexStrings[1].split(separator: ";").compactMap { Int($0) }
        let v3 = vertexStrings[2].split(separator: ";").compactMap { Int($0) }

        guard v1.count == 2, v2.count == 2, v3.count == 2 else { return false }

        let vertices = [(x: v1[0], y: v1[1]), (x: v2[0], y: v2[1]), (x: v3[0], y: v3[1])]

        // Разбиваем координаты инцидента на компоненты
        let accidentCoords = accident.coordinates.split(separator: ";").compactMap { Int($0) }
        guard accidentCoords.count == 2 else { return false }

        let point = (x: accidentCoords[0], y: accidentCoords[1])

        // Проверяем, находится ли точка внутри треугольника
        return isPointInTriangle(point: point, v1: vertices[0], v2: vertices[1], v3: vertices[2])
    }

    private func isAccidentInQuadrilateral(accident: AccidentInput) -> Bool {
        let vertexStrings = coordinates.split(separator: " ")
        guard vertexStrings.count == 4 else { return false }

        let vertices = vertexStrings.compactMap { vertexString -> (x: Int, y: Int)? in
            let coords = vertexString.split(separator: ";").compactMap { Int($0) }
            guard coords.count == 2 else { return nil }
            return (x: coords[0], y: coords[1])
        }

        guard vertices.count == 4 else { return false }

        // Разбиваем координаты инцидента на компоненты
        let accidentCoords = accident.coordinates.split(separator: ";").compactMap { Int($0) }
        guard accidentCoords.count == 2 else { return false }

        let point = (x: accidentCoords[0], y: accidentCoords[1])

        // Проверяем, находится ли точка в одном из двух треугольников, на которые можно разделить четырехугольник
        return isPointInTriangle(point: point, v1: vertices[0], v2: vertices[1], v3: vertices[2]) ||
            isPointInTriangle(point: point, v1: vertices[0], v2: vertices[2], v3: vertices[3])
    }

    private func isPointInCircle(point: (x: Int, y: Int), center: (x: Int, y: Int), radius: Int) -> Bool {
        let distanceSquared = (point.x - center.x) * (point.x - center.x) + (point.y - center.y) * (point.y - center.y)
        return distanceSquared <= radius * radius
    }

    private func areaOfTriangle(_ p1: (x: Int, y: Int), _ p2: (x: Int, y: Int), _ p3: (x: Int, y: Int)) -> Int {
        return abs(p1.x * (p2.y - p3.y) + p2.x * (p3.y - p1.y) + p3.x * (p1.y - p2.y)) / 2
    }

    private func isPointInTriangle(point: (x: Int, y: Int), v1: (x: Int, y: Int), v2: (x: Int, y: Int), v3: (x: Int, y: Int)) -> Bool {
        let totalArea = areaOfTriangle(v1, v2, v3)
        let area1 = areaOfTriangle(point, v1, v2)
        let area2 = areaOfTriangle(point, v2, v3)
        let area3 = areaOfTriangle(point, v1, v3)

        return totalArea == area1 + area2 + area3
    }
}
