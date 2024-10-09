//
//  ViewModel.swift
//  SwiftUIAssignments
//
//  Created by Sona on 09.10.24.
//

import Combine
import UIKit

//ERRORI DEPQUM ALERT

protocol UserRepoProtocol {
  func fetchUsers() -> AnyPublisher<[DataResponse], Error>
}


class UsersRepositoryClass: UserRepoProtocol{
    
    
    private let baseURL = "https://randomuser.me/api/"
    
    func fetchUsers(page: Int, results: Int) -> AnyPublisher<[DataResponse], any Error> {
        
        let urlString = "\(baseURL)?page=\(page)&results=\(results)"
        guard let url = URL(string: urlString) else { return }
        
        return URLSession.shared.dataTaskPublisher(for: url!)
          .map({ $0.data })
          .decode(type: [DataResponse].self, decoder: JSONDecoder())
          .receive(on: DispatchQueue.main)
          .replaceError(with: [])
          .eraseToAnyPublisher()
        
    }
    
    
}


