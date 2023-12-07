//
//  ParkingRecord.swift
//  parkingApp
//
//  Created by Graphic on 2023-06-24.
//

import Foundation

struct ParkingRecord {
    let recordID: UUID
    let buildingCode: String
    let parkingHours: String
    let licensePlateNumber: String
    let hostSuitNumber: String
    let parkingLocation: String
    let dateAndTime: Date
}

class ParkingManager: ObservableObject {
    @Published var users: [User] = []
    @Published var parkingRecords: [ParkingRecord] = []
    
    func addParkingRecord(user: User, record: ParkingRecord) {
        parkingRecords.append(record)
        
        // Update the user's car plates if the license plate number is not already present
        if !user.carPlates.contains(record.licensePlateNumber) {
            user.carPlates.append(record.licensePlateNumber)
        }
    }
    
    // Add other methods for managing parking records and users as needed
}
