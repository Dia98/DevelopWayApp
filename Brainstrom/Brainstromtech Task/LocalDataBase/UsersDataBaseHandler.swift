//
//  UsersDataBaseHandler.swift
//  Brainstromtech Task
//
//  Created by Diana Sargsyan on 18.08.23.
//

import Foundation
import SQLite3

class SQLliteDBContactsHandler: NSObject{
    
    static let sharedInstance = SQLliteDBContactsHandler()
    
    func createTable() {
        
        let db = SQLiteManager.sharedInstance.openDB()

        let createTableString = "CREATE TABLE IF NOT EXISTS ContactsTable(Id TEXT PRIMARY KEY NOT NULL, fullName TEXT NOT NULL, pictureUrl TEXT NOT NULL, gender TEXT NOT NULL, address TEXT NOT NULL, phone TEXT NOT NULL, latitude REAL, longitude REAL);"
        var createTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK
        {
            if sqlite3_step(createTableStatement) == SQLITE_DONE
            {
                print("ContactsTable table created.")
            } else {
                print("ContactsTable table could not be created.")
            }
        } else {
            print("CREATE TABLE statement could not be prepared.")
        }
        sqlite3_finalize(createTableStatement)
        sqlite3_close(db)
    }
    
    func insertItemInDB(item: any User, id: String) {
        var insertStatement: OpaquePointer? = nil
        
        let db = SQLiteManager.sharedInstance.openDB()
        
        let items = getItemListFromDB()
        for i in items {
            if i.id == id {
                return
            }
        }
        
        let insertStatementString = "INSERT INTO ContactsTable (Id, fullName, pictureUrl, gender, address, phone, latitude, longitude) VALUES (?, ?, ?, ?, ?, ?, ?, ?);"
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            
            sqlite3_bind_text(insertStatement, 1, (id as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 2, (item.fullName as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 3, (item.pictureUrl as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 4, (item.gender as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 5, (item.address as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 6, (item.phone as NSString).utf8String, -1, nil)
            
            sqlite3_bind_double(insertStatement, 7, item.latitude)
            sqlite3_bind_double(insertStatement, 8, item.longitude)
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Successfully inserted row.")
            } else {
                print("Could not insert row.")
            }
        } else {
            print("INSERT statement could not be prepared.")
        }
        sqlite3_finalize(insertStatement)
        sqlite3_close(db)
    }
    
    func getItemListFromDB() -> Array<SavedUserModel>  {
        let db = SQLiteManager.sharedInstance.openDB()
        
        let queryStatementString = "SELECT * FROM ContactsTable;"
        var queryStatement: OpaquePointer? = nil
        var array : [SavedUserModel] = []
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                
                let id = String(describing: String(cString: sqlite3_column_text(queryStatement, 0)))
                let fullName = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                let pictureUrl = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
                let gender = String(describing: String(cString: sqlite3_column_text(queryStatement, 3)))
                let address = String(describing: String(cString: sqlite3_column_text(queryStatement, 4)))
                let phone = String(describing: String(cString: sqlite3_column_text(queryStatement, 5)))
                let latitude = sqlite3_column_double(queryStatement, 6)
                let longitude = sqlite3_column_double(queryStatement, 7)
                
                array.append(SavedUserModel(id: String(id), fullName: String(fullName), pictureUrl: String(pictureUrl), gender: String(gender), address: String(address), phone: String(phone), latitude: Double(latitude), longitude: Double(longitude)))
                print("Query Result:")
                print("\(id) | \(fullName) | \(pictureUrl) | \(gender) | \(address) | \(phone) | \(latitude) | \(longitude)")
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return array
    }
    
    func doesUserExist(id: String) -> Bool {
        let db = SQLiteManager.sharedInstance.openDB()
        
        let queryStatementString = """
        SELECT *
        FROM ContactsTable
        WHERE Id = \(id);
        """
        var queryStatement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                
                let id = sqlite3_column_int(queryStatement, 0)
                
                print("Query Result:")
                print("\(id)")
                return true
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return false
    }
    
    func removeUser(id: String) {
        var deleteStatement: OpaquePointer? = nil
        
        let db = SQLiteManager.sharedInstance.openDB()
        
        let deleteStatementString = "DELETE FROM ContactsTable WHERE Id = ?;"
        
        if sqlite3_prepare_v2(db, deleteStatementString, -1, &deleteStatement, nil) == SQLITE_OK {
            
            sqlite3_bind_text(deleteStatement, 1, (id as NSString).utf8String, -1, nil)
            
            if sqlite3_step(deleteStatement) == SQLITE_DONE {
                print("Successfully deleted row")
            }
            else {
                print("Cloud not delete row")
            }
            
        } else {
            print("Delete statement could not be prepared.")
        }
        sqlite3_finalize(deleteStatement)
        sqlite3_close(db)
    }
    
    func deleteAllItemsFromDB() {
        var deleteStatement: OpaquePointer? = nil
        
        let db = SQLiteManager.sharedInstance.openDB()
        
        let deleteStatementString = "DELETE * FROM ContactsTable;"
        
        if sqlite3_prepare_v2(db, deleteStatementString, -1, &deleteStatement, nil) == SQLITE_OK {
            
            if sqlite3_step(deleteStatement) == SQLITE_DONE {
                print("Successfully Delete row.")
            } else {
                print("Could not delete row.")
            }
        } else {
            print("Delete statement could not be prepared.")
        }
        sqlite3_finalize(deleteStatement)
        sqlite3_close(db)
    }
}
