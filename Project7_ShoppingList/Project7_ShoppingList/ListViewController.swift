

import UIKit

class ListViewController: UITableViewController {

    
    
    var itemsToShop = [String]()
    var itemsCount = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItemToShop))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(clearShoppingList))
        
        
        title = " Shopping list "
        
        
    }
    
    
    
    
    
// ******** UITableViewController native methods *******
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return itemsToShop.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Item", for: indexPath)
        cell.textLabel?.text = itemsToShop[indexPath.row]
        return cell
        
    }
    
    
        
    
    
// ********** Controls methods ************
    
    
 // this method gets triggered by the "add" button
    
    @objc func addItemToShop(){
        
        var message = ""
        
        if itemsCount == 0 {
            message = "Let's start shopping ! Type in an item you want to add to the list ."
        }else{
            message = "Type in an item you want to add to the list"
        }
        
        
        let ac = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        ac.addTextField()
        
        // creates an action button that adds items to a list
        
        let add = UIAlertAction(title: "add", style: .default){  [weak self ,weak ac] action in
            guard let itemToAdd = ac?.textFields?[0].text  else{return}
            self?.addToList(itemToAdd)
        }
        
        ac.addAction(add)
        ac.addAction(UIAlertAction(title: "cancel", style: .cancel))
        present(ac,animated: true)
        
        itemsCount += 1
        
    }
    
// Used by the addItemToShop() function
    
    private func addToList(_ item:String){
        itemsToShop.insert(item.lowercased(), at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
        
    }
  
// Triggered by the "clear" button
    
    @objc func clearShoppingList(){
        
        itemsToShop.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }


}
