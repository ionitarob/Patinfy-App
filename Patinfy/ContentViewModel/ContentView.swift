import SwiftUI
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private var locationManager = CLLocationManager()

    @Published var userLocation: CLLocation?

    override init() {
        super.init()
        setupLocationManager()
    }

    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        case .denied, .restricted:
            print("La aplicación no tiene permisos de ubicación.")
        default:
            break
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        userLocation = locations.last
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location Manager Error: \(error)")
    }
}

struct ContentView: View {
    @StateObject private var locationManager = LocationManager()
    @State private var scooters: Scooters = Scooters(scooters: [])
    @State private var selectedScooter: Scooter?

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(scooters.scooters.indices, id: \.self) { index in
                        ScooterRowView(
                            name: scooters.scooters[index].name,
                            uuid: scooters.scooters[index].uuid,
                            distance: String(format: "%.2f km", calculateDistance(userLocation: locationManager.userLocation,
                                                                                 scooterLatitude: scooters.scooters[index].longitude,
                                                                                 scooterLongitude: scooters.scooters[index].latitude)),
                            batteryLevel: Double(scooters.scooters[index].battery_level),
                            status: scooters.scooters[index].state
                        )
                        .onTapGesture {
                            selectedScooter = scooters.scooters[index]
                        }
                    }
                }
            }
            .navigationTitle("Scooters")
            .sheet(item: $selectedScooter) { scooter in
                ScooterDetailView(scooter: scooter, userLocation: locationManager.userLocation)
            }
        }
        .onAppear {
            loadScootersData()
        }
    }

    private func loadScootersData() {
        if let url = Bundle.main.url(forResource: "scooters", withExtension: "json") {
            do {
                let jsonData = try Data(contentsOf: url)
                let jsonString = String(data: jsonData, encoding: .utf8)
                print("JSON Data: \(jsonString ?? "")")

                let decoder = JSONDecoder()
                scooters = try decoder.decode(Scooters.self, from: jsonData)
            } catch {
                print(error)
            }
        }
    }

    private func calculateDistance(userLocation: CLLocation?, scooterLatitude: Double, scooterLongitude: Double) -> Double {
        guard let userLocation = userLocation else {
            return 0.0
        }

        let distanceInMeters = userLocation.distance(from: CLLocation(latitude: scooterLatitude, longitude: scooterLongitude))
        let distanceInKilometers = distanceInMeters / 1000

        return distanceInKilometers
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


















