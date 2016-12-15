//
//  ViewController.swift
//  HW37-38
//
//  Created by Руслан on 15.12.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, AmountOfStudents
{
    
// MARK: - IBOutlet's variables
    
    @IBOutlet weak var mapView: MKMapView!
    
// MARK: - Private variables
    
    private var direction:              MKDirections!
    private var geoCoder:               CLGeocoder!
    private var locationManager:        CLLocationManager!
    
    internal var students               = [Student]()
    private var meetings                = [MeetingPoint]()
    private var circles                 = [MKCircle]()
    private var polylines               = [MKPolyline]()
    
    internal var withoutCircleStudents  = [Student]()
    internal var firstCircleStudents    = [Student]()
    internal var secondCircleStudents   = [Student]()
    internal var thirdCircleStudents    = [Student]()
    
    private let identifierStudent = "student"
    private let identifierMeeting = "meeting"
    
// MARK: - Static variables
    
    static let firstCircleRadius: Double    = 2000
    static let secondCircleRadius: Double   = 5000
    static let thirdCircleRadius: Double    = 8500
    
// MARK: - Loading of the programm

    override func viewDidLoad() {
        super.viewDidLoad()
        self.geoCoder = CLGeocoder()
        self.authorizationOfTheLocation()
        self.mapView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        
        if self.geoCoder != nil && self.geoCoder.isGeocoding {
            self.geoCoder.cancelGeocode()
        }
        
        if self.direction != nil && self.direction.isCalculating {
            self.direction.cancel()
        }
    }
    
// MARK: - Helpful Functions
    
    func makeRoutes(`for` sender: UIButton) {
        
        let annotationView = sender.superAnnotationView()
        
        if annotationView != nil {
            
            let coordinate = annotationView?.annotation?.coordinate
            
            let request = MKDirectionsRequest.init()
            request.requestsAlternateRoutes = false
            
            let placemarkDestination = MKPlacemark(coordinate: coordinate!)
            request.destination = MKMapItem(placemark: placemarkDestination)
            
            self.removeAllRoutes()
            
            for student in self.students {
                
                if student.meetingState {
                    
                    let placemarkSource = MKPlacemark(coordinate: student.coordinate)
                    request.source = MKMapItem(placemark: placemarkSource)
                    
                    request.transportType = .automobile
                    
                    if self.direction != nil && self.direction.isCalculating {
                        self.direction.cancel()
                    }
                    
                    self.direction = MKDirections(request: request)
                    
                    self.direction.calculate(completionHandler: { (response, error) in
                        
                        if (error != nil) {
                            print("\(error?.localizedDescription)")
                        } else if (response?.routes.count == 0) {
                            print("Response routes is 0")
                        } else {
                            
                            for route in (response?.routes)! {
                                self.polylines.append(route.polyline)
                            }
                            self.mapView.addOverlays(self.polylines, level: .aboveRoads)
                        }
                        
                    })
                }
            }
        }
    }
    
    func meetingStateOfStudents() {
        
        let meeting = self.meetings.first
        
        let meetingLocation = CLLocation(latitude: (meeting?.coordinate.latitude)!,
                                         longitude: (meeting?.coordinate.longitude)!)
        
        for student in self.students {
            
            student.meetingState = false
            
            let studentLocation = CLLocation(latitude: student.coordinate.latitude,
                                             longitude: student.coordinate.longitude)
            
            let dist = meetingLocation.distance(from: studentLocation)
            let random = arc4random() % 1000;
            
            student.meetingDistance = String.init(format: "%1.1f", dist / 1000.0)
            
            if dist < ViewController.firstCircleRadius {
                self.firstCircleStudents.append(student)
                if random < 800 {
                    student.meetingState = true
                }
                continue
            }
            
            if dist < ViewController.secondCircleRadius {
                self.secondCircleStudents.append(student)
                if random < 500 {
                    student.meetingState = true
                }
                continue
            }
            
            if dist < ViewController.thirdCircleRadius {
                self.thirdCircleStudents.append(student)
                if random < 300 {
                    student.meetingState = true
                }
                continue
            }
            
            self.withoutCircleStudents.append(student)
        }
    }
    
    func addCircleRadiusesWithCenterPoint(`in` center: CLLocationCoordinate2D) {
        
        self.removeAllCirclesWithStudents()
        self.removeAllCircles()
        
        let firstCircle  =  MKCircle(center: center, radius: ViewController.firstCircleRadius)
        let secondCircle =  MKCircle(center: center, radius: ViewController.secondCircleRadius)
        let thirdCircle  =  MKCircle(center: center, radius: ViewController.thirdCircleRadius)
        
        self.circles.append(contentsOf: [ firstCircle, secondCircle, thirdCircle ])
        self.mapView.addOverlays([ firstCircle, secondCircle, thirdCircle ], level: .aboveRoads)
    }
    
    func popoverOrActionSheetWithMeetingInfo(sender: UIButton) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MeetingController") as! MeetingViewController
        vc.delegate = self
        
        vc.modalPresentationStyle = .popover
        
        if UI_USER_INTERFACE_IDIOM() == .pad {
            vc.view.backgroundColor = UIColor.clear
        }
        
        self.present(vc, animated: true, completion: nil)
        
        let popover = vc.popoverPresentationController
        popover?.permittedArrowDirections = .any
        
        let popoverRect = sender.convert(sender.frame, to: self.view)
        
        popover?.sourceView = self.view
        popover?.sourceRect = popoverRect
    }
    
    func popoverOrActionSheetDescription(sender: UIButton) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "DescriptionController") as! DescriptionViewController
        
        self.synchronizeDescriptionInformation(with: sender, and: vc)
        
        vc.modalPresentationStyle = .popover
        
        if UI_USER_INTERFACE_IDIOM() == .pad {
            vc.view.backgroundColor = UIColor.clear
        }
        
        self.present(vc, animated: true, completion: nil)
        
        let popover = vc.popoverPresentationController
        popover?.permittedArrowDirections = .any
        
        let popoverRect = sender.convert(sender.frame, to: self.view)
        
        popover?.sourceView = self.view
        popover?.sourceRect = popoverRect
        
    }
    
    func synchronizeDescriptionInformation(with sender: UIButton, and vc: DescriptionViewController) {
        
        vc.tableView.reloadData()
        
        let annotationView = sender.superAnnotationView()
        
        if annotationView != nil {
            
            let coordinate = annotationView?.annotation?.coordinate
            
            let location = CLLocation(latitude: (coordinate?.latitude)!, longitude: (coordinate?.longitude)!)
            
            let student = annotationView?.annotation as! Student
            
            vc.firstNameLabel.text  = student.name
            vc.lastNameLabel.text   = student.surname
            
            if student.gender == .man {
                vc.genderLabel.text = "Male"
            } else {
                vc.genderLabel.text = "Female"
            }
            
            vc.birthdayLabel.text = student.birthday
            
            if self.geoCoder != nil && self.geoCoder.isGeocoding {
                self.geoCoder.cancelGeocode()
            }
            
            var message = ""
            
            self.geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) in
                
                if error != nil {
                   message = (error?.localizedDescription)!
                } else {
                    
                    if placemarks != nil && (placemarks?.count)! > 0 {
                        
                        let placemark = placemarks?.first
                        
                        message = self.adressString(fromCLPlacemark: placemark!)
                    } else {
                        message = "No placemarks found"
                    }
                }
               vc.adressLabel.text = message
            })
        }
        vc.tableView.reloadData()
    }
    
    func randomColor() -> UIColor {
        
        var randomColor: UIColor!
        
        switch arc4random() % 8 {
        case 0:
            randomColor = .orange
        case 1:
            randomColor = .green
        case 2:
            randomColor = .red
        case 3:
            randomColor = .blue
        case 4:
            randomColor = .purple
        case 5:
            randomColor = .lightGray
        case 6:
            randomColor = .magenta
        case 7:
            randomColor = .black
        default:
            break
        }
        
        return randomColor
    }
    
// MARK: - Remove Functions
    
    func removeAllCirclesWithStudents() {
        self.firstCircleStudents.removeAll()
        self.secondCircleStudents.removeAll()
        self.thirdCircleStudents.removeAll()
        self.withoutCircleStudents.removeAll()
    }
    
    func removeAllRoutes() {
        if self.polylines.count != 0 {
            self.mapView.removeOverlays(self.polylines)
            self.polylines.removeAll()
        }
    }
    
    func removeAllCircles() {
        if self.circles.count != 0 {
            self.mapView.removeOverlays(self.circles)
            self.circles.removeAll()
        }
    }
    
// MARK: - Adress from CLPlacemark
    
    func adressString(fromCLPlacemark placemark: CLPlacemark) -> String {
        
        var message = placemark.name                != nil ? placemark.name!                + "\n" : ""
        
        message    += placemark.locality            != nil &&
                      placemark.locality            != placemark.name ? placemark.locality! + "\n" : ""
        
        message    += placemark.administrativeArea  != nil &&
                     (placemark.administrativeArea != placemark.name && placemark.administrativeArea != placemark.locality) ?
                                                             placemark.administrativeArea!  + "\n" : ""
        
        message    += placemark.country             != nil ? placemark.country!             + "\n" : ""
        
        return message
    }
    
// MARK: - Location Authorization
    
    func authorizationOfTheLocation() {
        
        self.locationManager = CLLocationManager.init()
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.distanceFilter = kCLDistanceFilterNone
        
        if self.locationManager.responds(to: #selector(CLLocationManager.requestWhenInUseAuthorization)) {
            self.locationManager.requestWhenInUseAuthorization()
        }
        self.locationManager.startUpdatingLocation()
    }
    
// MARK: - MKMapViewDelegate
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation is MKUserLocation {
            return nil
        }
        
        if annotation is Student {
            
            var tempAnnotation = mapView.dequeueReusableAnnotationView(withIdentifier: identifierStudent)
            
            let student = annotation as! Student
            
            if tempAnnotation == nil {
                
                tempAnnotation = MKAnnotationView(annotation: annotation, reuseIdentifier: identifierStudent)
                
                if student.gender == .man {
                    tempAnnotation?.image = UIImage.init(named: "man.png")
                } else {
                    tempAnnotation?.image = UIImage.init(named: "woman.png")
                }
                
                tempAnnotation?.canShowCallout = true
                
                let descriptionButton = UIButton(type: .detailDisclosure)
                descriptionButton.addTarget(self, action: #selector(actionDescription), for: .touchUpInside)
                
                tempAnnotation?.rightCalloutAccessoryView = descriptionButton
            } else {
                tempAnnotation?.annotation = annotation
            }
            return tempAnnotation
        }
        
        if annotation is MeetingPoint {
            
            var tempAnnotation = mapView.dequeueReusableAnnotationView(withIdentifier: identifierMeeting)
            
            if tempAnnotation == nil {
                
                tempAnnotation = MKAnnotationView(annotation: annotation, reuseIdentifier: identifierMeeting)
                
                tempAnnotation?.canShowCallout = true
                tempAnnotation?.isDraggable = true
                tempAnnotation?.image = UIImage.init(named: "meeting.png")
                
                let meetingInformationButton = UIButton(type: .detailDisclosure)
                meetingInformationButton.addTarget(self, action: #selector(actionMeetingInfo), for: .touchUpInside)
                
                let routesToMeetingButton = UIButton(type: .contactAdd)
                routesToMeetingButton.addTarget(self, action: #selector(actionRoutesToMeeting), for: .touchUpInside)
                
                tempAnnotation?.rightCalloutAccessoryView   = meetingInformationButton
                tempAnnotation?.leftCalloutAccessoryView    = routesToMeetingButton
            } else {
                tempAnnotation?.annotation = annotation
            }
            return tempAnnotation
        }
        
        return nil
    }

    func mapView(_ mapView: MKMapView,  annotationView view: MKAnnotationView,
                                        didChange newState: MKAnnotationViewDragState,
                                        fromOldState oldState: MKAnnotationViewDragState) {
        
        if view.annotation is MeetingPoint {
            
            if newState == .starting {
                
                UIView.animate(withDuration: 0.3, animations: { 
                    
                    view.transform = CGAffineTransform(scaleX: 1.7, y: 1.7)
                    view.alpha = 0.75
                    view.dragState = .dragging
                })
                
            } else if newState == .canceling || newState == .ending {
                
                UIView.animate(withDuration: 0.3, animations: { 
                    
                    view.transform = CGAffineTransform.identity
                    view.alpha = 1
                    view.dragState = .none
                })
                
                self.addCircleRadiusesWithCenterPoint(in: (view.annotation?.coordinate)!)
                self.meetingStateOfStudents()
                self.removeAllRoutes()
            }
        }
    }

    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        
        if overlay is MKCircle {
            
            let circleRenderer = MKCircleRenderer(overlay: overlay)
            
            UIView.animate(withDuration: 0.3, animations: {
                circleRenderer.fillColor = UIColor.red.withAlphaComponent(0.1)
                circleRenderer.strokeColor = UIColor.black.withAlphaComponent(0.1)
                circleRenderer.lineWidth = 1.0
            })
            return circleRenderer
        }
       
        if overlay is MKPolyline {
            
            let polylineRenderer = MKPolylineRenderer(overlay: overlay)
            
            UIView.animate(withDuration: 0.3, animations: { 
                polylineRenderer.lineWidth = 4.0
                polylineRenderer.strokeColor = self.randomColor()
            })
            return polylineRenderer
        }
        
        return MKOverlayRenderer(overlay: overlay)
    }

// MARK: - Actions
    
    func actionDescription(sender: UIButton) {
        self.popoverOrActionSheetDescription(sender: sender)
    }
    
    func actionMeetingInfo(sender: UIButton) {
        self.popoverOrActionSheetWithMeetingInfo(sender: sender)
    }
    
    func actionRoutesToMeeting(sender: UIButton) {
        self.makeRoutes(for: sender)
    }
    
    @IBAction func actionShowAll(_ sender: UIBarButtonItem) {
        
        var zoomRect = MKMapRectNull
        
        for annotation in self.mapView.annotations {
            
            let location = annotation.coordinate
            
            let center = MKMapPointForCoordinate(location)
            
            let delta = 10.0
            
            let rect = MKMapRectMake(center.x - delta,
                                     center.y - delta,
                                     delta * 2, delta * 2)
            
            zoomRect = MKMapRectUnion(zoomRect, rect)
        }
        
        zoomRect = self.mapView.mapRectThatFits(zoomRect)
        
        self.mapView.setVisibleMapRect(zoomRect,
                                       edgePadding: UIEdgeInsetsMake(70, 70, 70, 70),
                                       animated: true)
    }
    
    @IBAction func actionAddStudent(_ sender: UIBarButtonItem) {
        
        let student = Student()
        self.students.append(student)
        
        if self.meetings.count != 0 {
            self.removeAllCirclesWithStudents()
            self.meetingStateOfStudents()
        }
        
        self.mapView.addAnnotation(student)
    }

    @IBAction func actionAddMeeting(_ sender: UIBarButtonItem) {
        
        let meeting = MeetingPoint()
        self.meetings.append(meeting)
        
        if self.meetings.count > 1 {
            
            self.mapView.removeAnnotation(self.meetings[0])
            self.meetings.remove(at: 0)
            self.removeAllRoutes()
        }
        
        self.mapView.addAnnotation(meeting)
        self.addCircleRadiusesWithCenterPoint(in: meeting.coordinate)
        self.meetingStateOfStudents()
    }
    
    @IBAction func actionDeleteAll(_ sender: UIBarButtonItem) {
        
        self.mapView.removeAnnotations(self.students)
        self.mapView.removeAnnotations(self.meetings)
        self.mapView.removeOverlays(self.circles)
        
        self.students.removeAll()
        self.meetings.removeAll()
        self.removeAllRoutes()
        self.removeAllCirclesWithStudents()
    }
}
