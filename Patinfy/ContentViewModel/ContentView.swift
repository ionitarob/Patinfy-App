//
//  ContentView.swift
//  Patinfy
//
//  Created by Robert Alejandro Ionita Maglan on 4/11/23.
//

import SwiftUI

struct ContentView: View {
    @State var scooters: Scooters = Scooters(scooters: [])

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(scooters.scooters) { scooter in
                        ScooterRowView(
                            name: scooter.name,
                            uuid: scooter.uuid,
                            distance: "10",
                            batteryLevel: Double(scooter.battery_level),
                            status: scooter.state
                        )
                    }
                }
            }
            .navigationTitle("Scooters")
        }
        .onAppear {
            if let url = Bundle.main.url(forResource: "scooters", withExtension: "json") {
                do {
                    let jsonData = try Data(contentsOf: url)
                    let decoder = JSONDecoder()
                    scooters = try decoder.decode(Scooters.self, from: jsonData)
                } catch {
                    print(error)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



