//
//  User.swift
//  parkingApp
//
//  Created by Graphic on 2023-06-24.
//

import Foundation

class User: Identifiable {
    let id: UUID
    let name: String
    var carPlates: [String]
    
    init(id: UUID = UUID(), name: String, carPlates: [String]) {
        self.id = id
        self.name = name
        self.carPlates = carPlates
    }
}
