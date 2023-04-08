//
//  ClientDetailsViewController.swift
//  MACos-project
//
//  Created by user237152 on 4/8/23.
//

import UIKit

class ClientDetailsViewController: UIViewController {
    
    var contact: Contacts?
    
    @IBOutlet weak var idlbl: UILabel!
    
    @IBOutlet weak var namelabel: UILabel!
    
    @IBOutlet weak var lastlabel: UILabel!
    
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var notetxtview: UITextView!
    
    @IBOutlet weak var addresslbl: UILabel!
    
    @IBOutlet weak var phonelbl: UILabel!
    
    
    @IBOutlet weak var editbtn: UIButton!
    
    @IBOutlet weak var savenotesbtn: UIButton!
    
    @IBOutlet weak var deletebtn: UIButton!
    
    @IBOutlet weak var exitbtn: UIButton!
    
    var dbfile = DBmanager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("\(contact?.id)")
        // Do any additional setup after loading the view.
        
        idlbl.text = String(contact?.id ?? 0)
        namelabel.text = contact?.firstname
        lastlabel.text = contact?.lastname
        emailLabel.text = contact?.email
        addresslbl.text = contact?.address
        phonelbl.text = contact?.phone
        notetxtview.text = contact?.notes
        
    }
    

    @IBAction func exit_action(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func delete_action(_ sender: UIButton) {
        
    }
    
    
}
