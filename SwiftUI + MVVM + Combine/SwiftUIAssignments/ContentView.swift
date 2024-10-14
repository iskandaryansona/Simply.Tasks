//
//  ContentView.swift
//  SwiftUIAssignments
//
//  Created by Sona on 09.10.24.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = UserViewModel()

    var body: some View {
        NavigationView {
            List(viewModel.users, id: \.self) { user in
                       NavigationLink(destination: UserProfileView(user: user)) {
                           VStack(alignment: .leading) {
                               Text(user.name.fullName)
                                   .font(.headline)
                               Text(user.location.locationInfo)
                                   .font(.subheadline)
                                   .foregroundColor(.gray)
                           }
                       }
                   }
                   .navigationTitle("Users")
                   .onAppear {
                       viewModel.fetchUsers()
                   }
                   .onAppear {
                       if viewModel.currentPage == 1 {
                           viewModel.fetchUsers()
                       }
                   }
                   .onReceive(viewModel.$users) { users in
                       if !users.isEmpty {
                           DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                               if users.count % 10 == 0 {
                                   viewModel.loadMoreUsers()
                               }
                           }
                       }
                   }
               }
           }
}

#Preview {
    ContentView()
}
