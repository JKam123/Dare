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
    
    func addLocation(Loc: Location){
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
    
        
}
