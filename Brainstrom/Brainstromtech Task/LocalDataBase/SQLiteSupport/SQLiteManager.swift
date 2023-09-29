//
//  SQLiteManager.swift
//  Brainstromtech Task
//
//  Created by Diana Sargsyan on 18.08.23.
//

import Foundation
import SQLite3

class SQLiteManager: NSObject {
    
    static let sharedInstance = SQLiteManager()
    
    private override init() {}
    
    func openDB() -> OpaquePointer? {
        
        let documentsDirectory = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString) as String
        let pathToDatabase = documentsDirectory.appending("/SQLliteDB.db")
        
        let fileManager = FileManager.default
        
        let success = fileManager.fileExists(atPath: pathToDatabase)
        let databasePath = Bundle.main.path(forResource: "SQLliteDB", ofType: "db")
        if !success {
            
            do {
                // copy files from main bundle to documents directory
                print("copy")
                try
                FileManager.default.copyItem(atPath: databasePath!, toPath: pathToDatabase)
            } catch let error as NSError {
                // Catch fires here, with an NSError being thrown
                print("error occurred, here are the details:\n \(error)")
            }
        }
        
        var db: OpaquePointer? = nil
        if sqlite3_open(pathToDatabase, &db) == SQLITE_OK {
            print("Successfully opened connection to database at /\(pathToDatabase)")
            return db
        } else {
            print("Unable to open database. Verify that you created the directory described " +
                  "in the Getting Started section.")
            
        }
        return db
    }
    
    
    func closeDB() -> OpaquePointer? {
        
        let db: OpaquePointer? = nil
        
        
        if sqlite3_close(db) == SQLITE_OK {
            print("Successfully closed connection to database at")
            return db
        } else {
            print("Unable to close database. Verify that you created the directory described " +
                  "in the Getting Started section.")
            
        }
        return db
    }
}
