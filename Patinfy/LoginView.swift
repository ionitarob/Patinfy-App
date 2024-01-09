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

    // Variable de estado para rastrear si las condiciones han sido aceptadas
    @State private var conditionsAccepted = false

    // Variable de estado para controlar la navegación a la vista de condiciones
    @State private var showConditions = false

    var body: some View {
        VStack {
            Text("Patinfly").font(.largeTitle)
                .foregroundColor(Color("PrimaryColor"))

            TextField("User", text: $loginModelView.credentials.email)
                .keyboardType(.emailAddress)
                .padding(.horizontal, 60)
                .padding(.vertical, 20)

            SecureField("Password", text: $loginModelView.credentials.password)
                .padding(.horizontal, 60)
                .padding(.vertical, 20)

            HStack {
                Text("Conditions")
                Spacer()
                Toggle("", isOn: $conditionsAccepted)
                    .labelsHidden()
            }
            .padding(20)

            if loginModelView.showProgressView {
                ProgressView()
            }

            // Botón de inicio de sesión deshabilitado si las condiciones no se han aceptado
            Button("Sign in") {
                guard conditionsAccepted else {
                    // Muestra un mensaje o realiza alguna acción si las condiciones no se han aceptado
                    return
                }

                loginModelView.login { success in
                    authentication.updateValidation(success: success)
                }
            }
            .disabled(loginModelView.loginDisable || !conditionsAccepted) // Deshabilita si las condiciones no se han aceptado
            .padding(20)

            // Texto "Clickable" para consultar las condiciones
            Text("Consult Conditions")
                .foregroundColor(.blue)
                .onTapGesture {
                    showConditions = true
                }
                .sheet(isPresented: $showConditions) {
                    // Vista de condiciones, aquí deberías presentar la vista que muestra las condiciones
                    ConditionsView()
                }
        }
        .padding(.horizontal, 60)
        .padding(.vertical, 20)
        .autocapitalization(.none)
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .disabled(loginModelView.showProgressView)
        .alert(item: $loginModelView.error) { error in
            Alert(title: Text("Error Validacion"), message:
                    Text(error.localizedDescription))
        }
    }
}

struct ConditionsView: View {
    var body: some View {
        // Aquí deberías implementar la vista que muestra las condiciones
        Text("Condiciones de uso")
            .padding()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}


