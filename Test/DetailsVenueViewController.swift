//
//  DetailsVenueViewController.swift
//  Test
//
//  Created by Mac on 10/03/17.
//  Copyright © 2017 Surya Foundation. All rights reserved.
//

import UIKit

class DetailsVenueViewController: UIViewController {


    @IBOutlet weak var detailsAddressLbl: UILabel!
    @IBOutlet weak var detailsNameLbl: UILabel!
    
    @IBOutlet weak var detailsState: UILabel!
    @IBOutlet weak var detailsCity: UILabel!
    @IBOutlet weak var detailsDistance: UILabel!
    @IBOutlet weak var detailsStreet: UILabel!
    var getName = String()
    var getAddress = String()
    var getStreet = String()
    var getDistance = Double()
    var getCity = String()
    var getState = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.loadDetailsOfVenue()
    }

    //MARK: Load Venue Details of Info 
    func loadDetailsOfVenue() {
        self.detailsNameLbl.text = self.getName
        self.detailsAddressLbl.text = self.getAddress
        self.detailsStreet.text = self.getStreet
        self.detailsDistance.text = NSString(format: "%.f", self.getDistance) as String
        self.detailsCity.text = self.getCity
        self.detailsState.text = self.getState
    }
    
    @IBAction func backBtnClicked(sender: AnyObject) {
        
    let _ = self.navigationController?.popViewControllerAnimated(true)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
