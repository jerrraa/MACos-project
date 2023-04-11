//
//  ContactViewController.swift
//  MACos-project
//
//  Created by user237152 on 4/5/23.
//

import UIKit

class ContactViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  var contacts = [Contacts]()
  var dbfile = DBmanager()
  @IBOutlet weak var tableview: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
      
    tableview.register(UITableViewCell.self, forCellReuseIdentifier: "tablecell")
      
    tableview.delegate = self
    tableview.dataSource = self
      
 
    contacts = dbfile.readdata()
    tableview.reloadData()
  }
    //this fixed my issue on displaying data if it's edited, delete or adding
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        contacts = dbfile.readdata()
        tableview.reloadData()
    }

//i've watched lesson 9 part 2, so i reworked this function so i don't need a resource i linked before.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //when user taps on a row, store it into contacts[] and insert it into a vari.
        let selectedcontact = contacts[indexPath.row]
        print("\(selectedcontact.id)")
        
        self.performSegue(withIdentifier: "sequeClientDetails", sender: selectedcontact)
       
  }
    
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return contacts.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "tablecell", for: indexPath)
    let contact = contacts[indexPath.row]
      
      let id = contact.id
      let first = contact.firstname
      let last = contact.lastname
      let email = contact.email
      let address = contact.address
      let phone = contact.phone
      let notes = contact.notes
      
      cell.textLabel?.text = "ID: \(id)\nName: \(first) \(last)\nEmail: \(email)\nAddress: \(address)\nPhone: \(phone)\nNotes: \(notes)"
      cell.textLabel?.numberOfLines = 0
      cell.layer.cornerRadius = 8
      cell.layer.masksToBounds = true
    
      
    return cell
  }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sequeClientDetails",
            let destinationVC = segue.destination as? ClientDetailsViewController,
            let selectedcontact = sender as? Contacts {
                destinationVC.selectedID = selectedcontact.id
                destinationVC.selectedFirstName = selectedcontact.firstname
                destinationVC.selectedLastName = selectedcontact.lastname
                destinationVC.selectedEmail = selectedcontact.email
                destinationVC.selectedAddress = selectedcontact.address
                destinationVC.selectedPhone = selectedcontact.phone
                destinationVC.selectedNotes = selectedcontact.notes
            }
        }

}
