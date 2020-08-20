//
//  Order.swift
//  CupcakeCorner
//
//  Created by Paul Richardson on 18.08.2020.
//  Copyright © 2020 Paul Richardson. All rights reserved.
//

import SwiftUI

class Order: ObservableObject, Codable {
	
	enum CodingKeys: CodingKey {
		case type, quantity, extraFrosting, addSprinkles, name, streetAddress, city, zip
	}
	
	static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
	
	@Published var type = 0
	@Published var quantity = 3
	
	@Published	var specialRequestEnabled = false {
		didSet {
			if specialRequestEnabled == false {
				extraFrosting = false
				addSprinkles = false
			}
		}
	}
	@Published var extraFrosting  = false
	@Published var addSprinkles = false
	
	@Published var name = ""
	@Published var streetAddress = ""
	@Published var city = ""
	@Published var zip = ""
	
	var hasValidAddress: Bool {
		if name.isEmpty || streetAddress.isEmpty || city.isEmpty || zip.isEmpty {
			return false
		} else if name.isBlank || streetAddress.isBlank || city.isBlank || zip.isBlank {
			return false
		}
		return true
	}
	
	var cost: Double {
		// $2 per cake
		var cost = Double(quantity) * 2
		
		// complicated cakes cost more
		cost += (Double(type) / 2)
		
		// $1/cake for extra frosting
		if extraFrosting {
			cost += Double(quantity)
		}
		
		// $0.50/cake for sprinkles
		if addSprinkles {
			cost += Double(quantity) / 2
		}
		
		return cost
		
	}
	
	init() {}
	
	required init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		
		try type = container.decode(Int.self, forKey: .type)
		try quantity = container.decode(Int.self, forKey: .quantity)
		
		try extraFrosting = container.decode(Bool.self, forKey: .extraFrosting)
		try addSprinkles = container.decode(Bool.self, forKey: .addSprinkles)
		
		try name = container.decode(String.self, forKey: .name)
		try streetAddress = container.decode(String.self, forKey: .streetAddress)
		try city = container.decode(String.self, forKey: .streetAddress)
		try zip = container.decode(String.self, forKey: .zip)
	}

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
	
}
