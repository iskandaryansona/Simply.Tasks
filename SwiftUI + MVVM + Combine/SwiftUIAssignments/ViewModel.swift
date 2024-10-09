//
//  ViewModel.swift
//  SwiftUIAssignments
//
//  Created by Sona on 09.10.24.
//

import Combine
import UIKit

//ERRORI DEPQUM ALERT

class UserViewModel: ObservableObject {
    
    @Published var users: [Result] = []
    
    @Published var currentPage = 1
    private var cancellables = Set<AnyCancellable>()
    
    private let baseURL = "https://randomuser.me/api/"
    
    init() {
        fetchUsers()
    }
    
    func fetchUsers() {
        guard let url = URL(string: "\(baseURL)?page=\(currentPage)&results=10") else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: DataResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error fetching users: \(error.localizedDescription)")
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] response in
                guard let self = self else { return }
                self.users.append(contentsOf: response.results)
            })
            .store(in: &cancellables)
    }
    
    func loadMoreUsers() {
        currentPage += 1
        fetchUsers()
    }
}
