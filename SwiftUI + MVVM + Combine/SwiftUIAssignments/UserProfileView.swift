//
//  Untitled.swift
//  SwiftUIAssignments
//
//  Created by Sona on 09.10.24.
//

import SwiftUI

struct UserProfileView: View {
    let user: Result
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(user.name.fullName)
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text(user.location.locationInfo)
                .font(.title2)
                .foregroundColor(.gray)
            
            Spacer()
        }
        .padding()
        .navigationTitle("Profile")
    }
}
