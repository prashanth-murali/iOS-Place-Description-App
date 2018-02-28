/*
 * Created by Prashanth Murali on 2/27/17.
 * Copyright © 2017 Prashanth Murali. All rights reserved.
 * Right To Use for the instructor and the University to build and evaluate the software package
 * @author Prashanth Murali mail to: pmurali10@asu.edu
 * @version 1.0 February 27, 2017
 */


import Foundation
//this class is used to store the place data as place description objects
class PlaceLibrary{
    
    var placedictionary:[String:placeDescription] = [String:placeDescription]()
    
    var name3: String
    var latitude3: String
    var longitude3: String
    var elevation3: String
    var address_title3: String
    var address_street3: String
    var description3: String
    var category3: String
    
    
    init()
    {
        NSLog("inside PLACE LIBRARY INIT")
        self.name3 = ""
        self.latitude3 = ""
        self.longitude3 = ""
        self.elevation3 = ""
        self.address_title3 = ""
        self.address_street3 = ""
        self.description3 = ""
        self.category3 = ""
    }
    
    
    func update(name: String, latitude: String, longitude: String, elevation: String, address_title: String, address_street: String, description: String, category: String) {
        self.name3 = name
        self.latitude3 = latitude
        self.longitude3 = longitude
        self.elevation3 = elevation
        self.address_title3 = address_title
        self.address_street3 = address_street
        self.description3 = description
        self.category3 = category
        
        print("inside placelibrary")
        
        let PlaceNew:placeDescription = placeDescription(name: name3,latitude: latitude3, longitude: longitude3, elevation: elevation3, address_title: address_title3, address_street: address_street3, description: description3, category: category3)
        
        placedictionary[name3] = PlaceNew
        
        
    }
    
    func display()
    {
        var item:placeDescription=placeDescription(name: "",latitude: "", longitude: "", elevation: "", address_title: "", address_street: "", description: "", category: "")
        for item in placedictionary
        {
            print("INSIDE PLACE LIBRARY DISPLAY")
            print(item)
            
        }
        
    }
    
    
}
