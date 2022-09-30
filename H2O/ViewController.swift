//
//  ViewController.swift
//  H2O
//
//  Created by Scott Simon & Matthew Mola on 4/20/18.
//  Copyright © 2018 Scott Simon. All rights reserved.
//

import UIKit

/* This function / extension will generate a random RGB color */
func randomCGFloat() -> CGFloat {
    return CGFloat(arc4random()) / CGFloat(UInt32.max)}

extension UIColor {
    static func randomColor() -> UIColor {
        let r = randomCGFloat()
        let g = randomCGFloat()
        let b = randomCGFloat()
        
        // If you want a random alpha, just create another
        // random number for that too.
        return UIColor(red: r, green: g, blue: b, alpha: 1.0)
    }
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // Home View Controller is actually a table view (of images)
    // so entries can be modified dynamically by updating the image and identities array */
    var imgArray:NSArray =  []
    var identities = [String]()
    //identities are used for segue ids
    
    //variables for the slide menu
    @IBOutlet weak var viewConstraint: NSLayoutConstraint!
    @IBOutlet weak var blurView: UIVisualEffectView!
    @IBOutlet weak var sideView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.randomColor()
        
        //image names must match what is imported into assets
        imgArray = [UIImage(named: "math_view")!,UIImage(named: "solarsystem_view")!,UIImage(named: "sightwords_view")!,UIImage(named: "reading_view")!,UIImage(named: "science_view")!]
        identities = ["math","solarsystem","sightwords","reading", "science"]
        
        //set the slide menu constants
        blurView.layer.cornerRadius = 15
        sideView.layer.shadowColor = UIColor.black.cgColor
        sideView.layer.shadowOpacity = 1.0
        sideView.layer.shadowOffset = CGSize(width: 5, height: 0)
        viewConstraint.constant = -200
    }
    
    // Using a swipe / pan gesture to have the slide menu appear / disappear
    @IBAction func panPerformed(_ sender: UIPanGestureRecognizer) {
        
        if sender.state == .began || sender.state == .changed {
            let translation = sender.translation(in: self.view).x
            
            if translation > 0 {
                //swiped to the right
                if viewConstraint.constant < 1 {
                    UIView.animate(withDuration: 0.2, animations: {
                        self.viewConstraint.constant += translation / 3
                        self.view.layoutIfNeeded()
                        
                    })
                }
            }
            else {
                //swiped to the left
                if viewConstraint.constant > -200 {
                    UIView.animate(withDuration: 0.2, animations: {
                        self.viewConstraint.constant += translation / 13
                        self.view.layoutIfNeeded()
                        
                    })
                }
            }
        }
        else if sender.state == .ended {
            if viewConstraint.constant < -100 {
                UIView.animate(withDuration: 0.2, animations: {
                    self.viewConstraint.constant = -200
                    self.view.layoutIfNeeded()
                    
                })
            }
            else {
                UIView.animate(withDuration: 0.2, animations: {
                    self.viewConstraint.constant = 0
                    self.view.layoutIfNeeded()
                })
            }
        }
    }
    
    // to hide the slide menu by clicking on it vs. swiping
    @IBAction func tapClose(_ sender: Any) {
        UIView.animate(withDuration: 0.2, animations: {
            self.viewConstraint.constant = -200
            self.view.layoutIfNeeded()
            
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // show the contents from the image array
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imgArray.count
    }
    
    // called to hide the menu if it is viewable when performing segue
    func hideSide() {
        UIView.animate(withDuration: 0.2, animations: {
            self.viewConstraint.constant = -200
            self.view.layoutIfNeeded()
        })
    }
    
    // each cell will have a different background color
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as! TableViewCell
        cell.imgImage.image = imgArray[indexPath.row] as? UIImage
        cell.backgroundColor = UIColor.randomColor()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if UIDevice.current.orientation.isLandscape {
            //print("landscape")
            return 125.0;  //Choose your custom row height
        } else {
            //print("portrait")
            return 150.0;  //A little larger row height for portrait
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // segue
        let vcName = identities[indexPath.row]
        let viewController = storyboard?.instantiateViewController(withIdentifier: vcName)
        
        self.navigationController?.pushViewController(viewController!, animated: true)
        
        let cell = tableView.cellForRow(at: indexPath) as! TableViewCell
        
        // change the cell color after the view has been transitioned
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25, execute: {
            cell.backgroundColor = UIColor.randomColor()
            
            // close the menu just in case the menu is open but the table cell was clicked
            self.hideSide()
           
        })
    }
}

