//
//  File.swift
//  weekomp
//
//  Created by Ada 2018 on 02/10/2018.
//  Copyright © 2018 Academy. All rights reserved.
//

import Foundation


class ManagerFavorite: NSObject {
    
    class func saving(favoriteName nomeTalk: String) {
        guard var favorites = UserDefaults.standard.array(forKey: "Favorites") as? [String] else {
            UserDefaults.standard.set([nomeTalk], forKey: "Favorites")
            return
        }
        if !(favorites.contains(nomeTalk)) {
            favorites.append(nomeTalk)
            UserDefaults.standard.set(favorites, forKey: "Favorites")
        }
        
    }
    
    class func removing(favoriteName nomeTalk: String) {
        guard var favorites = UserDefaults.standard.array(forKey: "Favorites") as? [String] else {return}
        if (favorites.contains(nomeTalk)) {
            let removedIndex = favorites.index(of: nomeTalk)
            favorites.remove(at: removedIndex!)
        }
        print(favorites)
        UserDefaults.standard.set(favorites, forKey: "Favorites")
        
    }
    
    class func isFavorite(name: String) -> Bool{
        guard let favorites = UserDefaults.standard.array(forKey: "Favorites") as? [String] else {return false}
        print(favorites)
        let aux = favorites.filter({ (talkName) -> Bool in
            return talkName == name
        })
        return !aux.isEmpty
    }
    
}
