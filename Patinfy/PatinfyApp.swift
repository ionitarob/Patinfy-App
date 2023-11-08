//
//  PatinfyApp.swift
//  Patinfy
//
//  Created by Robert Alejandro Ionita Maglan on 4/11/23.
//

import SwiftUI

@main
struct PatinfyApp: App {
    
    @StateObject var authentification = Authentification()
    
    var body: some Scene {
        WindowGroup {
            
            if authentification.isValidated{
                ContentView().environmentObject(authentification)
            }
            else{
                SplashScreen().environmentObject(authentification)
                //LoginView().environmentObject(authentification)
            }
        }
    }
}
