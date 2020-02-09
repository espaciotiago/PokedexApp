//
//  Extensions.swift
//  PokedexApp
//
//  Created by Tiago Moreno on 8/02/20.
//  Copyright © 2020 Tiago Moreno. All rights reserved.
//

import UIKit

//----------------------------------------------------
// UIViewController
//----------------------------------------------------
extension UIViewController{
    
    private struct Holder {
        static var _searchBar = UISearchController(searchResultsController: nil)
    }
    
    var searchController:UISearchController {
        get {
            return Holder._searchBar
        }
        set(newValue) {
            Holder._searchBar = newValue
        }
    }
    
    func setupNavBar(){
        searchController.obscuresBackgroundDuringPresentation = false
        self.navigationItem.searchController = searchController
    }
}
//----------------------------------------------------
// String
//----------------------------------------------------
extension String {
    func capitalizingFirstLetter() -> String {
      return prefix(1).uppercased() + self.lowercased().dropFirst()
    }

    mutating func capitalizeFirstLetter() {
      self = self.capitalizingFirstLetter()
    }
}
//----------------------------------------------------
// Color
//----------------------------------------------------
extension UIColor {
    
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }

   convenience init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
}
