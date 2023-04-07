//
//  DBmanager.swift
//  MACos-project
//
//  Created by user237152 on 4/5/23.
//

import Foundation
import SQLite3



class DBmanager {
    let dbName = "contactsdb.db"
    var dbpointer: OpaquePointer?

    init() {
        opendatabase()
    }

    func opendatabase(){
        let fileURL = try! FileManager.default
            .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent(dbName)
        //opens the database
        if sqlite3_open(fileURL.path, &dbpointer) != SQLITE_OK {
            print("error opening database.")
            return
        } else {
            print("connected to database.")
            print("\(fileURL.path)")
        }
        //this somehow got my table working so yea. it creates a new table in the .db file if it doesn't exist.
        if sqlite3_exec(dbpointer, "CREATE TABLE IF NOT EXISTS contacts (id INTEGER PRIMARY KEY AUTOINCREMENT, firstname TEXT, lastname TEXT, email TEXT, address TEXT, phone TEXT, notes TEXT);", nil, nil, nil) != SQLITE_OK {
                    print("couldn't make a table")
        }
    }

    func insertdata(firstname: String, lastname: String, email: String, address: String, phone: String, notes: String) {
        var insertpointer: OpaquePointer?

        let insertstatement = "INSERT INTO contacts (firstname, lastname, email, address, phone, notes) VALUES (?, ?, ?, ?, ?, ?);"
        //after delcaring our insert statement and grab our pointer, we'll use a check to see if they're correct.
        // if true, it'll insert all of the data.
        if sqlite3_prepare_v2(dbpointer, insertstatement, -1, &insertpointer, nil) == SQLITE_OK {
            //if i didn't use (.. as NSString) it'll make my rows all blank.
            sqlite3_bind_text(insertpointer, 1, (firstname as NSString).utf8String, -1, nil)
                   sqlite3_bind_text(insertpointer, 2, (lastname as NSString).utf8String, -1, nil)
                   sqlite3_bind_text(insertpointer, 3, (email as NSString).utf8String, -1, nil)
                   sqlite3_bind_text(insertpointer, 4, (address as NSString).utf8String, -1, nil)
                   sqlite3_bind_text(insertpointer, 5, (phone as NSString).utf8String, -1, nil)
                   sqlite3_bind_text(insertpointer, 6, (notes as NSString).utf8String, -1, nil)
            
            if sqlite3_step(insertpointer) == SQLITE_DONE {
                print("data added to database.")
            } else {
                print("error inserting data.")
            }

            sqlite3_finalize(insertpointer)
        } else {
            print("db doesn't exist or error occured.")
        }
    }

    func readData() {
        // add later
    }
}

