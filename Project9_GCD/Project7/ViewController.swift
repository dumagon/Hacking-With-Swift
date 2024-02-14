

// Day 39
// GCD : Grand Central Dispatch ( multitasking , locking etc)

// postulate 1
// your user interface must execute on the main thread (initial thread ) otherwise it might crash at any moment
// postulate 2
// you have no control over threads' order of execution , the system handles them on its own




import UIKit

class ViewController: UITableViewController {
    
    var petitions = [Petition]()
    var errorDidAppeared = false
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // creating controls
        
        let credits = UIBarButtonItem(title: "Credits", style: .plain, target: self, action: #selector(creditsButtonTapped))

        navigationItem.rightBarButtonItem = credits
        
        let sort = UIBarButtonItem(title: "Sort", style: .plain, target: self, action: #selector(filterPetitions))
        
        navigationItem.leftBarButtonItem = sort
        
        // main logic function
        
       loadPetitions()
            

  
    }
    
    
    
    
    
    
    
    
    
    // ******** UITableViewController native functions ******
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if errorDidAppeared { return 1}
        return petitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        if errorDidAppeared {
            cell.textLabel?.text = " no connection"
            cell.detailTextLabel?.text = " no data available"
        }else {
            let petition = petitions[indexPath.row]
            cell.textLabel?.text = petition.title
            cell.detailTextLabel?.text = petition.body
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ReadMoreViewController()
        vc.detailedItem = petitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true  )
    }
    
    
    
    
    
    
    
    
    
   // ***********  Main logic functions ***********
    
    private func loadPetitions(){
        
        
        let urlString: String
        
        if navigationController?.tabBarItem.tag == 0 {
            
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
            
           /*
             the official website link (no longer valid)
             urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
            
             accessing a local file with the "file:///Full/path/to/file.file " form !
             urlString = "file:///Users/zach/Desktop/Swift projects/Project7_Petitions/mypetition.json"
             urlString = "file:///Users/zach/Desktop/Swift projects/Project7_Petitions/Project7/testJson.json"
            */
            
        }else{
            
                urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
           
         
        }
        
        /* 
         DispatchQueue.global(qos: .userInitiated)
         that's how you specify a QoS ( Quality of Service)
         which is the priority of a task you are sending in the queue
         using a default queue to put the data loading off the main thread
        */
        
        DispatchQueue.global().async {
            
            if let url = URL(string: urlString){
                if let data = try? Data(contentsOf: url){
                    self.parse(json: data)
                    return
                }
            }
            
            self.showError()
       }
       
       
       
        
    }
    
    
    func parse(json:Data){
        let decoder = JSONDecoder()
        
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json){
            petitions = jsonPetitions.results
    
    // getting back onto the main thread to update user interface
            
            DispatchQueue.main.async {
                
                self.tableView.reloadData()
            }
            
        }
    }

    func showError(){
        
        // as user interface MUST BE updated only on the MAIN THREAD  we have to send it back to the main thread

        DispatchQueue.main.async {
        
            self.errorDidAppeared = true
            let ac = UIAlertController(title: "Loading error", message: "Cannot load data , check your connection", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Ok", style: .default))
            self.present(ac,animated: true)
            self.tableView.reloadData()
        }
        
    }
    
    
    
    
    
    
    // ****** Controls logic functions *******
    
    // Credits
    
    @objc func creditsButtonTapped(){
        
        let ac = UIAlertController(title: nil , message: "the source data at We The People API whitehouse.gov is no longer available", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "cancel", style: .cancel))
        present(ac,animated: true)
        
    }
    
   // Sort
    
    @objc func filterPetitions(){
        
        let ac = UIAlertController(title: nil, message: "filter petitions by a word or phrase", preferredStyle: .alert)
        ac.addTextField()
        let submit = UIAlertAction(title: "submit", style: .default){ [weak ac ,weak self] action in
        
            if let textToFilterBy = ac?.textFields?[0].text {
                self?.filter(textToFilterBy)
            }
        }
        
        let refresh = UIAlertAction(title: "go back", style: .default){ [weak self] action in
            
            self?.loadPetitions()
        }
        
        ac.addAction(submit)
        ac.addAction(refresh)
        present(ac,animated: true)
        
    }
    
    // Used by the function above 
    
    private func filter(_ content:String){
        
        var filteredPetitions = [Petition]()
        
        let sequence = content.lowercased()
        
        for petition in petitions {
            if petition.body.lowercased().contains(sequence) || petition.title.lowercased().contains(sequence){
                filteredPetitions.append(petition)
            }
        }
        
        if !filteredPetitions.isEmpty{
            
            petitions = filteredPetitions
            tableView.reloadData()
            
        }
        
    }

}
