//
//  Parking.swift
//  parkingApp
//
//  Created by Graphic on 2023-06-24.
//

import Foundation

struct Parking: Identifiable, Codable {
    var id: String?
    var buildingCode: String
    var numberOfHours: Int
    var carLicensePlate: String
    var hostSuiteNumber: String
    var parkingLocation: String
    var dateAndTime: Date
    var userId: String

    enum CodingKeys: String, CodingKey {
        case id
        case buildingCode
        case numberOfHours
        case carLicensePlate
        case hostSuiteNumber
        case parkingLocation
        case dateAndTime
        case userId
    }
}
