//
//  Scooter.swift
//  Patinfy
//
//  Created by Robert Alejandro Ionita Maglan on 8/11/23.
//
import Foundation
import CoreLocation

struct Scooters: Hashable, Codable {
    var scooters: [Scooter]
}

struct Scooter: Hashable, Codable, Equatable, Identifiable {
    var id: String
    var uuid: String
    var name: String
    var latitude: Double
    var longitude: Double
    var battery_level: Float
    var km_use: Float
    var date_last_maintenance: String
    var state: String
    var on_rent: Bool
}

// Función para calcular la distancia entre dos ubicaciones en metros
func calculateDistance(userLatitude: Double?, userLongitude: Double?,
                       scooterLatitude: Double, scooterLongitude: Double) -> Double {
    guard let userLat = userLatitude, let userLon = userLongitude else {
        return 0.0  // Si no se proporciona la ubicación del usuario, la distancia es 0
    }

    let userLocation = CLLocation(latitude: userLat, longitude: userLon)
    let scooterLocation = CLLocation(latitude: scooterLatitude, longitude: scooterLongitude)

    // Devuelve la distancia en kilómetros
    return userLocation.distance(from: scooterLocation) / 1000.0
}


