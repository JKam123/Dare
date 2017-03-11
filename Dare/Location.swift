//
//  Location.swift
//  Dare
//
//  Created by Jan on 3/5/17.
//  Copyright © 2017 GKN. All rights reserved.
//

import Foundation
import Firebase

struct Location {
    
    let name: String
    let langitude: String
    let lattitude: String
    let description: String
    let type: Int
    let user: String
    let timestamp: String
    
    init(Name: String, Langitude: Float, Lattitude: Float, Description: String,Type: Int, User: String,  Timestamp: UInt64) {
        self.name = Name
        self.langitude = String(Langitude)
        self.lattitude = String(Lattitude)
        self.description = Description
        self.type = Type
        self.user = User
        self.timestamp = String(Timestamp)
    }
    
    init(snapshot: FIRDataSnapshot) {
        let snapshotValue = snapshot.value as! [String: AnyObject]
        name = snapshotValue["name"] as! String
        langitude = snapshotValue["langitude"] as! String
        lattitude = snapshotValue["lattitude"] as! String
        description = snapshotValue["description"] as! String
        type = snapshotValue["type"] as! Int
        user = snapshotValue["user"] as! String
        timestamp = snapshotValue["timestamp"] as! String

    }
    
    func toAnyObject() -> Any {
        return [
            "langitude": langitude,
            "lattitude": lattitude,
            "description": description,
            "type": type,
            "user": user,
            "timestamp": timestamp,
            "name": name
            
        ]
    }
    
}
