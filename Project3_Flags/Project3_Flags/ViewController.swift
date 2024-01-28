

import UIKit

class ViewController: UITableViewController {
    
    var countries = [String]()
    var cellHeight = 50.0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        cellHeight = view.frame.height * 0.06
                
        title = "Flagship"
        
        countries += [ "estonia", "france", "germany",
                       "ireland", "italy", "monaco",
                       "nigeria", "poland", "russia",
                       "spain", "uk", "us" ]
      

    }
    
    
  

}




extension  ViewController {
    
    
    
// ******** overriding tableview methods **********
    
    // setting a number of cells
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    // initializing a reusable cell
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Flag", for: indexPath)
        
       //  a tableView cell can contain images alongside with labels
        cell.imageView?.image = UIImage(named: countries[indexPath.row])
        let image = UIImage(named: countries[indexPath.row])
        
        // drawing a border line around the image
        cell.imageView?.layer.borderWidth = 0.2
        cell.imageView?.layer.borderColor = UIColor.black.cgColor
    
        
        
        // if not initialized the default label will be ' Title ' so we assign nil to it
        cell.textLabel?.text = countries[indexPath.row].capitalized
        // setting a cell's height manually
        cell.heightAnchor.constraint(equalToConstant: cellHeight).isActive = true
        cell.backgroundColor = view.backgroundColor
 
        return cell

    }
    // this fuction is called when a cell gets tapped (clicked)
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // extracting a detail view from the storyboard and typecasting into the desirable ViewController
        if let fc = storyboard?.instantiateViewController(identifier: "FlagView") as? FlagViewController {
            fc.flagImage = UIImage(named: countries[indexPath.row])
            fc.flagTitleString = countries[indexPath.row].uppercased()
            // push the extracted ViewController on top of the views' stack in the  NavigationController
            navigationController?.pushViewController(fc, animated: true)
        }
    }
    
}

