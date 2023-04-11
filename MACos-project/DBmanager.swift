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
            .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)            .appendingPathComponent(dbName)
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
//copy pasted from insert data as they do the same thign except diff statements.
    func deletedata(id: Int) {
        var deletepointer: OpaquePointer?
        
        let deletestatement = "DELETE FROM contacts WHERE id = ?;"
        //now we have our delete statement and pointer, we'll use a if statement to make sure they're valid.
        if sqlite3_prepare_v2(dbpointer, deletestatement, -1, &deletepointer, nil) == SQLITE_OK {
            //we'll use the id to delete our row.
            sqlite3_bind_int(deletepointer, 1, Int32(id))
            
            if sqlite3_step(deletepointer) == SQLITE_OK {
                print("\(id) has been deleted.")
            } else {
                print ("error deleting the data")
            }
            sqlite3_finalize(deletepointer)
            
        } else {
            print("db doesn't exist or error occured.")
        }
        
    }
    
    //reads the data from my contacts table and it'll return a class that'll be stored into a array to display data.
    func readdata() -> [Contacts] {
        var contacts = [Contacts]()
        //as before we get our statement and pointer.
        let readContactStatement = "SELECT * FROM contacts"
        var readpointer: OpaquePointer?
        
        if sqlite3_prepare_v2(dbpointer, readContactStatement, -1, &readpointer, nil) == SQLITE_OK {
            while sqlite3_step(readpointer) == SQLITE_ROW {
                //it goes through each row and grabs the data from those rows and turns them into variables that'll be used near end of ht loop.
                let id = sqlite3_column_int(readpointer, 0)
                let firstname = String(cString: sqlite3_column_text(readpointer, 1))
                let lastname = String(cString: sqlite3_column_text(readpointer, 2))
                let email = String(cString: sqlite3_column_text(readpointer, 3))
                let address = String(cString: sqlite3_column_text(readpointer, 4))
                let phone = String(cString: sqlite3_column_text(readpointer, 5))
                let notes = String(cString: sqlite3_column_text(readpointer, 6))
                //as i have a contacts class, i'll be using the constructor to store my data.
                let contact = Contacts(id: Int(id), first: firstname, last: lastname, email: email, address: address, phone: phone, notes: notes)
                contacts.append(contact)
            }
            
            sqlite3_finalize(readpointer)
        }
        //returns all of the contacts that's in the db.
        return contacts
    }

    func savenotes(id: Int, notes: String) {
        var savepointer: OpaquePointer?
        
        print("\(id)")
        let savestatement = ""
        print("\(notes)")
    }

    
    func editcontacts(id: Int, firstname: String, lastname: String, email: String, address: String, phone: String, notes: String) {
        //add code when finished view contacts page.
    }
    
    func compareEmails(email: String) -> Bool {
        //selects all of the email data present in the table
        let comparestatement = "SELECT * FROM contacts WHERE email = ?;"
        var comparepointer: OpaquePointer?
        
        if sqlite3_prepare_v2(dbpointer, comparestatement, -1, &comparepointer, nil) == SQLITE_OK {
            sqlite3_bind_text(comparepointer, 1, (email as NSString).utf8String, -1, nil)
            //now our pointer stored our email, we'll go through all rows to see if they match.
            if sqlite3_step(comparepointer) == SQLITE_ROW {
                //return true if found.
                return true;
            }
        }
        //deacllocate our pointer and return false as nothing was cmopared.
        sqlite3_finalize(comparepointer)
        return false;
    }
    
}

