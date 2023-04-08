//
//  Contacts.swift
//  MACos-project
//
//  Created by user237152 on 4/6/23.
//

import Foundation

class Contacts {
    
    var id: Int = 0
    var firstname: String = ""
    var lastname: String = ""
    
    var email: String = ""
    var address: String = ""
    
    var phone: String = ""
    
    var notes: String = "";
    
    init(id: Int, first:String, last:String, email: String, address: String, phone:String, notes:String) {
        self.id = id;
        self.firstname = first;
        self.lastname = last;
        self.address = address;
        self.phone = phone;
        self.notes = notes;
        self.email = email;
    }
    
}
