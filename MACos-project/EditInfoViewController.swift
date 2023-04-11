//
//  EditInfoViewController.swift
//  MACos-project
//
//  Created by user237152 on 4/11/23.
//

import UIKit

class EditInfoViewController: UIViewController {
    
    @IBOutlet weak var IDlbl: UILabel!
    
    @IBOutlet weak var FirstTxtField: UITextField!
    
    @IBOutlet weak var LastTextField: UITextField!
    
    @IBOutlet weak var EmaiTextfield: UITextField!
    
    @IBOutlet weak var AddressTextField: UITextField!
    
    @IBOutlet weak var PhoneTextField: UITextField!
    
    @IBOutlet weak var NoteTextView: UITextView!
    
    @IBOutlet weak var Closebtn: UIButton!
    
    @IBOutlet weak var Savebtn: UIButton!
    
    //everything else had to be copy pasted otherwise it'll throw a error explaining outlet relationship issues.
    @IBOutlet weak var editbtn: UIButton!
    
    @IBOutlet weak var idlbl: UILabel!
    
    @IBOutlet weak var namelabel: UILabel!
    
    @IBOutlet weak var lastlabel: UILabel!
    
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var notetxtview: UITextView!
    
    @IBOutlet weak var addresslbl: UILabel!
    
    @IBOutlet weak var phonelbl: UILabel!
    //end of paste
    
    var editID: Int?
    
    var editFirst: String?
    
    var editLast: String?
    
    var editEmail: String?
    
    var editAddress: String?
    
    var editPhone: String?
    
    var editNotes: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        IDlbl.text = "ID: \(String(editID ?? 0))"
        FirstTxtField.text = editFirst
        LastTextField.text = editLast
        EmaiTextfield.text = editEmail
        AddressTextField.text = editAddress
        PhoneTextField.text = editPhone
        NoteTextView.text = editNotes
        
    }
    
    
    @IBAction func closepage_action(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
