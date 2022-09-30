//
//  MapViewController.swift
//  H2O
//
//  Created by Scott Simon & Matthew Mola on 5/1/18.
//  Copyright © 2018 neiu.edu. All rights reserved.
//
//  Map View Controller is a map tool that shows local libraries around your location
//  ---------------------
//  Future version(s) will include:
//  - More detailed information about the libraries, like a table that displays the address, phone number
//  - Tappable annotations
/***************************************************************************************************/

import UIKit
import MapKit

//initializing the controller to store the location and search results
class MapViewController : UIViewController, MKMapViewDelegate {
    var matchingItems: [MKMapItem] = [MKMapItem]()
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
}


extension MapViewController : CLLocationManagerDelegate {
    //Checks if the user accepted the location permission
    private func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }
    
    //Initializes the map based on the location and sets a zoom
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let span = MKCoordinateSpanMake(0.05, 0.05)
            let region = MKCoordinateRegion(center: location.coordinate, span: span)
            mapView.setRegion(region, animated: true)
            self.performSearch()
        }
    }
    
    //Issues an error if something goes wrong
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: (error)")
    }
    
    //Performs a search for libraries
    func performSearch() {
        
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = "library"
        request.region = mapView.region
        
        
        let search = MKLocalSearch(request: request)
        
        search.start(completionHandler: {(response, error) in
            
            for item in response!.mapItems
            {
                self.matchingItems.append(item as MKMapItem)
                
                let annotation = MKPointAnnotation()
                annotation.coordinate = item.placemark.coordinate
                annotation.title = item.name
                annotation.subtitle = "Library"
                self.mapView.addAnnotation(annotation)
            }
        })
    }
    
     //Changes the search to pins with custom annotations
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "pin")
        guard (annotation.title) != nil else {return nil}
        annotationView.canShowCallout = true
        return annotationView
    }
}
