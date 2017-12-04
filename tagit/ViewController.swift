//
//  ViewController.swift
//  tagit
//
//  Created by Eamon White on 12/1/17.
//  Copyright © 2017 EamonWhite. All rights reserved.
//

import UIKit
import GoogleMaps

class ViewController: UIViewController, CLLocationManagerDelegate {
    let locationManager = CLLocationManager()
    var center = CLLocationCoordinate2D()
    let tagButton = TagButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.frame = view.bounds
        view.addSubview(mapView)

        self.tagButton.addTarget(self, action: #selector(openManualTag), for: .touchUpInside)
        self.tagButton.backgroundColor = UIColor(red: 200.0/255, green: 17.0/255, blue: 57.0/255, alpha: 0.5)
        self.tagButton.layer.shadowColor = UIColor.black.cgColor
        self.tagButton.layer.shadowPath = UIBezierPath(roundedRect: self.tagButton.bounds, cornerRadius: self.tagButton.frame.width/2).cgPath
        self.tagButton.layer.shadowOffset = CGSize.zero
        self.tagButton.layer.shadowOpacity = 0.3
        self.tagButton.layer.shadowRadius = 5
        self.tagButton.layer.masksToBounds = true
        self.tagButton.clipsToBounds = false
        self.tagButton.layer.borderWidth = 5
        self.tagButton.layer.borderColor = UIColor.white.cgColor
        view.addSubview(self.tagButton);
        
        let searchController = SearchController()
        let viewWidth = self.view.frame.width
        searchController.view.layer.shadowColor = UIColor.black.cgColor
        searchController.view.layer.shadowPath = UIBezierPath(rect: CGRect(x: 0, y: 0, width: viewWidth - 2/5 * viewWidth, height: 44)).cgPath
        searchController.view.layer.shadowOffset = CGSize.zero
        searchController.view.layer.shadowOpacity = 0.3
        searchController.view.layer.shadowRadius = 5
        searchController.view.layer.masksToBounds = true
        searchController.view.clipsToBounds = false
        searchController.view.frame = CGRect(x: viewWidth/5, y: self.view.frame.height/10, width: viewWidth - 2/5 * viewWidth, height:44.0)
        self.addChildViewController(searchController)
        self.view.addSubview(searchController.view)
        searchController.didMove(toParentViewController: self)
    }
    
    override func viewDidLayoutSubviews() {
        self.tagButton.frame = CGRect(x: self.view.frame.width/2 - 36, y: self.view.frame.height - 0.2 * self.view.frame.height, width: 72.0, height: 72.0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addMarker(tag: String) {
        self.locationManager.startUpdatingLocation();
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: self.center.latitude, longitude: self.center.longitude)
        marker.title = tag
        //marker.snippet = //USERNAME
        DispatchQueue.main.async {
            marker.map = self.view as? GMSMapView
        }
    }
    
    @objc private func openManualTag() {
        let frameHeightAdjusted = self.view.frame.height - 5/8 * self.view.frame.height
        let manualTag = ManualTagController()
        manualTag.view.layer.shadowColor = UIColor.black.cgColor
        manualTag.view.layer.shadowOpacity = 0.3
        manualTag.view.layer.shadowOffset = CGSize.zero
        manualTag.view.layer.shadowRadius = 5
        manualTag.view.layer.masksToBounds = true
        manualTag.view.clipsToBounds = false
        manualTag.view.layer.shadowPath = UIBezierPath(rect: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 159)).cgPath
        manualTag.view.tag = 1
        manualTag.view.frame = CGRect(x: 0, y: frameHeightAdjusted, width: self.view.frame.width, height: 159.0)
        manualTag.view.transform = CGAffineTransform(translationX: 0, y: -frameHeightAdjusted - 159)
        
        let transparencyButton = UIButton(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        transparencyButton.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha:0.4);
        transparencyButton.addTarget(self, action: #selector(dismissHelper(sender:)), for: .touchUpInside)
        
        DispatchQueue.main.async {
            self.addChildViewController(manualTag)
            self.view.addSubview(manualTag.view)
            manualTag.didMove(toParentViewController: self)
            
            UIView.animate(withDuration: 0.5, animations: {
                manualTag.view.transform = .identity
            })
            
            self.view.insertSubview(transparencyButton, belowSubview: manualTag.view)
        }
    }
    
    @objc func dismissHelper(sender: UIButton)
    {
        self.view.viewWithTag(1)?.removeFromSuperview()
        sender.isHidden = true;
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error" + error.localizedDescription)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation = locations.last
        self.center = CLLocationCoordinate2D(latitude: userLocation!.coordinate.latitude, longitude: userLocation!.coordinate.longitude)
        
        let mapView = view.subviews.first as! GMSMapView
        DispatchQueue.main.async {
            mapView.camera = GMSCameraPosition.camera(withLatitude: self.center.latitude, longitude: self.center.longitude, zoom: 14.0)
        }
        
        print("Latitude :- \(userLocation!.coordinate.latitude)")
        print("Longitude :-\(userLocation!.coordinate.longitude)")

        self.locationManager.stopUpdatingLocation()
    }
}

