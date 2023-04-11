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
    
    @IBOutlet weak var savenotesbtn: UIButton!
    
    @IBOutlet weak var deletebtn: UIButton!
    
    @IBOutlet weak var exitbtn: UIButton!
    
    var selectedID: Int?
    
    var selectedFirstName: String?
    
    var selectedLastName: String?
    
    var selectedEmail: String?
    
    var selectedAddress: String?
    
    var selectedPhone: String?
    
    var selectedNotes: String?
    
    var dbfile = DBmanager()
    var contacts = [Contacts]()
    override func viewDidLoad() {
        super.viewDidLoad()
        //print("\(contact?.id)")
        // Do any additional setup after loading the view.
        //print("\(selectedFirstName)")
        
        idlbl.text = String(selectedID ?? 0)
        namelabel.text = selectedFirstName
        lastlabel.text = selectedLastName
        emailLabel.text = selectedEmail
        addresslbl.text = selectedAddress
        phonelbl.text = selectedPhone
        notetxtview.text = selectedNotes
        
    }
    

    @IBAction func exit_action(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func delete_action(_ sender: UIButton) {
        print("pressed")

        let alert = UIAlertController(title: "Confirmation", message: "Are you sure you want to delete this data?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { action in
            let contactid: Int32 = Int32(self.idlbl.text ?? "0") ?? 0
            
            self.dbfile.deletedata(id: Int(contactid))
            self.dismiss(animated: true, completion: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
        
    }

    @IBAction func savenotes_action(_ sender: Any) {
        let contactid: Int32 = Int32(self.idlbl.text ?? "0") ?? 0
       // print("\(String(notetxtview.text))")
        let savenotes = String(notetxtview.text)
        
        dbfile.savenotes(id: Int(contactid), notes: savenotes)
    }
    
    
    @IBAction func edit_action(_ sender: Any) {
        //grab all data from our previous seque and store it into contacts
        let editcontact = Contacts(id: selectedID ?? 0, first: selectedFirstName ?? "", last: selectedLastName ?? "", email: selectedEmail ?? "", address: selectedAddress ?? "", phone: selectedPhone ?? "", notes: selectedNotes ?? "")

            print("\(editcontact.firstname)")
            //instead of using the present function, i replaced it with performseque.
            performSegue(withIdentifier: "sequeEdit", sender: editcontact)
    }
    
     
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sequeEdit",
            let destinationVC = segue.destination as? EditInfoViewController,
            let selectedcontact = sender as? Contacts {
            //copy pasted from the tableview perform as it saved time
            destinationVC.editID = selectedcontact.id
            destinationVC.editFirst = selectedcontact.firstname
            destinationVC.editLast = selectedcontact.lastname
            destinationVC.editEmail = selectedcontact.email
            destinationVC.editAddress = selectedcontact.address
            destinationVC.editPhone = selectedcontact.phone
            destinationVC.editNotes = selectedcontact.notes
        }
    }
    
}
