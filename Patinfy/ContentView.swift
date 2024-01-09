//
//  ContentView.swift
//  Patinfy
//
//  Created by Robert Alejandro Ionita Maglan on 4/11/23.
//

import SwiftUI

struct ContentView: View {
    @State var scooters:Scooters = Scooters(scooters: [])
    var body: some View {
        NavigationView{
            VStack{
                List{
                    
                }
                
            }.navigationTitle("Scooters")
        }.onAppear{
            if let url = Bundle.main.url(forResource: "scooters", withExtension: "json"){
                do{
                    let jsonData = try Data(contentsOf: url)
                    print(jsonData)
                    let decoder = JSONDecoder()
                    print(try decoder.decode(Scooters.self,from: jsonData))
                    scooters = try decoder.decode(Scooters.self, from: jsonData)
                } catch{
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

