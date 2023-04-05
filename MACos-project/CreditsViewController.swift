//
//  CreditsViewController.swift
//  MACos-project
//
//  Created by user237152 on 4/5/23.
//

import UIKit

class CreditsViewController: UIViewController {

    @IBOutlet weak var DateLbl: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //on-load we'll grab the current date and convert to string so we can display it
        let currentdate = Date();
        
        let dateformat  = DateFormatter();
        //using datestyle displays the current date but not time.
        dateformat.dateStyle = .long
        //convert the date to a string
        let dateString = dateformat.string(from: currentdate)
        //
        DateLbl.text = dateString;
        
        
    }
    

  
}
