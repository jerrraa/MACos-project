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
    
    var dbfile = DBmanager()
    
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
            
            //we'll validate the email and phone and if it's not true, it won't insert the data. i found it easier if i use ors.
            if (!validateEmail(email) || !validatephone(phone)) {
                print("invalid email or phone number.")
                return
            } else {
                if (dbfile.compareEmails(email: email) == true) {
                    //if it does exist, it'll return a false if not return true and it'll continue.
                    print("there's a existing email in the database!")
                    return
                } else {
                
                //by our lets, we get to use those variables to insert our data.
                dbfile.insertdata(firstname: firstname, lastname: lastname, email: email, address: address, phone: phone, notes: notes)
                clearfields()
            }
           }
        }
    }
    //validates the email inside of the textifled and it'll return false if it's incorrect
    private func validateEmail(_ email: String) -> Bool {
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return emailPredicate.evaluate(with: email)
    }

    //validates the phone and it'll check if they're numbers or < 10. returns falses if it's not correct
    private func validatephone(_ phonenumber: String) -> Bool {
        let regex = "^\\d{10}$"
        let phoneNumberPredicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return phoneNumberPredicate.evaluate(with: phonenumber)
    }
    //instead of writing all of this code in the submit_action function i used this instead. clears all textfields.
    private func clearfields() {
        FirstTextField.text = ""
        LastTextField.text = ""
        EmailTextField.text = ""
        AddressTextField.text = ""
        PhoneTextField.text = ""
        NoteTextView.text = ""
    }
    
    private func checkforblank() -> Bool {
       return false
    }
    

    	

}
