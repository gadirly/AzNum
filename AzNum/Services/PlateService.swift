//
//  NumService.swift
//  AzNum
//
//  Created by Babek Gadirli on 26.10.23.
//

import Firebase

enum PlateError: Error {
    case PlateFailed
    
}

class PlateService {
    static let shared = PlateService()
    let database = Database.database().reference()
    
    func addCarPlateItem(_ item: CarPlate, forUser userID: String, completion: @escaping (Error?) -> Void) {
        let itemRef = database.child("car_plate_items").childByAutoId()
        let itemData = item.toDictionary()
        
       
        
        itemRef.setValue(itemData) { (error, _) in
            completion(error)
        }
    }
    
    
    
    func fetchAllCarPlates(completion: @escaping (Result<[CarPlate], Error>) -> Void) {
        
        let query = PLATE_REF
        
        query.observeSingleEvent(of: .value) { snapshot in
            
            guard let dataSnapshot = snapshot.value as? [String: [String: Any]] else {
                completion(.failure(PlateError.PlateFailed))
                return
            }
            
            var carPlates: [CarPlate] = []
            
            for (key, value) in dataSnapshot {
                let plate = CarPlate(id: key, dict: value)
                carPlates.append(plate)
            }
            
            completion(.success(carPlates))
        }
    }
    
    
    func searchItems(plateSeries: String, plateFirstChar: String, plateSecondChar: String, plateEnding: String, completion: @escaping (Result<[CarPlate], Error>) -> Void) {
        
        PLATE_REF.observeSingleEvent(of: .value) { snapshot in
            var results: [CarPlate] = []
            
            guard let dataSnapshot = snapshot.value as? [String: [String: Any]] else {
                completion(.failure(PlateError.PlateFailed))
                return
            }
            
            
            for (key, value) in dataSnapshot {

                if !plateSeries.isEmpty, let itemSeries = value["plateSeries"] as? String, plateSeries != itemSeries {
                    continue
                }
                    
                if !plateFirstChar.isEmpty, let itemFirstChar = value["plateFirstChar"] as? String, plateFirstChar != itemFirstChar {
                    continue
                }
                if !plateSecondChar.isEmpty, let itemSecondChar = value["plateSecondChar"] as? String, plateSecondChar != itemSecondChar {
                    continue
                }
                if !plateEnding.isEmpty, let itemEnding = value["plateEnding"] as? String, plateEnding != itemEnding {
                    continue
                }
                let plate = CarPlate(id: key, dict: value)
                results.append(plate)
            }
            
            completion(.success(results))
        }
    }
    
    func addToFavorites(userID: String, itemID: String, completion: @escaping (Bool) -> Void) {
        USER_REF.child(userID).child("favorites").child(itemID).setValue(true) { (error, _) in
            if let error = error {
                print("Error adding to favorites: \(error.localizedDescription)")
                completion(false)
            } else {
                print("Added to favorites successfully!")
                completion(true)
            }
        }
    }
    
    func removeFromFavorites(userID: String, itemID: String, completion: @escaping (Bool) -> Void) {
    
        USER_REF.child(userID).child("favorites").child(itemID).removeValue { (error, _) in
            if let error = error {
                print("Error removing from favorites: \(error.localizedDescription)")
                completion(false)
            } else {
                print("Removed from favorites successfully!")
                completion(true)
            }
        }
    }

    

    func getFavorites(userID: String, completion: @escaping ([String]) -> Void) {
        let favoritesRef = USER_REF.child(userID).child("favorites")
        
        favoritesRef.observeSingleEvent(of: .value) { snapshot in
            guard let snapshotValue = snapshot.value as? [String: Any] else {
                completion([])
                return
            }
            
            let favoriteIDs = snapshotValue.keys.map { $0 }
            completion(favoriteIDs)
        }
    }

    
    func fetchFavoriteCarPlates(forUserID userID: String, completion: @escaping (Result<[CarPlate], Error>) -> Void) {
        
        getFavorites(userID: userID) { favoriteIDs in
            let query = PLATE_REF
            
            query.observeSingleEvent(of: .value) { snapshot in
                guard let dataSnapshot = snapshot.value as? [String: [String: Any]] else {
                    completion(.failure(PlateError.PlateFailed))
                    return
                }
                
                var carPlates: [CarPlate] = []
                
                for (key, value) in dataSnapshot {
                    
                    if favoriteIDs.contains(key) {
                        let plate = CarPlate(id: key, dict: value)
                        carPlates.append(plate)
                    }
                }
                
                
                completion(.success(carPlates))
            }
        }
    }
    
    func checkIfIsFavorite(itemID: String, userID: String, completion: @escaping (Bool) -> ()) {
        let favoritesRef = USER_REF.child(userID).child("favorites").child(itemID)
        
        favoritesRef.observeSingleEvent(of: .value) { snapshot in
            if snapshot.exists() {
                completion(true)
            } else {
                completion(false)
            }
            
        }
    }
    
    func getRelatedPlates(plateEnding: String, completion: @escaping (Result<[CarPlate], Error>) -> Void) {
        let query = PLATE_REF.queryOrdered(byChild: "plateEnding").queryEqual(toValue: plateEnding)
        
        query.observeSingleEvent(of: .value) { snapshot in
            
            guard let dataSnapshot = snapshot.value as? [String: [String: Any]] else {
                completion(.failure(PlateError.PlateFailed))
                return
            }
            
            var carPlates: [CarPlate] = []
            
            for (key, value) in dataSnapshot {
                let plate = CarPlate(id: key, dict: value)
                carPlates.append(plate)
            }
            
            completion(.success(carPlates))
        }
    }

}


