//
//  LoginView.swift
//  Patinfy
//
//  Created by Robert Alejandro Ionita Maglan on 4/11/23.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject private var loginModelView = LoginViewModel()
    @EnvironmentObject var authentication: Authentification
    
    var body: some View {
        VStack {
            Text("Patinfly").font(.largeTitle)
                .foregroundColor(Color("PrimaryColor"))
            
            TextField("User",text: $loginModelView.credentials.email).keyboardType(.emailAddress).padding(.horizontal, 60).padding(.vertical, 20)
            
            SecureField("Password",text: $loginModelView.credentials.password).padding(.horizontal, 60).padding(.vertical, 20)
            if loginModelView.showProgressView{
                ProgressView()
            }
            
            Button("Sign in"){
                loginModelView.login{
                    success in
                    authentication.updateValidation(success: success)
                }
            }.disabled(loginModelView.loginDisable)
            .padding(20)
        }.padding(.horizontal, 60)
            .padding(.vertical, 20)
            .autocapitalization(.none)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .disabled(loginModelView.showProgressView)
            .alert(item: $loginModelView.error){
                error in Alert(title: Text("Error Validacion"), message:
                                Text(error.localizedDescription))
            }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
