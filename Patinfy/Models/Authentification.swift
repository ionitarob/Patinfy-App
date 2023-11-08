//
//  Authentification.swift
//  Patinfy
//
//  Created by Robert Alejandro Ionita Maglan on 4/11/23.
//

import SwiftUI

class Authentification: ObservableObject{
    @Published var isValidated: Bool = false
    
    enum AuthentificationError: Error, LocalizedError, Identifiable{
        case invalidCredentials
        
        var id: String{
            self.localizedDescription
        }
        
        var errorDescription: String?{
            switch self{
            case .invalidCredentials:
                return NSLocalizedString("Su usuario o contraseña son incorrectos", comment:"")
            }
        }
    }
    
    
    
    func updateValidation(success: Bool){
        withAnimation{
            isValidated = success
        }
    }
}
