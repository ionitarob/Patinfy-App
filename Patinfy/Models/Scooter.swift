//
//  Scooter.swift
//  Patinfy
//
//  Created by Robert Alejandro Ionita Maglan on 8/11/23.
//

import Foundation

struct Scooters: Hashable, Codable{
    var scooters: [Scooter]
}

struct Scooter: Hashable, Codable, Equatable, Identifiable{
    var id: String
    var uuid: String
    var name: String
    var longitude: Float
    var latitude: Float
    var battery_level: Float
    var km_use: Float
    var date_last_maintenance: String
    var state: String
    var on_rent: Bool
}

