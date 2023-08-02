//
//  DatabaseHelper.swift
//  TODO App Realm
//
//  Created by Khushali Vagadia on 31/07/23.
//

import RealmSwift
import UIKit

class DatabaseHelper {
    static let shared = DatabaseHelper()
    
    private var realm = try! Realm()
    
    func getDatabaseURL() -> URL?{
        return Realm.Configuration.defaultConfiguration.fileURL 
    }
    
    func saveContact(contact: Contact) {
        try! realm.write{
            realm.add(contact)
        }
    }
}
