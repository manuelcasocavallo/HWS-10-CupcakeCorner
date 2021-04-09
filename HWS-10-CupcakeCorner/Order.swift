//
//  Order.swift
//  HWS-10-CupcakeCorner
//
//  Created by Manuel Casocavallo on 08/04/21.
//

import Foundation

class Order: ObservableObject, Codable {
    
    @Published var type = 0
    @Published var quantity = 3
    @Published var extraFrosting = false
    @Published var addSprinkles = false
    @Published var name = ""
    @Published var streetAddress = ""
    @Published var city = ""
    @Published var zip = ""
    
    //Create coding keys to conform to Codable
    enum CodingKeys: CodingKey {
        case type, quantity, extraFrosting, addSprinkles, name, streetAddress, city, zip
    }
    //Creating a container to encode using the coding keys
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(type, forKey: .type)
        try container.encode(quantity, forKey: .quantity)
        try container.encode(extraFrosting, forKey: .extraFrosting)
        try container.encode(addSprinkles, forKey: .addSprinkles)
        try container.encode(name, forKey: .name)
        try container.encode(streetAddress, forKey: .streetAddress)
        try container.encode(city, forKey: .city)
        try container.encode(zip, forKey: .zip)
    }
    //Implement a required initializer to decode an instance of Order
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        type = try container.decode(Int.self, forKey: .type)
        quantity = try container.decode(Int.self, forKey: .quantity)
        extraFrosting = try container.decode(Bool.self, forKey: .extraFrosting)
        addSprinkles = try container.decode(Bool.self, forKey: .addSprinkles)
        name = try container.decode(String.self, forKey: .name)
        streetAddress = try container.decode(String.self, forKey: .streetAddress)
        city = try container.decode(String.self, forKey: .city)
        zip = try container.decode(String.self, forKey: .zip)
    }
    //Adding an alternative init
    init() { }
    
    
    
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
   
    @Published var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }

    var hasValidAddress : Bool {
        if name.isEmpty || streetAddress.isEmpty || city.isEmpty || zip.isEmpty {
            return false
        }
        return true
    }
    
    var cost: Double {
        //Basic - $2 per cake
        var cost = Double(quantity) * 2

        //More complicated ones
        switch type {
        case 1:
            cost += Double(quantity) * 0.5
        case 2:
            cost += Double(quantity) * 0.75
        case 3:
            cost += Double(quantity) * 1
        default:
            cost += 0
        }
        
        //$1 for extra frosting
        if extraFrosting {
            cost += Double(quantity)
        }
        
        //$0.50 for extra sprinkles
        if addSprinkles {
            cost += Double(quantity) / 2
        }
        
        return cost
    }
    
}
