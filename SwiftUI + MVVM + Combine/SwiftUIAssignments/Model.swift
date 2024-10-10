//
//  Model.swift
//  SwiftUIAssignments
//
//  Created by Sona on 09.10.24.
//

import Foundation

// MARK: - Empty
struct DataResponse: Codable {
    let results: [Result]
    let info: Info
}

// MARK: - Info
struct Info: Codable {
    let seed: String
    let results, page: Int
    let version: String
}

// MARK: - Result
struct Result: Codable, Hashable {
    
    let gender: Gender
    let name: Name
    let location: Location
    let email: String
    let dob, registered: Dob
    let phone, cell: String
    let id: ID
    let picture: Picture
    let nat: String
    
    
    static func == (lhs: Result, rhs: Result) -> Bool {
        lhs.email == rhs.email // Assuming email is unique
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id) // Hash email as the unique identifier
    }
}

// MARK: - Dob
struct Dob: Codable {
    let date: String
    let age: Int
}

enum Gender: String, Codable {
    case female = "female"
    case male = "male"
}

// MARK: - ID
struct ID: Codable, Hashable {
    let name: String
    let value: String?
}

// MARK: - Location
struct Location: Codable {
    let street: Street
    let city, state, country: String
    let coordinates: Coordinates
    
    var locationInfo: String {
        return "\(street.fullStreetName) \(city) \(state) \(country)"
    }
}

// MARK: - Coordinates
struct Coordinates: Codable {
    let latitude, longitude: String
}



// MARK: - Street
struct Street: Codable {
    let number: Int
    let name: String
    
    var fullStreetName: String {
        return "\(name) \(number)"
    }
}

// MARK: - Name
struct Name: Codable {
    let title, first, last: String
    
    var fullName: String {
        return "\(title) \(first) \(last)"
    }
}

// MARK: - Picture
struct Picture: Codable {
    let large, medium, thumbnail: String
}
