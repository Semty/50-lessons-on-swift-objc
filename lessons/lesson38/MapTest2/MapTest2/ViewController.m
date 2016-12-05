//
//  ViewController.m
//  MapTest1
//
//  Created by Руслан on 04.12.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
#import "RTMapAnnotation.h"
#import "UIView+MKAnnotationView.h"

@interface ViewController () <MKMapViewDelegate, CLLocationManagerDelegate>

@property (strong, nonatomic) CLGeocoder *geoCoder;
@property (strong, nonatomic) MKDirections *direction;
@property (strong, nonatomic) CLLocationManager *locationManager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.geoCoder = [[CLGeocoder alloc] init];
    [self authorizationOfTheLocation];
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                               target:self
                                                                               action:@selector(actionAdd:)];
    
    UIBarButtonItem *zoomButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch
                                                                               target:self
                                                                               action:@selector(actionShowAll:)];
    /*
    UIBarButtonItem *fixed = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                                target:nil
                                                                                action:nil];
    fixed.width = 50;
    */
    
    /*
    UIBarButtonItem *flexible = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                           target:nil
                                                                           action:nil];
    */
    
    //self.navigationItem.rightBarButtonItems = @[ flexible, zoomButton, flexible, addButton, flexible ];
    
    self.navigationItem.rightBarButtonItems = @[ zoomButton, addButton ];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) dealloc {
    
    if ([self.geoCoder isGeocoding]) {
        [self.geoCoder cancelGeocode];
    }
    
    if ([self.direction isCalculating]) {
        [self.direction cancel];
    }
}

#pragma mark - Helpful functions

- (void) showAlertWithTitle:(NSString *)title message:(NSString *)message
                      style:(UIAlertControllerStyle)style andSourceView:(UIView *)sourceView {
    
    if (style == UIAlertControllerStyleActionSheet) {
        
        UIAlertController *alertController = [UIAlertController
                                              alertControllerWithTitle:title
                                              message:message
                                              preferredStyle:style];
        alertController.popoverPresentationController.sourceView = self.view;
        alertController.popoverPresentationController.sourceRect = sourceView.frame;
        
        UIAlertAction *actionOK = [UIAlertAction actionWithTitle:@"OK"
                                                           style:UIAlertActionStyleDefault
                                                         handler:nil];
        [alertController addAction:actionOK];
        [self presentViewController:alertController animated:YES completion:nil];
        
    } else {
        
        UIAlertController *alertController = [UIAlertController
                                              alertControllerWithTitle:title
                                              message:message
                                              preferredStyle:style];
        
        UIAlertAction *actionOK = [UIAlertAction actionWithTitle:@"OK"
                                                           style:UIAlertActionStyleDefault
                                                         handler:nil];
        [alertController addAction:actionOK];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    
}

#pragma mark - Authorization of the location

- (void) authorizationOfTheLocation {
    
    self.locationManager = [[CLLocationManager alloc] init];
    
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    [self.locationManager startUpdatingLocation];
}

#pragma mark - Adress from CLPlacemark

- (NSString *) adressStringFromCLPlacemark:(CLPlacemark *)placemark {
    
    NSString *message = [NSString stringWithFormat:@"%@%@%@%@%@%@%@",
               
               [placemark name] ? [placemark name] : @"",
               
               [placemark name] && ([placemark locality] || [placemark administrativeArea]
                                    || [placemark country]) ? @",\n" : @"",
               
               [placemark locality] && ![[placemark locality] isEqualToString:[placemark name]]
               ? [placemark locality] : @"",
               
               [placemark locality] && ([placemark administrativeArea] || [placemark country]) &&
                         ![[placemark locality] isEqualToString:[placemark name]] ? @",\n" : @"",
               
               [placemark administrativeArea] && ![[placemark administrativeArea]
                                                   isEqualToString:[placemark locality]]
               && ![[placemark administrativeArea] isEqualToString:[placemark name]]
               ? [placemark administrativeArea] : @"",
               
               [placemark administrativeArea] && [placemark country]
               && ![[placemark administrativeArea]
                    isEqualToString:[placemark locality]]
               && ![[placemark administrativeArea] isEqualToString:[placemark name]] ? @",\n" : @"",
               
               [placemark country] ? [placemark country] : @""];
    
    return message;
}

#pragma mark - Actions

- (void) actionAdd:(UIBarButtonItem *)sender {
    
    RTMapAnnotation *annotation = [[RTMapAnnotation alloc] init];
    
    annotation.title = @"Test Title";
    annotation.subtitle = @"Test Subtitle";
    annotation.coordinate = self.mapView.region.center;
    
    [self.mapView addAnnotation:annotation];
}

- (void) actionShowAll:(UIBarButtonItem *)sender {
    
    MKMapRect zoomRect = MKMapRectNull;
    
    for (id <MKAnnotation> annotation in self.mapView.annotations) {
        
        CLLocationCoordinate2D location = annotation.coordinate;
        
        MKMapPoint center = MKMapPointForCoordinate(location);
        
        static double delta = 100000;
        
        MKMapRect rect = MKMapRectMake(center.x - delta, center.y - delta, delta * 2, delta * 2);
        
        zoomRect = MKMapRectUnion(zoomRect, rect);
    }
    
    zoomRect = [self.mapView mapRectThatFits:zoomRect];
    
    [self.mapView setVisibleMapRect:zoomRect
                        edgePadding:UIEdgeInsetsMake(50, 50, 50, 50)
                           animated:YES];
}

- (void) actionDescription:(UIButton *)sender {
    
    MKAnnotationView *annotationView = [sender superAnnotationView];
    
    if (annotationView) {
        
        CLLocationCoordinate2D coordinate = annotationView.annotation.coordinate;
        CLLocation *location = [[CLLocation alloc] initWithLatitude:coordinate.latitude
                                                          longitude:coordinate.longitude];
        
        if ([self.geoCoder isGeocoding]) {
            [self.geoCoder cancelGeocode];
        }
        __block NSString *message = nil;
        
        [self.geoCoder reverseGeocodeLocation:location
                       completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
                    
                           if (error) {
                               message = error.localizedDescription;
                           } else {
                               
                               if (placemarks && [placemarks count] > 0) {
                                   
                                   CLPlacemark *placemark = placemarks.firstObject;
                                   
                                   message = [self adressStringFromCLPlacemark:placemark];
                                   
                               } else {
                                   message = @"No placemarks found";
                               }
                           }
                           
                           [self showAlertWithTitle:@"Location" message:message
                                              style:UIAlertControllerStyleActionSheet andSourceView:annotationView];
                           
                       }];
    }
}

- (void) actionDirection:(UIButton *)sender {
    
    MKAnnotationView *annotationView = [sender superAnnotationView];
    
    if (annotationView) {
        
        CLLocationCoordinate2D coordinate = annotationView.annotation.coordinate;
        
        MKDirectionsRequest *request = [[MKDirectionsRequest alloc] init];
        request.requestsAlternateRoutes = YES;
        request.source = [MKMapItem mapItemForCurrentLocation];
        
        MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:coordinate];
        request.destination = [[MKMapItem alloc] initWithPlacemark:placemark];
        
        request.transportType = MKDirectionsTransportTypeAutomobile;
        
        if ([self.direction isCalculating]) {
            [self.direction cancel];
        }
        
        self.direction = [[MKDirections alloc] initWithRequest:request];
        [self.direction calculateDirectionsWithCompletionHandler:
         ^(MKDirectionsResponse * _Nullable response, NSError * _Nullable error) {
            
             if (error) {
                 [self showAlertWithTitle:@"Error" message:error.localizedDescription
                                    style:UIAlertControllerStyleAlert andSourceView:nil];
             } else if ([response.routes count] == 0) {
                 
                 [self showAlertWithTitle:@"Error" message:@"Response routes is 0"
                                    style:UIAlertControllerStyleAlert andSourceView:nil];
             } else {
                 
                 [self.mapView removeOverlays:self.mapView.overlays];
                 
                 NSMutableArray *polylines = [[NSMutableArray alloc] init];
                 
                 for (MKRoute *route in response.routes) {
                     [polylines addObject:route.polyline];
                 }
                 
                 [self.mapView addOverlays:polylines level:MKOverlayLevelAboveRoads];
             }
             
         }];
    }
    
}

#pragma mark - MKMapViewDelegate

/*
- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated {
    NSLog(@"regionWillChangeAnimated");
}

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    NSLog(@"regionDidChangeAnimated");
}

- (void)mapViewWillStartLoadingMap:(MKMapView *)mapView {
    NSLog(@"mapViewWillStartLoadingMap");
}

- (void)mapViewDidFinishLoadingMap:(MKMapView *)mapView {
    NSLog(@"mapViewDidFinishLoadingMap");
}

- (void)mapViewDidFailLoadingMap:(MKMapView *)mapView withError:(NSError *)error {
    NSLog(@"mapViewDidFailLoadingMap");
}

- (void)mapViewWillStartRenderingMap:(MKMapView *)mapView {
    NSLog(@"regionDimapViewWillStartRenderingMapdChangeAnimated");
}

- (void)mapViewDidFinishRenderingMap:(MKMapView *)mapView fullyRendered:(BOOL)fullyRendered {
    NSLog(@"mapViewDidFinishRenderingMap fullyRendered = %d", fullyRendered);
}
*/

- (nullable MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    
    static NSString *identifier = @"annotation";
    
    MKPinAnnotationView *pin = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    
    if (!pin) {
        pin = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        pin.pinTintColor = [UIColor purpleColor];
        pin.animatesDrop = YES;
        pin.canShowCallout = YES;
        pin.draggable = YES;
        
        UIButton *descriptionButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        [descriptionButton addTarget:self action:@selector(actionDescription:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *directionButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
        [directionButton addTarget:self action:@selector(actionDirection:) forControlEvents:UIControlEventTouchUpInside];
        
        pin.rightCalloutAccessoryView = descriptionButton;
        pin.leftCalloutAccessoryView = directionButton;
        
    } else {
        pin.annotation = annotation;
    }
    
    return pin;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view
                                 didChangeDragState:(MKAnnotationViewDragState)newState
                                       fromOldState:(MKAnnotationViewDragState)oldState{
    
    if (newState == MKAnnotationViewDragStateEnding) {
        
        CLLocationCoordinate2D location = view.annotation.coordinate;
        
        MKMapPoint center = MKMapPointForCoordinate(location);
        
        NSLog(@"\n\nlocation = { %f, %f }\npoint = %@\n\n", location.latitude, location.longitude, MKStringFromMapPoint(center));
    }
    
}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id <MKOverlay>)overlay {
    
    if ([overlay isKindOfClass:[MKPolyline class]]) {
        
        MKPolylineRenderer *renderer = [[MKPolylineRenderer alloc] initWithOverlay:overlay];
        renderer.lineWidth = 2.f;
        renderer.strokeColor = [UIColor orangeColor];
        
        return renderer;
    }
    
    return nil;
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    
    NSLog(@"status of geolocation is %d", status);
}

@end
