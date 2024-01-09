//
//  Services.swift
//  Patinfy
//
//  Created by Robert Alejandro Ionita Maglan on 4/11/23.
//

import Foundation

class APIService{
    static let shared = APIService()
    
    enum APIError: Error{
        case error
    }
    
    func validUser(credentials: Credentials) -> Bool{
        return(credentials.email == "robert.alex20003@gmail.com") && (credentials.password == "Alejandro124")
    }
    
    func login (credentials: Credentials,
                completition: @escaping (Result<Bool, Authentification.AuthentificationError>) -> Void){
    
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
            if self.validUser(credentials: credentials){
                completition(.success(true))
            }
            else{
                completition(.failure(.invalidCredentials))
            }
        }
}
}
