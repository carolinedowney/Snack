//
//  Spots.swift
//  Snacktacular
//
//  Created by Caroline Downey on 11/1/18.
//  Copyright © 2018 John Gallaugher. All rights reserved.
//

import Foundation
import Firebase

class Spots {
    var spotArray = [Spot]()
    var db: Firestore!
    
    init() {
        db = Firestore.firestore()
    }
    
    func loadData(completed: @escaping () -> ()) {
        db.collection("spots").addSnapshotListener { (QuerySnapshot, error) in
            guard error == nil else {
                print("error")
                return completed()
            }
            self.spotArray = []
            for document in QuerySnapshot!.documents {
                let spot = Spot(dictionary: document.data())
                spot.documentID = document.documentID
                self.spotArray.append(spot)
            }
            completed()
            
        }
    }
    
}
