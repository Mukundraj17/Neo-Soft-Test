//
//  ViewController.swift
//  Test
//
//  Created by Mac on 10/03/17.
//  Copyright © 2017 Surya Foundation. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UITableViewDataSource , UITableViewDelegate {
    
    var listVenueArray = [VenueModel]()
    var jsonResultVenueName = String()
    var jsonResultVenueAddress = String()
    var jsonResultVenueStreet = String()
    var jsonResultVenueDistance = Double()
    var jsonResultVenueCity = String()
    var jsonResultVenueState = String()
    
    
    @IBOutlet weak var venueListTable: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.loadListOfVenuesData()
    }
    

    //MARK : TableView Data Source & Delgate Methods.
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listVenueArray.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .Subtitle, reuseIdentifier: "cellIdentifier")
        
        let extractJsonData = self.listVenueArray[indexPath.row]
        
        cell.textLabel?.text = extractJsonData.venueName
        
        cell.detailTextLabel?.text = NSString(format: "%.f", extractJsonData.venuedistance) as String
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

       self .performSegueWithIdentifier("asDetailsVC", sender: self)
    }
   
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 55.0
    }
    
    
    //MARK: Load Venues Data Via API........
    
    func loadListOfVenuesData(){
        
        let url = NSURL(string: "https://api.foursquare.com/v2/venues/search?client_secret=UPZJO0A0XL44IHCD1KQBMAYGCZ45Z03BORJZZJXELPWHPSAR&ll=19.0176147,72.8561644&client_id=5P1OVCFK0CCVCQ5GBBCWRFGUVNX5R4WGKHL2DGJGZ32FDFKT&query=hotel&limit=10&radius=5000&v=20170307")
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "GET"
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request){ data, response, error in
            if error != nil{
                print("Error -> \(error)")
            }else{
                
                let result = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers)
                
                let jsonResponse = result["response"]
                
                let getVenues = jsonResponse!!["venues"] as! [AnyObject]
                
                for item in 0..<getVenues.count {
                    let getJson = getVenues[item] as! NSDictionary
                    if let getName : String = getJson["name"] as? String {
                        self.jsonResultVenueName = getName
                    }
                    if let getAddress : String = getJson["location"]?.valueForKey("address") as? String {
                        self.jsonResultVenueAddress = getAddress
                    }
                    if let getCrossStreet : String = getJson["location"]?.valueForKey("crossStreet") as? String {
                        self.jsonResultVenueStreet = getCrossStreet
                    }
                    if let getDistance : Double = getJson["location"]?.valueForKey("distance") as? Double {
                        self.jsonResultVenueDistance = getDistance
                    }
                    if let getCity : String = getJson["location"]?.valueForKey("city") as? String {
                        self.jsonResultVenueCity = getCity
                    }
                    if let getState : String = getJson["location"]?.valueForKey("state") as? String {
                        self.jsonResultVenueState = getState
                    }
                    
                    
                self.listVenueArray.append(VenueModel(name: self.jsonResultVenueName, address: self.jsonResultVenueAddress, crossSteet: self.jsonResultVenueStreet, distance: self.jsonResultVenueDistance, City: self.jsonResultVenueCity, State: self.jsonResultVenueState))
                    
                }
                
                dispatch_async(dispatch_get_main_queue()) {
                    self.venueListTable .reloadData()
                }

                
            }
        }
        
        task.resume()
    }
    
    
    
    //MARK: Prepare for segue Method while doing Transaction from one view to another view.
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "asDetailsVC" {
            
        let objOfView = segue.destinationViewController as! DetailsVenueViewController
        let getRow = self.venueListTable.indexPathForSelectedRow
        let selectedRow = self.listVenueArray[(getRow?.row)!]
        objOfView.getName = selectedRow.venueName
        objOfView.getAddress = selectedRow.venueAddress
        objOfView.getStreet = selectedRow.venuecrosssStreet
        objOfView.getDistance = selectedRow.venuedistance
        objOfView.getCity = selectedRow.venuecity
        objOfView.getState = selectedRow.venueState
            
        }
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

