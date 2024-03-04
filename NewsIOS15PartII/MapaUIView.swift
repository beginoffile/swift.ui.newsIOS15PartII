//
//  MapaUIView.swift
//  NewsIOS15PartII
//
//  Created by Aguid Ramirez Sanchez on 03/03/24.
//

import SwiftUI
import CoreLocation
import CoreLocationUI

struct MapaUIView: View {
    
    @StateObject var locationManager = LocationManager()
    var body: some View {
        VStack{
            if let location = locationManager.location{
                Text("Coordenadas: \(location.latitude), \(location.longitude)")
            }
            LocationButton{
                locationManager.requestLocation()
            }
        }
    }
}

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    
    let manager = CLLocationManager()
    
    @Published var location : CLLocationCoordinate2D?
    
    override init(){
        super.init()
        manager.delegate = self
    }
    
    func requestLocation(){
        manager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.first?.coordinate
    }
}
