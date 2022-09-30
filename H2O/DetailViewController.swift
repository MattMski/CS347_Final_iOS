//
//  DetailViewController.swift
//  new
//
//  Created by Scott Simon on 4/20/18.
//  Copyright © 2018 Scott Simon. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var getImage = UIImage()
    
    
    @IBOutlet weak var imgImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //imgImage.image = getImage
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
