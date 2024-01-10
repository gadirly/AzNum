//
//  PlateViewModel.swift
//  AzNum
//
//  Created by Babek Gadirli on 30.10.23.
//

import Foundation
import Firebase

class PlateViewModel {
    
    var items: [CarPlate] = [CarPlate]()
    var uid = Auth.auth().currentUser?.uid ?? ""
    
    func addCarPlate(plateItem: CarPlate, completion: @escaping () -> ()) {
        PlateService.shared.addCarPlateItem(plateItem, forUser: uid) { error in
            if let error {
                print(error)
                return
            }
            completion()
        }
    }
    
    func fetchAllItems(completion: @escaping () -> Void) {
        PlateService.shared.fetchAllCarPlates { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let results):
                
                self.items = results
                self.items.sort { $0.id > $1.id }
                completion()
            case .failure(let error):
                print("DEBUG: Failed to get all items from firebase \(error)")
                completion()
            }
        }
        
    }
    
    func searchItems(plateSeries: String, plateFirstChar: String, plateSecondChar: String, plateEnding: String, completion: @escaping () -> Void) {
        
        PlateService.shared.searchItems(plateSeries: plateSeries, plateFirstChar: plateFirstChar, plateSecondChar: plateSecondChar, plateEnding: plateEnding) { [weak self] result in
            
            guard let self = self else {
                return
            }
            
            switch result {
            case .success(let plates):
                self.items = plates
                completion()
            case .failure(let error):
                print(error)
                completion()
            }
        }
    }
    
    
    func addToFavorites(itemID: String, completion: @escaping (Bool) -> Void) {
        PlateService.shared.addToFavorites(userID: uid, itemID: itemID, completion: completion)
    }
    
    func removeFromFavorites(itemID: String, completion: @escaping (Bool) -> Void) {
        PlateService.shared.removeFromFavorites(userID: uid, itemID: itemID, completion: completion)
    }
    
    func getFavorites(completion: @escaping () -> Void) {
        PlateService.shared.fetchFavoriteCarPlates(forUserID: uid) { [weak self] result in
            
            guard let self = self else {
                return
            }
            
            switch result {
            case .success(let plates):
                self.items = plates
                self.items.sort { $0.id > $1.id }
                
                completion()
            case .failure(let error):
                print(error)
                completion()
            }
        }
    }
    
    func checkIfIsFavorite(itemID: String, completion: @escaping (Bool) -> ()) {
        PlateService.shared.checkIfIsFavorite(itemID: itemID, userID: uid, completion: completion)
    }
    
    func getRelatedPlates(plate: CarPlate, completion: @escaping () -> ()) {
        PlateService.shared.getRelatedPlates(plateEnding: plate.plateEnding) { [weak self] result in
            
            guard let self = self else {
                return
            }
            
            switch result {
            case .success(let plates):
                let filteredPlates = plates.filter { $0.id != plate.id }
                print(filteredPlates)
                self.items = filteredPlates
                completion()
            case .failure(let error):
                print(error)
                completion()
            }
        }
    }
}
