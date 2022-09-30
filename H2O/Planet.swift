//
//  Planet.swift
//  H2O
//
//  Created by Scott Simon on 4/19/18.
//  Copyright © 2018 neiu.edu. All rights reserved.
//

import UIKit

// initialize the array variables to be used in the SolarSystem and Planet View Controllers
class Planet{
    var name: String
    var fact1: String
    var fact2: String
    var url: String
    var image: UIImage
    var imageSM: UIImage
    
    init(name: String, fact1: String, fact2: String, url: String){
        self.name = name
        self.fact1 = fact1
        self.fact2 = fact2
        self.url = url
        
        image = UIImage(named: self.name)!
        imageSM = UIImage(named: self.name + "sm")!
    }
    
}

//class Images{
//    var identities: String
//    var image: UIImage
//    
//    init(identities: String){
//        self.identities = identities
//        image = UIImage(named: self.identities)!
//       
//    }
//    
//}




