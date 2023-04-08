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
  //https://stackoverflow.com/questions/65428289/how-to-tap-on-tableview-cell-and-navigate-to-another-tableview-in-the-next-viewc
  //here's what i used to implement this function.
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //when user taps on a row, store it into contacts[] and insert it into a vari.
        let selectedcontact = contacts[indexPath.row]
        print("\(selectedcontact.id)")
        //we reference our storyboard in order to present client details page.
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let detailVC = storyboard.instantiateViewController(withIdentifier: "ClientDetailsView") as! ClientDetailsViewController
        
        //detailvc = clientdetailscontrolerview so we store our contacts into a another contacts or constructor.
        detailVC.contact = selectedcontact
        //display the page w/ all of the data
        present(detailVC, animated: true, completion: nil)
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
  
}
