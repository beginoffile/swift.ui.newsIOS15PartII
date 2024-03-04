//
//  MapaUIView.swift
//  NewsIOS15PartII
//
//  Created by Aguid Ramirez Sanchez on 03/03/24.
//

import SwiftUI
import CoreLocation
import CoreLocationUI
import MapKit

struct MapaUIView: View {
    
    @StateObject var locationManager = LocationManager()
    var body: some View {
        ZStack(alignment: .bottomTrailing){
//            if let location = locationManager.location{
//                Text("Coordenadas: \(location.latitude), \(location.longitude)")
//            }
            
            
            var cameraPosition: MapCameraPosition {
                MapCameraPosition.region(locationManager.region)
            }

          

            Map(position: .constant(cameraPosition), bounds: nil, interactionModes: .all,  scope: nil){
                UserAnnotation()
            }
            
            
            
            LocationButton{
                locationManager.requestLocation()
            }
            .labelStyle(.iconOnly)
            .symbolVariant(/*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
            .foregroundColor(.white)
            .tint(.green)
            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
            .padding()
        }
    }
}

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    
    let manager = CLLocationManager()
    
    @Published var location : CLLocationCoordinate2D?
    @Published var region: MKCoordinateRegion = .init()
    
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
        guard let location = locations.first?.coordinate else {return}
        region = MKCoordinateRegion(center: location, latitudinalMeters: 1000, longitudinalMeters: 1000)
    }
}
