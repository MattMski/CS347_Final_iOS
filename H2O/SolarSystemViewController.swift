//
//  SolarSystemViewController.swift
//  H2O
//
//  Created by Scott Simon on 4/19/18.
//  Copyright © 2018 neiu.edu. All rights reserved.
//
//
import UIKit

class SolarSystemViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    //let elements = ["sun","mercury","venus","earth","neptune","mars","jupiter","saturn","uranus"]
    
    // initialize array
    var planets = [Planet]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Title for navigation
        self.title = "The Solar System"
        
        //add array elements for selection
        let sun = Planet(name: "sun",
                         fact1: "Distance to Earth: 92.96 million miles",
                         fact2: "The Sun is the star at the center of the Solar System.",
                         url: "https://space-facts.com/the-sun/")
        planets.append(sun)
        let mercury = Planet(name: "mercury",
                             fact1: "18 Mercuries would fit into the Earth.",
                             fact2: "Mercury is closest to the sun.",
                             url: "https://space-facts.com/mercury/")
        planets.append(mercury)
        let venus = Planet(name: "venus",
                           fact1: "Venus - named after the Roman goddess of beauty.",
                           fact2: "Also known as the evening or morning star.",
                           url: "https://space-facts.com/venus/")
        planets.append(venus)
        let earth = Planet(name: "earth",
                           fact1: "Earth is the fifth largest planet of our solar system.",
                           fact2: "All planets were named after Roman and Greek gods and goddesses, except the Earth. ",
                           url: "https://space-facts.com/earth/")
        planets.append(earth)
        let mars = Planet(name: "mars",
                          fact1: "Mars, the most likely candidate for a future human habitat.",
                          fact2: "Has huge storms that occur every now and then and cover the entire planet.",
                          url: "https://space-facts.com/mars/")
        planets.append(mars)
        let jupiter = Planet(name: "jupiter",
                             fact1: "Jupiter has some of the largest moons in the Solar System.",
                             fact2: "There is one spacecraft currently orbiting Jupiter called Juno.",
                             url: "https://space-facts.com/jupiter/")
        planets.append(jupiter)
        let saturn = Planet(name: "saturn",
                            fact1: "Saturn is the second largest planet and is known for its rings.",
                            fact2: "Saturn is a gas giant just like Jupiter, Neptune and Uranus.",
                            url: "https://space-facts.com/saturn/")
        planets.append(saturn)
        let uranus = Planet(name: "uranus",
                            fact1: "Uranus orbits on its side, which means that its seasons are completely different to ours.",
                            fact2: "Summer and winter each take 21 years at the north and south poles.",
                            url: "https://space-facts.com/uranus/")
        planets.append(uranus)
        let neptune = Planet(name: "neptune",
                             fact1: "Neptune is the farthest planet from the sun.",
                             fact2: "It takes 165 years for Neptune to go once around the Sun.",
                             url: "https://space-facts.com/neptune/")
        planets.append(neptune)
        
        tableView.delegate=self
        tableView.dataSource=self
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return planets.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as! CustomTableViewCell
        
        // make a nice round border to hug the planets
        cell.cellView.layer.cornerRadius = cell.cellView.frame.height / 2
        
        //Format the name of the planets
        cell.lbl.text = planets[indexPath.row].name.capitalized
        
        // Use the "sm" version of the image as a thumbnail
        cell.img.image = UIImage(named: planets[indexPath.row].name+"sm")
        cell.img.layer.cornerRadius = cell.img.frame.width / 2 + 2
        cell.img.clipsToBounds = true
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? PlanetViewController{
            
            // select the planet from the table and display the PlanetViewController
            destination.planet = planets[(tableView.indexPathForSelectedRow?.row)!]
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
