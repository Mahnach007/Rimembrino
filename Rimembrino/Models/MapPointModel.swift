import Foundation
import SwiftData
import MapKit

@Model
class MapPointModel {
    var name: String
    var latitude: Double
    var longitude: Double

    var position: CLLocationCoordinate2D {
        get {
            CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        }
        set {
            latitude = newValue.latitude
            longitude = newValue.longitude
        }
    }

    init(name: String = "", position: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 50.4343, longitude: 40.4343)) {
        self.name = name
        self.latitude = position.latitude
        self.longitude = position.longitude
    }
}
