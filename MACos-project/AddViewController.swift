//
//  AddViewController.swift
//  MACos-project
//
//  Created by user237152 on 4/5/23.
//

import UIKit
import SQLite3
class AddViewController: UIViewController {

    
    @IBOutlet weak var FirstTextField: UITextField!
    
    @IBOutlet weak var LastTextField: UITextField!
    
    @IBOutlet weak var EmailTextField: UITextField!
    
    @IBOutlet weak var AddressTextField: UITextField!
    
    @IBOutlet weak var PhoneTextField: UITextField!

    @IBOutlet weak var NoteTextView: UITextView!
    
    @IBOutlet weak var SubmitBtn: UIButton!
    
    var db = DBmanager()
    
    override func viewDidLoad() {
        super.viewDidLoad();
            
        
    }
    

    @IBAction func submit_action(_ sender: UIButton) {
        if let firstname = FirstTextField.text,
           let lastname = LastTextField.text,
           let email = EmailTextField.text,
           let address = AddressTextField.text,
           let phone = PhoneTextField.text,
           let notes = NoteTextView.text {
            //add data validators later. only for testing purposes
               db.insertdata(firstname: firstname, lastname: lastname, email: email, address: address, phone: phone, notes: notes)
        }
    }
    

    	

}
