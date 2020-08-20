//
//  Order.swift
//  CupcakeCorner
//
//  Created by Paul Richardson on 18.08.2020.
//  Copyright © 2020 Paul Richardson. All rights reserved.
//

import SwiftUI

struct OrderData: Codable {
	
	static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
	
	var type = 0
	var quantity = 3
	
	var specialRequestEnabled = false {
		didSet {
			if specialRequestEnabled == false {
				extraFrosting = false
				addSprinkles = false
			}
		}
	}
	var extraFrosting  = false
	var addSprinkles = false
	var name = ""
	var streetAddress = ""
	var city = ""
	var zip = ""
	
}

class Order: ObservableObject, Codable {
	
	enum CodingKeys: CodingKey {
		case data
	}
	
	@Published var data: OrderData
	
	var hasValidAddress: Bool {
		if data.name.isEmpty || data.streetAddress.isEmpty || data.city.isEmpty || data.zip.isEmpty {
			return false
		} else if data.name.isBlank || data.streetAddress.isBlank || data.city.isBlank || data.zip.isBlank {
			return false
		}
		return true
	}
	
	var cost: Double {
		// $2 per cake
		var cost = Double(data.quantity) * 2
		
		// complicated cakes cost more
		cost += (Double(data.type) / 2)
		
		// $1/cake for extra frosting
		if data.extraFrosting {
			cost += Double(data.quantity)
		}
		
		// $0.50/cake for sprinkles
		if data.addSprinkles {
			cost += Double(data.quantity) / 2
		}
		
		return cost
		
	}
	
	init() {
		self.data = OrderData()
	}
	
	required init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		try data = container.decode(OrderData.self, forKey: .data)
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(data, forKey: .data)
	}
	
}
