//
//  ViewController.m
//  HW37-38
//
//  Created by Руслан on 08.12.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
#import "RTStudent.h"

@interface ViewController () <MKMapViewDelegate, CLLocationManagerDelegate>

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) NSMutableArray *students;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self authorizationOfTheLocation];
    
    self.students = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 30; i++) {
        RTStudent *student = [[RTStudent alloc] init];
        [self.students addObject:student];
        
        [self.mapView addAnnotation:student];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Location Authorization

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

#pragma mark - MKMapViewDelegate

- (nullable MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    
    if ([annotation isKindOfClass:[MKUserLocation class]] ) {
        return nil;
    }
    
    RTStudent *student = (RTStudent *)annotation;
    
    static NSString *identifier = @"annotation";
    
    MKAnnotationView *tempAnnotation = (MKAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    
    if (!tempAnnotation) {
        
        tempAnnotation = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        
        if (student.gender == RTMan) {
            tempAnnotation.image = [UIImage imageNamed:@"man.png"];
        } else {
            tempAnnotation.image = [UIImage imageNamed:@"woman.png"];
        }
        
        tempAnnotation.draggable = YES;
        tempAnnotation.canShowCallout = YES;
    } else {
        tempAnnotation.annotation = annotation;
    }
    return tempAnnotation;
}


#pragma mark - Actions

- (IBAction)actionShowAll:(UIBarButtonItem *)sender {
    
    MKMapRect zoomRect = MKMapRectNull;
    
    for (id <MKAnnotation> annotation in self.mapView.annotations) {
        
        CLLocationCoordinate2D location = annotation.coordinate;
        
        MKMapPoint center = MKMapPointForCoordinate(location);
        
        static double delta = 10.f;
        
        MKMapRect rect = MKMapRectMake(center.x - delta, center.y - delta, delta * 2, delta * 2);
        
        zoomRect = MKMapRectUnion(zoomRect, rect);
    }
    
    zoomRect = [self.mapView mapRectThatFits:zoomRect];
    
    [self.mapView setVisibleMapRect:zoomRect
                        edgePadding:UIEdgeInsetsMake(70, 70, 70, 70)
                           animated:YES];
}

@end


















