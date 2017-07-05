//
//  MapViewController.swift
//  App 5 - CollegeProfileBuilder
//
//  Created by John Wehrenberg on 7/5/17.
//  Copyright © 2017 Molly Wehrenberg. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    var searchLocation = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        findLocation(location: searchLocation)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        dismiss(animated: true, completion: nil)
        findLocation(location: searchBar.text!)
    }

    func findLocation(location : String) {
        let localSearchRequest = MKLocalSearchRequest()
        localSearchRequest.naturalLanguageQuery = location
        let localSearch = MKLocalSearch(request: localSearchRequest)
        localSearch.start { (localSearchResponse, error) in
            if localSearchResponse == nil {
                let alertController = UIAlertController(title: nil, message: "Location Not Found", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
                self.present(alertController, animated: true, completion: nil)
                return
            }
            let locations = localSearchResponse!.mapItems
            if locations.count > 1 {                                //more than one location found
                let alert = UIAlertController(title: "Select A Location", message: nil, preferredStyle: .actionSheet)
                for location in locations {
                    let name = "\(location.placemark.name!), \(location.placemark.administrativeArea!)"
                    let locationAction = UIAlertAction(title: name, style: .default, handler: { (action) in
                        self.displayMap(placemark: location.placemark)
                    })
                    alert.addAction(locationAction)
                }
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                alert.addAction(cancelAction)
                self.present(alert, animated: true, completion: nil)
            }
            else {                                                  //only one location found
                self.displayMap(placemark: locations.first!.placemark)
            }
        }
    }

    func displayMap(placemark : MKPlacemark) {
        navigationItem.title = placemark.name
        let center = placemark.location!.coordinate
        let span = MKCoordinateSpan(latitudeDelta: 0.04, longitudeDelta: 0.04)
        let region = MKCoordinateRegion(center: center, span: span)
        let pin = MKPointAnnotation()
        pin.coordinate = center
        pin.title = placemark.name
        mapView.addAnnotation(pin)
        mapView.setRegion(region, animated: true)
    }
    
    @IBAction func onSearchButtonTapped(_ sender: Any) {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.delegate = self
        present(searchController, animated: true, completion: nil)
    }
}
