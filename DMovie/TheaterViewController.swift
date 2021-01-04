//
//  TheaterViewController.swift
//  DMovie
//
//  Created by 김건영 on 2021/01/02.
//

import UIKit
import MapKit
import NMapsMap

class TheaterViewController: UIViewController {
    
    let theaterManager = Theaters.shared
    var markers = [NMFMarker]()
    let mapView = NMFMapView()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.requestAlwaysAuthorization()
        self.mapView.frame = self.view.frame
        self.theaterManager.loadTheatersInfo() {
            DispatchQueue.global(qos: .default).async {
                for theater in self.theaterManager.theaters {
                    let marker = NMFMarker()
                    let cgvImage = NMFOverlayImage(name: "cgv.png")
                    let megaboxImage = NMFOverlayImage(name: "megabox.jpg")
                    let lotteImage = NMFOverlayImage(name: "lotte.png")
                    
                    guard theater.xpos != -1 || theater.ypos != -1 else {
                        continue
                    }
                    marker.position = NMGLatLng(lat: theater.ypos, lng: theater.xpos)
                    
                    if theater.name!.hasPrefix("CGV") {
                        marker.iconImage = cgvImage
                    } else if theater.name!.hasPrefix("메가박스") {
                        marker.iconImage = megaboxImage
                    } else if theater.name!.hasPrefix("롯데시네마") {
                        marker.iconImage = lotteImage
                    }
                    
                    self.markers.append(marker)
                }
                
                DispatchQueue.main.async {
                    for marker in self.markers {
                        marker.mapView = self.mapView
                    }
                }
            }
        }
        
        self.mapView.positionMode = .direction
        
        let locationOverlay = mapView.locationOverlay
        
        locationOverlay.hidden = false
        
        locationOverlay.touchHandler = { (overlay: NMFOverlay) ->Bool in
            print("오버레이 터치됨")
            return true
        }
       
        view.addSubview(self.mapView)
    }
}
