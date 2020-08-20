# CupcakeCorner

[Hacking with Swift: 100 Days of SwiftUI - Project 10][1]

### Challenges

1. The address fields are currently considered valid if they contain anything, even if it’s just only whitespace. Improve the validation to make sure a string of pure whitespace is invalid.
2. If the call to placeOrder() fails – for example if there is no internet connection – show an informative alert for the user.
3. Convert the data model from a class to a struct, then create an ObservableObject class wrapper around it that gets passed around. This will result in your class having one @Published property, which is the data struct inside it, and should make supporting Codable on the struct much easier.


[1]: https://www.hackingwithswift.com/100/swiftui/49
