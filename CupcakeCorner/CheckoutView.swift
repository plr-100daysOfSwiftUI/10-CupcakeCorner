//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Paul Richardson on 18.08.2020.
//  Copyright © 2020 Paul Richardson. All rights reserved.
//

import SwiftUI

struct CheckoutView: View {
	
	@ObservedObject var order: Order
	@State private var alertTitle = ""
	@State private var alertMessage = ""
	@State private var showingAlert = false
	
	var body: some View {
		GeometryReader { geo in
			ScrollView {
				VStack {
					Image("cupcakes")
						.resizable()
						.scaledToFit()
						.frame(width: geo.size.width)
					
					Text("Your total is €\(self.order.cost, specifier: "%.2f")")
						.font(.title)
					
					Button("Place order", action: placeOrder)
				.padding()
				}
			}
			
		}
		.navigationBarTitle("Check out", displayMode: .inline)
		.alert(isPresented: $showingAlert) {
			Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
		}
	}
	
	func placeOrder() {
		guard let encoded = try? JSONEncoder().encode(order) else {
			print("Failed to encode order")
			return
		}
		
		let url = URL(string: "https://reqres.in/api/cupcakes")!
		var request = URLRequest(url: url)
		request.setValue("application/json", forHTTPHeaderField: "Content-Type")
		request.httpMethod = "POST"
		request.httpBody = encoded
		
		URLSession.shared.dataTask(with: request) { data, response, error in
			guard let data = data else {
				print("No data in response: \(error?.localizedDescription ?? "Unknown error")")
				self.alertTitle = "An error occurred!"
				self.alertMessage = "\(error?.localizedDescription ?? "Unknown error")"
				self.showingAlert = true
				return
			}
			
			if let decodedOrder = try? JSONDecoder().decode(Order.self, from: data) {
				self.alertTitle = "Thank you!"
				self.alertMessage = "Your order for \(decodedOrder.data.quantity) x \(OrderData.types[decodedOrder.data.type].lowercased()) cupcakes is on its way!"
				self.showingAlert = true
			} else {
				print("Invalid response from server")
			}
			
			
		}
		.resume()
	}
}

struct CheckoutView_Previews: PreviewProvider {
	static var previews: some View {
		CheckoutView(order: Order())
	}
}
