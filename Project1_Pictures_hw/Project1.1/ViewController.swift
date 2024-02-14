//
//  ViewController.swift
//  Project1
//
//  Created by Zach Nazarov on 29/10/2023.
// Home work for Day 39 GCD
// added code is marked with $$$

import UIKit

class ViewController: UITableViewController {
    
    var pictures = [String]()
    
    override func viewDidLoad() {
       super.viewDidLoad()
        
        title = "Storm viewer "
        navigationController?.navigationBar.prefersLargeTitles = true
        
       // $$$
        
        DispatchQueue.global().async {
            
            let fm = FileManager.default
            let path = Bundle.main.resourcePath!
            let items = try! fm.contentsOfDirectory(atPath: path)
            
            for item in items {
                if item.hasPrefix("nssl"){
                    self.pictures.append(item)
                }
                self.pictures = self.pictures.sorted()
            }
            // $$$
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            
            vc.selectedImage = pictures[indexPath.row]
            vc.imageTitle = "Picture \((indexPath.row)+1) of \(pictures.count)"
        
            
            navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
}

    
