//
//  LocationManager.swift
//  EndTerm3
import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    
    @Published var location: CLLocationCoordinate2D?
    @Published var locationError: String?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }
    
    func startUpdatingLocation() {
        locationManager.startUpdatingLocation()
    }
    
    func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let newLocation = locations.first else { return }
        location = newLocation.coordinate
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationError = "Failed to get location: \(error.localizedDescription)"
        location = CLLocationCoordinate2D(latitude: 12.9716, longitude: 77.5946) //( Bangalore )default coordinates
    }
}




