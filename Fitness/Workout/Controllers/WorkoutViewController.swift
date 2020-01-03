//
//  WorkoutViewController.swift
//  Fitness
//
//  Created by Amine BEN ZAGGAGH on 11/13/19.
//  Copyright © 2019 Amine BEN ZAGGAGH. All rights reserved.
//

import UIKit
import MapKit

class WorkoutNavigationController: UINavigationController {
    
}


class WorkoutNavigationBar: UINavigationBar {
    
    
    
}

class WorkoutViewController: UIViewController, CLLocationManagerDelegate {
    
    fileprivate let locationManager: CLLocationManager = CLLocationManager()
    
    @IBOutlet weak var workoutWeatherView: UIImageView!
    
    @IBOutlet weak var workoutToolbar: UIToolbar!
    @IBOutlet weak var workoutSegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var workoutRunMap: MKMapView!
    
    @IBOutlet weak var startWorkoutButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupMapUI()
        setupWeatherUI()
        setupLocationManager()
        
        walk()
        
    }
    
    private func setupUI() {
        workoutToolbar.clipsToBounds = true
        startWorkoutButton.layer.cornerRadius = 8
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupMapUI() {
        workoutRunMap.isZoomEnabled = false
        workoutRunMap.isPitchEnabled = false
        workoutRunMap.isRotateEnabled = false
        workoutRunMap.isScrollEnabled = false
        workoutRunMap.showsUserLocation = true
        workoutRunMap.layer.cornerRadius = 8
    }
    
    private func setupWeatherUI() {
        // TODO: Get user's location and update the weather regarding the location
        // TODO: Add Shadow to ImageView
//        workoutWeatherView.layer.shadowColor = UIColor.black.cgColor
//        workoutWeatherView.layer.shadowOffset = CGSize(width: 0, height: 20)
//        workoutWeatherView.layer.shadowOpacity = 1
//        workoutWeatherView.applyshadowWithCorner(containerView: workoutWeatherView, cornerRadious: 0.5)
        
        
    }
    
    private func setupLocationManager() {
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        
        DispatchQueue.main.async {
            self.locationManager.startUpdatingLocation()
        }
        
        
        if (CLLocationManager.locationServicesEnabled()) {
            locationManager.requestAlwaysAuthorization()
            locationManager.requestWhenInUseAuthorization()
        }

        if let userLocation = locationManager.location?.coordinate {
            let viewRegion = MKCoordinateRegion(center: userLocation, latitudinalMeters: 600, longitudinalMeters: 600)
            workoutRunMap.setRegion(viewRegion, animated: false)
        }
    }
    
    @IBAction func changeWorkoutSegmentedControl(_ sender: UISegmentedControl) {
        switch workoutSegmentedControl.selectedSegmentIndex {
            case 0:
                walk()
            case 1:
                run()
            default:
                walk()
        }
    }
    
    private func walk() {
        workoutRunMap.isHidden = false
    }
    
    private func run() {
        workoutRunMap.isHidden = false
    }
    
    @IBAction func startRunWorkout(_ sender: UIButton) {
        print("Start Workout")
    }
    
}

