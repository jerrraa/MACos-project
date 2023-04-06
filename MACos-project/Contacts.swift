//
//  Contacts.swift
//  MACos-project
//
//  Created by user237152 on 4/6/23.
//

import Foundation

class Contacts {
    
    
    var firstname: String = ""
    var lastname: String = ""
    
    var email: String = ""
    var address: String = ""
    
    var phone: Int = 0
    
    var notes: String = "";
    
    init(first:String, last:String, email: String, address: String, phone:Int, Notes:String) {
        self.firstname = first;
        self.lastname = last;
        self.address = address;
        self.phone = phone;
        self.notes = Notes;
    }
    
}
