//
//  AboutViewController.swift
//  H2O
//
//  Created by Scott Simon & Matthew Mola on 4/20/18.
//  Copyright © 2018 Scott Simon. All rights reserved.
//


import UIKit

class AboutViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // attempting to create an animate image using an array of different colored images
        var imagesNames = ["h2o_blue1","h2o_blue2","h2o_blue3","h2o_blue5","h2o_blue6",
                           "h2o_blue8","h2o_blue9","h2o_blue7","h2o_blue4"]
        
        var images = [UIImage]()
        
        for i in 0..<imagesNames.count{
            images.append(UIImage(named:imagesNames[i])!)
        }
        
        imageView.animationImages = images
        imageView.animationDuration = 2.00
        imageView.startAnimating()
        
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

