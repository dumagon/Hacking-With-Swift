// //  StatesTableViewController.swift
//  States
//
//  Created by Zach Nazarov on 05/01/2024.
//

import UIKit

class StatesTableViewController: UITableViewController {

    var statesOfAmerica = [String]()
    var statesAbbriviated = [String]()
    var typedStatesOfAmerica = [String]()
    var currentAbbr = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "UNITED STATES OF AMERICA"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(typeInState))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(startOver))
        
        
        if let statesURL = Bundle.main.url(forResource: "states", withExtension: "txt"){
            if let states = try? String.init(contentsOf: statesURL){
                statesOfAmerica = states.components(separatedBy: "\n")
               
               
                
            }
        }
        
        if let abbriviatedURL = Bundle.main.url(forResource: "Abbr", withExtension: "txt"){
            if let abbriviations = try? String.init(contentsOf: abbriviatedURL){
                statesAbbriviated = abbriviations.components(separatedBy: "\n")
                
            }
        }

      
    }
    
    @objc func typeInState(){
        let ac = UIAlertController(title: "Type in the name of a state ", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "submit", style: .default){ [weak self,weak ac] action in
            guard let nameOfState = ac?.textFields?[0].text else { return }
            self?.submit(nameOfState)
        }
        ac.addAction(submitAction)
        present(ac,animated: true)
    }
    
    @objc func startOver(){
        typedStatesOfAmerica.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    
    func submit(_ state:String){
        
        let nameOfState = state.lowercased()
        
        if isValid(nameOfState){
            if isOriginal(nameOfState){
                typedStatesOfAmerica.insert(nameOfState, at: 0)
                let indexPath = IndexPath(row: 0, section: 0)
                tableView.insertRows(at: [indexPath], with: .automatic)
                return
            }
        }
        
        
        
        
        
    }
    
    func isOriginal(_ name:String) -> Bool {
       
        
        for entry in typedStatesOfAmerica {
            if entry == name {return false}
        }
        return true
    }
    
    func isValid(_ name:String) -> Bool {
  
        
        for entry in statesOfAmerica {
            if name == entry {
                guard let abbrIndex = statesOfAmerica.firstIndex(of: entry) else {return true}
                currentAbbr = statesAbbriviated[abbrIndex]
                return true}
        }
        return false
    }




    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return typedStatesOfAmerica.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "State", for: indexPath)
//        cell.textLabel?.text = " \(typedStatesOfAmerica[indexPath.row]) postal \(statesAbbriviated[indexPath.row])"
        cell.textLabel?.text = "\(typedStatesOfAmerica[indexPath.row].capitalized)  \(currentAbbr)"
        return cell
    }


}
