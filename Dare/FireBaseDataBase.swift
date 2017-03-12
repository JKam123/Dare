//
//  FireBaseDataBase.swift
//  Dare
//
//  Created by Jan on 3/5/17.
//  Copyright © 2017 GKN. All rights reserved.
//

import Foundation
import Firebase

class FireBaseDataBase {
    public var AllLocations: [Location] = []
    
    func addLocvaron(Loc: Location){
        let reference = FIRDatabase.database().reference(withPath: "locations")
        let specifiRef = reference.child(Loc.name.lowercased())
        specifiRef.setValue(Loc.toAnyObject())
    }
    
    func loadLocations(completion: @escaping (([Location])->Void)){
        AllLocations.removeAll()
        let reference = FIRDatabase.database().reference(withPath: "locations")

        reference.observe(.value, with: { snapshot in
            print(snapshot.children)
            for location in snapshot.children {
                let Temp = Location(snapshot: location as! FIRDataSnapshot)
                self.AllLocations.append(Temp)
                

            }
            completion(self.AllLocations)
        })
        
    }
    func addUser(ID: String, Mail: String, FN: String, LN: String, DoB: String, ProfPic: UIImage){
        let reference = FIRDatabase.database().reference(withPath: "users")
        let specifiRef = reference.child(ID)
        specifiRef.setValue(["mail":Mail,"first":FN,"last":LN,"dob":DoB] )
        
        let storageRef = FIRStorage.storage().reference()
        let profileRef = storageRef.child("profiles/"+ID)
        let fileName = "profile.jpg"
        let picRef = profileRef.child(fileName)
        
        var data = NSData()
        data = UIImageJPEGRepresentation(ProfPic, 0.8)! as NSData
        // set upload path
        let metaData = FIRStorageMetadata()
        metaData.contentType = "image/jpg"
        picRef.put(data as Data, metadata: metaData){(metaData,error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }else{
                
            }
            
        }
    }
    
    func getUser(ID: String, completion: @escaping ((User)->Void)){
        let storageRef = FIRStorage.storage().reference()
        let islandRef = storageRef.child("profiles/"+ID+"/profile.jpg")
        islandRef.data(withMaxSize: 15 * 1024 * 1024) { data, error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                // Data for "images/island.jpg" is returned
                let image = UIImage(data: data!)
                let reference = FIRDatabase.database().reference()
                reference.child("users").child(ID).observeSingleEvent(of: .value, with: { (snapshot) in
                    // Get user value
                    let user = User.init(snapshot: snapshot, Image: image!, id: ID)
                    completion(user)
                })
            }
        
        }
    }
    
    func getFoodPicture(ID: String, Timestamp: String,completion: @escaping ((UIImage)->Void)) {
        let storageRef = FIRStorage.storage().reference()
        let pictureRef = storageRef.child("profiles/"+ID+"/"+Timestamp+".jpg")
        pictureRef.data(withMaxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                let image = UIImage(data: data!)
                completion(image!)
            }
        }
        
    }
    
    func loadUserPic(U: User){
        if var U = U as? User{
            let storageRef = FIRStorage.storage().reference()
            let picRef = storageRef.child("profiles/"+U.ID+"/profile.jpg")
            picRef.data(withMaxSize: 1 * 1024 * 1024) { data, error in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    // Data for "images/island.jpg" is returned
                    let image = UIImage(data: data!)
                    U.setProfilePic(I: image!)
                }
            }

        }
    }

}
