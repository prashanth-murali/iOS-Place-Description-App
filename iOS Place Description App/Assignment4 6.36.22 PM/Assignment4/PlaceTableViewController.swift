/*
 * Created by Prashanth Murali on 2/27/17.
 * Copyright © 2017 Prashanth Murali. All rights reserved.
 * Right To Use for the instructor and the University to build and evaluate the software package
 * @author Prashanth Murali mail to: pmurali10@asu.edu
 * @version 1.0 February 27, 2017
 */


import UIKit
//this controller is used to manipulate the tableview contents
class PlaceTableViewController: UITableViewController,UIPickerViewDelegate {
    
    var places:[String:placeDescription] = [String:placeDescription]()
    var names:[String] = [String]()
    public var flag:Int = 0
    @IBOutlet weak var placePicker: UIPickerView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        NSLog("viewDidLoad")
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        let addButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: #selector(PlaceTableViewController.addPlace))
        self.navigationItem.rightBarButtonItem = addButton
        
        
        
        if let path = Bundle.main.path(forResource: "places", ofType: "json"){
            do {
                let jsonStr:String = try String(contentsOfFile:path)
                let data:Data = jsonStr.data(using: String.Encoding.utf8)!
                let dict:[String:Any] = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String:Any]
                print(dict)
                for aPlaceName:String in dict.keys {
                    let aPlace:placeDescription = placeDescription(dict: dict[aPlaceName] as! [String:Any])
                    self.places[aPlaceName] = aPlace
                }
            } catch {
                print("contents of places.json could not be loaded")
            }
        }
        
        self.names = Array(places.keys).sorted()
        
        self.title = "Place List"
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    //used to add a place to the list
    func addPlace() {
        print("add button clicked")
        
        
        let promptND = UIAlertController(title: "New Place", message: "Enter Place Name & Details", preferredStyle: UIAlertControllerStyle.alert)
        
        promptND.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: nil))
        
        promptND.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) -> Void in
            
            var newPlaceName:String = (promptND.textFields?[0].text == "") ?
                "None" : (promptND.textFields?[0].text)!
            let newPlaceDesctiption:String = (promptND.textFields?[1].text == "") ?
                "Enter Description" : (promptND.textFields?[1].text)!
            let newPlaceCategory:String = (promptND.textFields?[2].text == "") ?
                "Enter Category" : (promptND.textFields?[2].text)!
            let newPlaceAddress_Title:String = (promptND.textFields?[3].text == "") ?
                "Enter Address-Title" : (promptND.textFields?[3].text)!
            let newPlaceAddress_Street:String = (promptND.textFields?[4].text == "") ?
                "Enter Address-Street" : (promptND.textFields?[4].text)!
            
            let newPlaceElevation:String = (promptND.textFields?[5].text == "") ?
                "Enter Elevation" : (promptND.textFields?[5].text)!
            let newPlaceLatitude:String = (promptND.textFields?[6].text == "") ?
                "Enter Latitude" : (promptND.textFields?[6].text)!
            let newPlaceLongitude:String = (promptND.textFields?[7].text == "") ?
                "Enter Longitude" : (promptND.textFields?[7].text)!
            
            if newPlaceName == "None"
            {
                
                let alert = UIAlertController(title: "ERROR: Place Name Missing", message: "Enter a Place Name", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Done", style: .default, handler: { [weak alert] (_) in
                    self.tableView.reloadData()
                }))
                
                self.present(alert, animated: true, completion: nil)
                
                self.flag = 1
            }
            
            
            if(self.names.count>0)
            {
            for i in 0...self.names.count-1
            {
                if newPlaceName==self.names[i]
                {
                    
                    let alert = UIAlertController(title: "ERROR: Invalid Place Name", message: "Enter a New Place Name", preferredStyle: .alert)
                    
                    
                    alert.addAction(UIAlertAction(title: "Done", style: .default, handler: { [weak alert] (_) in
                        self.tableView.reloadData()
                    }))
                    
                    
                    self.present(alert, animated: true, completion: nil)
                    
                    self.flag = 1
                    
                }
            }
            }
            
            
            if self.flag == 0
                
            {
                let aPlace:placeDescription = placeDescription(name: newPlaceName,latitude: newPlaceLatitude, longitude: newPlaceLongitude, elevation: newPlaceElevation, address_title: newPlaceAddress_Title, address_street: newPlaceAddress_Street, description: newPlaceDesctiption, category: newPlaceCategory)
                
                let lib:PlaceLibrary=PlaceLibrary()
                lib.update(name: newPlaceName,latitude: newPlaceLatitude, longitude: newPlaceLongitude, elevation: newPlaceElevation, address_title: newPlaceAddress_Title, address_street: newPlaceAddress_Street, description: newPlaceDesctiption, category: newPlaceCategory)
                
                self.places[newPlaceName] = aPlace
            }
            self.names = Array(self.places.keys).sorted()
            self.tableView.reloadData()
            self.flag = 0
            
        }))
        
        
        promptND.addTextField(configurationHandler: {(textField: UITextField!) in
            textField.placeholder = "Place Name"
        })
        promptND.addTextField(configurationHandler: {(textField: UITextField!) in
            textField.placeholder = "Place Description"
        })
        promptND.addTextField(configurationHandler: {(textField: UITextField!) in
            textField.placeholder = "Place Category"
        })
        promptND.addTextField(configurationHandler: {(textField: UITextField!) in
            textField.placeholder = "Place Address-Title"
        })
        promptND.addTextField(configurationHandler: {(textField: UITextField!) in
            textField.placeholder = "Place Address-Street"
        })
        promptND.addTextField(configurationHandler: {(textField: UITextField!) in
            textField.placeholder = "Place Elevation"
        })
        promptND.addTextField(configurationHandler: {(textField: UITextField!) in
            textField.placeholder = "Place Latitude"
        })
        promptND.addTextField(configurationHandler: {(textField: UITextField!) in
            textField.placeholder = "Place Longitude"
        })
        
        present(promptND, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        print("tableView editing row at: \(indexPath.row)")
        if editingStyle == .delete {
            let selectedPlace:String = names[indexPath.row]
            print("deleting the place \(selectedPlace)")
            places.removeValue(forKey: selectedPlace)
            names = Array(places.keys).sorted()
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        }
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlaceCell", for: indexPath)
        let aPlace = places[names[indexPath.row]]! as placeDescription
        cell.textLabel?.text = aPlace.name
        cell.detailTextLabel?.text = "\(aPlace.category)"
        
        
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        NSLog("seque identifier is \(segue.identifier)")
        if segue.identifier == "PlaceDetail" {
            let viewController:ViewController = segue.destination as! ViewController
            let indexPath = self.tableView.indexPathForSelectedRow!
            viewController.places = self.places
            viewController.selectedPlace = self.names[indexPath.row]
            
        }
    }
    
}

