//
//  ContentView.swift
//  HWS-10-CupcakeCorner
//
//  Created by Manuel Casocavallo on 08/04/21.
//

import SwiftUI

class User: ObservableObject, Codable {
    
    //@Published doesn't conform to Encodable and Decodable
    //The string by itself is Codable, but with the property wrapper it becomes Published<String>, a publishable object that contains a String.
    @Published var name = "Paul Hudson"
    
    //First we need an enum that conforms to the protocol CodingKey
    enum CodingKeys: CodingKey {
        //Every case is the name of a property we want to load and save
        case name
    }

    //We could use "final class" so that subclassing isn't allowed at all and we avoid mistakes. But if we want to allow subclassing, we should use "required init" instead, so that we make sure that anyone who subclasses from Users has to override the init with their own values.
    //Inside the init, we ask the Decoder for a container that matches all the coding keys: this means "This data should have a container where the keys match wathever cases we have in the CodingKeys enum. Is a throwing call because it's possible those keys don't exist.
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
    }
    
    //Last step, writing to an Encoder instance, asking it to make a container using our CodingKeys and write our values attached to each key.
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
    }
    
    //Now Swift knows what data we want to write, how to convert some encoded data into our object's properties and vice versa.
    
}

struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
