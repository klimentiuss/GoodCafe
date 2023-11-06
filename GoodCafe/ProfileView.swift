//
//  SwiftUIView.swift
//  GoodCafe
//
//  Created by Daniil Klimenko on 06.11.2023.
//

import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject var authManager: AuthentificationManager

    var body: some View {
        if let user = authManager.currentuser {
            List {
                Section {
                    HStack {
                        Text(user.initials)
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(width: 72, height: 72)
                            .background(Color(.systemGray3))
                        .clipShape(Circle())
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(user.fullname)
                                .fontWeight(.semibold)
                                .padding(.top, 4)
                            Text(user.email)
                                .font(.footnote)
                                .foregroundColor(Color(.gray))
                        }
                    }
                    
                }
                
                Section("General") {
                    HStack {
                        RowView(imageName: "gear", title: "Version", tintColor: Color(.systemGray))
                        
                        Spacer()
                        
                        Text("1.0.0")
                            .font(.subheadline)
                            .foregroundColor(Color(.gray))
                    }
                    
                }
                
                Section("Account") {
                    Button {
                        authManager.signOut()
                    } label: {
                        RowView(imageName: "arrow.left.circle.fill", title: "Sign out", tintColor: .red)
                    }

                    Button {
                        
                    } label: {
                        RowView(imageName: "xmark.circle.fill", title: "Delete account", tintColor: .red)
                    }
                }
            }
        }
        
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
