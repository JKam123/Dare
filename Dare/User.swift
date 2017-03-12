//
//  User.swift
//  Dare
//
//  Created by Jan on 3/11/17.
//  Copyright © 2017 GKN. All rights reserved.
//

import Foundation
import UIKit
import Firebase

struct User {
    let FirstName: String
    let LastName: String
    let ID: String
    var ProfilePic: UIImage
    
    init(id: String, firstName: String, lastName: String, profilePic: UIImage){
        FirstName = firstName
        LastName = lastName
        ID = id
        ProfilePic = profilePic
    }
    
    init(snapshot: FIRDataSnapshot, Image: UIImage, id: String) {
        let snapshotValue = snapshot.value as! [String: AnyObject]
        FirstName = snapshotValue["first"] as! String
        LastName = snapshotValue["last"] as! String
        ID = id
        ProfilePic = Image
    }

    mutating func setProfilePic(I: UIImage){
        self.ProfilePic = I
    }
    
}
