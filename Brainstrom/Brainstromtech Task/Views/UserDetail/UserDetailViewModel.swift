//
//  UserDetailViewModel.swift
//  Brainstromtech Task
//
//  Created by Diana Sargsyan on 18.08.23.
//

import Foundation
import MapKit

class UserDetailViewModel: ObservableObject {
    
    private let zoom = 0.005
    private let defoultCentrCoordinate = CLLocationCoordinate2D(latitude: 51.5, longitude: -0.12)
    
    var user: any User
    
    @Published var userIsSaved: Bool = false
    @Published var mapRegion: MKCoordinateRegion
    @Published var location: UserLocation = UserLocation(coordinates: CLLocationCoordinate2D())
    
    init(user: any User) {
        self.user = user
        self.mapRegion = MKCoordinateRegion(center: defoultCentrCoordinate, span: MKCoordinateSpan(latitudeDelta: zoom, longitudeDelta: zoom))
        setupLocation()
        
        checkUser()
    }
    
    func setupLocation() {
        location = UserLocation(coordinates: CLLocationCoordinate2D(latitude: user.latitude, longitude: user.longitude))
        
        guard CLLocationCoordinate2DIsValid(location.coordinates) else {
             return
        }
        mapRegion = MKCoordinateRegion(center: location.coordinates, span: MKCoordinateSpan(latitudeDelta: zoom, longitudeDelta: zoom))
    }
    
    func buttonAction() {
        checkUser()
        
        if let id = user.identifier as? String {
            if userIsSaved {
                SQLliteDBContactsHandler.sharedInstance.removeUser(id: id)
            } else {
                SQLliteDBContactsHandler.sharedInstance.insertItemInDB(item: user as! Result, id: id)
                
            }
        }
        
        checkUser()
    }
    
    func checkUser() {
        if let id = user.identifier as? String ,
           let _ = SQLliteDBContactsHandler.sharedInstance.getItemListFromDB().firstIndex(where: {$0.id == id}) {
                userIsSaved = true
        } else {
            userIsSaved = false
        }
    }
}
