//
//  Country.swift
//  GuessTheFlag
//
//  Created by Yasser Bal on 12/10/2023.
//

import Foundation
struct Country:Identifiable,Decodable,Equatable,Hashable{
        var id:String = UUID().uuidString
        let name:String
        let code:String
        let image:String
    
    // Coding keys to map JSON keys to struct properties
    private enum CodingKeys: String, CodingKey {
        case name
        case code
        case image
    }
    
    static func == (lhs: Country, rhs: Country) -> Bool {
        return lhs.name == rhs.name && lhs.code == rhs.code
    }
}
