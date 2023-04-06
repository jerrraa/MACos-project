//
//  DBmanager.swift
//  MACos-project
//
//  Created by user237152 on 4/5/23.
//

import Foundation
import SQLite3

class DBmanager {
    init() {
        
        db = openDatabase()
    }
    
    let dbpath:String = "mac-contact.sqlite"
    var db:OpaquePointer?
    
    
    func openDatabase() -> OpaquePointer? {
        let filepath = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent(dbpath)
        var db: OpaquePointer? = nil
        if sqlite3_open(filepath.path, &db) != SQLITE_OK {
            return nil
        } else {
            print("i have connect to the database")
            return db
        }
    }
    
    func insertdata(firstname: String, lastname:String, email:String, address:String, phone:String, notes:String) {
        var insertpointer: OpaquePointer? = nil
        
        let insertstatement = "INSERT INTO contacts (firstname, lastname, email, address, phone, notes) VALUES (?, ?, ?, ?, ?, ?);"
        print(" i was executed")
        if sqlite3_prepare_v2(db, insertstatement, -1, &insertpointer, nil) == SQLITE_OK {
            sqlite3_bind_text(insertpointer, 1, firstname, -1, nil)
            sqlite3_bind_text(insertpointer, 2, lastname, -1, nil)
            sqlite3_bind_text(insertpointer, 3, email, -1, nil)
            sqlite3_bind_text(insertpointer, 4, address, -1, nil)
            sqlite3_bind_text(insertpointer, 5, phone, -1, nil)
            sqlite3_bind_text(insertpointer, 6, notes, -1, nil)
            
            if sqlite3_step(insertpointer) == SQLITE_OK {
                print("data was added to database.")
                
            } else {
                print("incorrect!!")
            }
            
            sqlite3_finalize(insertpointer)
            
        }
    }
    
    func readdata() {
        //add later
    }
}
