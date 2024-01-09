//
//  ContentView.swift
//  Patinfy
//
//  Created by Robert Alejandro Ionita Maglan on 4/11/23.
//

import SwiftUI

// Estructura principal que representa la vista principal de la aplicación
struct ContentView: View {
    
    // Estado que almacena la información de los scooters
    @State var scooters: Scooters = Scooters(scooters: [])
    
    var body: some View {
        // Vista de navegación principal
        NavigationView {
            VStack {
                // Lista de scooters
            }
            .navigationTitle("Scooters") // Título de la barra de navegación
        }
        .onAppear {
            // Este bloque de código se ejecuta cuando la vista aparece en la pantalla
            
            // Intenta cargar datos desde un archivo JSON llamado "scooters.json"
            if let url = Bundle.main.url(forResource: "scooters", withExtension: "json") {
                do {
                    // Lee el contenido del archivo JSON en forma de Data
                    let jsonData = try Data(contentsOf: url)
                    print(jsonData)
                    
                    // Decodifica el JSON en una estructura Scooters usando JSONDecoder
                    let decoder = JSONDecoder()
                    print(try decoder.decode(Scooters.self, from: jsonData))
                    scooters = try decoder.decode(Scooters.self, from: jsonData)
                } catch {
                    // Captura cualquier error que pueda ocurrir durante la carga y decodificación de datos JSON
                    print(error)
                }
            }
        }
    }
}

// Estructura de vista previa para previsualizar la vista principal
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


