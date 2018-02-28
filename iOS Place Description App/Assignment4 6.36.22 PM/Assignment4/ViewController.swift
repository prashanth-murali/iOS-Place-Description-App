/*
 * Created by Prashanth Murali on 2/27/17.
 * Copyright © 2017 Prashanth Murali. All rights reserved.
 * Right To Use for the instructor and the University to build and evaluate the software package
 * @author Prashanth Murali mail to: pmurali10@asu.edu
 * @version 1.0 February 27, 2017
 */

import UIKit

class ViewController: UIViewController,UINavigationControllerDelegate,UITextFieldDelegate,UIPickerViewDelegate {
    
    @IBOutlet weak var name1: UITextField!
    @IBOutlet weak var description1: UITextField!
    @IBOutlet weak var category1: UITextField!
    @IBOutlet weak var address_title1: UITextField!
    @IBOutlet weak var address_street1: UITextField!
    @IBOutlet weak var latitude: UITextField!
    @IBOutlet weak var longitude: UITextField!
    @IBOutlet weak var elevation: UITextField!
    @IBOutlet weak var placePicker: UIPickerView!
    @IBOutlet weak var placeTF: UITextField!
    
    
    var places:[String:placeDescription] = [String:placeDescription]()
    var names1:[String] = [String]()
    var selectedPlace:String = ""
    var pickedPlace:String = ""
    var takes:[String] = [String]()
    
    //loads the view when switching to this controller
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let editButton1 = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.edit, target: self, action: #selector(ViewController.editPlace))
        self.navigationItem.rightBarButtonItem = editButton1
        
        name1.text = "\(places[selectedPlace]!.name)"
        description1.text = "\(places[selectedPlace]!.description)"
        category1.text = "\(places[selectedPlace]!.category)"
        address_title1.text = "\(places[selectedPlace]!.address_title)"
        address_street1.text = "\(places[selectedPlace]!.address_street)"
        elevation.text = "\(places[selectedPlace]!.elevation)"
        latitude.text = "\(places[selectedPlace]!.latitude)"
        longitude.text = "\(places[selectedPlace]!.longitude)"
        
        self.names1 = Array(self.places.keys).sorted()
        self.title = places[selectedPlace]?.name
        
        takes = self.names1
        
        
        placeTF.text=self.names1[0]
        placePicker.delegate = self
        placePicker.removeFromSuperview()
        placeTF.inputView = placePicker
        
        
        pickedPlace =  (self.names1.count > 0) ? self.names1[0] : "unknown unknown"
        let pls:[String] = pickedPlace.components(separatedBy: " ")
        
        self.navigationController?.delegate = self
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.placeTF.resignFirstResponder()
    }
    
    
    //when clicked, displays the details of the places selected in the picker
    
    @IBAction func displayButton(_ sender: UIButton) {
        
        name1.text = "\(places[pickedPlace]!.name)"
        description1.text = "\(places[pickedPlace]!.description)"
        category1.text = "\(places[pickedPlace]!.category)"
        address_title1.text = "\(places[pickedPlace]!.address_title)"
        address_street1.text = "\(places[pickedPlace]!.address_street)"
        elevation.text = "\(places[pickedPlace]!.elevation)"
        latitude.text = "\(places[pickedPlace]!.latitude)"
        longitude.text = "\(places[pickedPlace]!.longitude)"
        self.title = places[pickedPlace]?.name
        selectedPlace=pickedPlace
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.placeTF.resignFirstResponder()
        return true
    }
    
    //used to obtain the data from a selected row
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickedPlace = self.names1[row]
        let tokens:[String] = pickedPlace.components(separatedBy: " ")
        self.placeTF.text = tokens[0]
        self.placeTF.resignFirstResponder()
    }
    
    
    func pickerView (_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let pls:String = self.names1[row]
        let tokens:[String] = pls.components(separatedBy: " ")
        return tokens[0]
    }
    
    
    func numberOfComponentsInPickerView(_ pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.names1.count
    }
    
    
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool){
        print("entered navigationController willShow viewController")
        if let controller = viewController as? PlaceTableViewController {
            controller.places = self.places
            controller.tableView.reloadData()
        }
    }
    
    //used to edit details of an existing place
    func editPlace() {
        print("edit button clicked")
        
        
        let promptND = UIAlertController(title: "\(places[selectedPlace]!.name)", message: "Edit Place Details", preferredStyle: UIAlertControllerStyle.alert)
        
        promptND.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: nil))
        
        promptND.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) -> Void in
            
            let newPlaceName="\(self.places[self.selectedPlace]!.name)"
            
            let newPlaceDesctiption:String = (promptND.textFields?[0].text == "") ?
                "Enter Description" : (promptND.textFields?[0].text)!
            self.places[self.selectedPlace]!.description=newPlaceDesctiption
            
            let newPlaceCategory:String = (promptND.textFields?[1].text == "") ?
                "Enter Category" : (promptND.textFields?[1].text)!
            self.places[self.selectedPlace]!.category=newPlaceCategory
            
            let newPlaceAddress_Title:String = (promptND.textFields?[2].text == "") ?
                "Enter Address-Title" : (promptND.textFields?[2].text)!
            self.places[self.selectedPlace]!.address_title=newPlaceAddress_Title
            
            let newPlaceAddress_Street:String = (promptND.textFields?[3].text == "") ?
                "Enter Address-Street" : (promptND.textFields?[3].text)!
            self.places[self.selectedPlace]!.address_street=newPlaceAddress_Street
            
            
            let newPlaceElevation:String = (promptND.textFields?[4].text == "") ?
                "Enter Elevation" : (promptND.textFields?[4].text)!
            self.places[self.selectedPlace]!.elevation=newPlaceElevation
            
            
            let newPlaceLatitude:String = (promptND.textFields?[5].text == "") ?
                "Enter Latitude" : (promptND.textFields?[5].text)!
            self.places[self.selectedPlace]!.latitude=newPlaceLatitude
            
            let newPlaceLongitude:String = (promptND.textFields?[6].text == "") ?
                "Enter Longitude" : (promptND.textFields?[6].text)!
            self.places[self.selectedPlace]!.longitude=newPlaceLongitude
            
            
            let aPlace:placeDescription = placeDescription(name: newPlaceName,latitude: newPlaceLatitude, longitude: newPlaceLongitude, elevation: newPlaceElevation, address_title: newPlaceAddress_Title, address_street: newPlaceAddress_Street, description: newPlaceDesctiption, category: newPlaceCategory)
            
            let lib:PlaceLibrary=PlaceLibrary()
            lib.update(name: newPlaceName,latitude: newPlaceLatitude, longitude: newPlaceLongitude, elevation: newPlaceElevation, address_title: newPlaceAddress_Title, address_street: newPlaceAddress_Street, description: newPlaceDesctiption, category: newPlaceCategory)
            
            
            self.places[newPlaceName] = aPlace
            self.names1 = Array(self.places.keys).sorted()
            
            self.viewDidLoad()
        }))
        
        if description1.text != "Enter Description"
        {
            
            promptND.addTextField(configurationHandler: {(textField: UITextField!) in
                textField.text = "\(self.places[self.selectedPlace]!.description)"
            })
            
        }
            
        else
            
        {
            promptND.addTextField(configurationHandler: {(textField: UITextField!) in
                textField.placeholder = "Enter Description"
            })
            
        }
        
        if category1.text != "Enter Category"
        {
            
            promptND.addTextField(configurationHandler: {(textField: UITextField!) in
                textField.text = "\(self.places[self.selectedPlace]!.category)"
            })
        }
            
        else
            
        {
            promptND.addTextField(configurationHandler: {(textField: UITextField!) in
                textField.placeholder = "Enter Category"
            })
            
        }
        
        if address_title1.text != "Enter Address-Title"
        {
            
            promptND.addTextField(configurationHandler: {(textField: UITextField!) in
                textField.text = "\(self.places[self.selectedPlace]!.address_title)"
            })
        }
            
        else
        {
            
            promptND.addTextField(configurationHandler: {(textField: UITextField!) in
                textField.placeholder = "Enter Address-Title"
            })
            
        }
        
        
        if address_street1.text != "Enter Address-Street"
        {
            promptND.addTextField(configurationHandler: {(textField: UITextField!) in
                textField.text = "\(self.places[self.selectedPlace]!.address_street)"
            })
        }
            
        else
        {
            
            promptND.addTextField(configurationHandler: {(textField: UITextField!) in
                textField.placeholder = "Enter Address-Street"
            })
        }
        
        
        if elevation.text != "Enter Elevation"
        {
            promptND.addTextField(configurationHandler: {(textField: UITextField!) in
                textField.text = "\(self.places[self.selectedPlace]!.elevation)"
            })
        }
            
        else
        {
            promptND.addTextField(configurationHandler: {(textField: UITextField!) in
                textField.placeholder = "Enter Elevation"
            })
        }
        
        if latitude.text != "Enter Latitude"
        {
            promptND.addTextField(configurationHandler: {(textField: UITextField!) in
                textField.text = "\(self.places[self.selectedPlace]!.latitude)"
            })
        }
            
        else
        {
            promptND.addTextField(configurationHandler: {(textField: UITextField!) in
                textField.placeholder = "Enter Latitude"
            })
            
        }
        
        if longitude.text != "Enter Longitude"
        {
            promptND.addTextField(configurationHandler: {(textField: UITextField!) in
                textField.text = "\(self.places[self.selectedPlace]!.longitude)"
            })
        }
            
        else
        {
            promptND.addTextField(configurationHandler: {(textField: UITextField!) in
                textField.placeholder = "Enter Longitude"
            })
            
        }
        
        
        present(promptND, animated: true, completion: nil)
    }
    
    
    
}

