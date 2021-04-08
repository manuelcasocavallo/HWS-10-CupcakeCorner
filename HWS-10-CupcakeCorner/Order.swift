//
//  Order.swift
//  HWS-10-CupcakeCorner
//
//  Created by Manuel Casocavallo on 08/04/21.
//

import Foundation

class Order: ObservableObject {
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    @Published var type = 0
    @Published var quantity = 3
    
    @Published var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    @Published var extraFrosting = false
    @Published var addSprinkles = false
    
    @Published var name = ""
    @Published var streetAddress = ""
    @Published var city = ""
    @Published var zip = ""

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
