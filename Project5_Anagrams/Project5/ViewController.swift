

import UIKit

class ViewController: UITableViewController  {

    var words = [String]()
    var usedWords = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))
       
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(startGame))
    

            
 // calling the main logic function
        startGame()

    }
    
    
    
    
    
    
// *********  UITableViewController native methods ***********
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        usedWords.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
        cell.textLabel?.text = usedWords[indexPath.row]
        return cell
    }
  
    
   
    
    
    
    
// ********** Main logic methods **********
    
    
  @objc func startGame(){
      
  // reading data from a text file and writing into a string
  // filling up an array 'words'
              
         if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt"){
              if let startWords = try? String(contentsOf: startWordsURL){
                  words = startWords.components(separatedBy: "\n")
              }
          }
              if words.isEmpty { words = ["silkworm"] }
      
        title = words.randomElement()
        usedWords.removeAll(keepingCapacity: true)
        tableView.reloadData()
        
    }
    
    
    
    
// ********** Controls functions ******************
  

    
// The function is called to provied a text field for a user's input
    
    @objc func promptForAnswer(){

        let popUpWindow = UIAlertController(title: "Enter answer", message: nil, preferredStyle: .alert)
        popUpWindow.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default){ [weak self , weak popUpWindow ] action in
            
            guard let answer = popUpWindow?.textFields?[0].text else {return}
            self?.submit(answer)
        }
        
        popUpWindow.addAction(submitAction)
        present(popUpWindow,animated: true)
    }
    
    
 
// The function is called by the promtForAnswer() and contains the core logic
    
  private  func submit(_ answer:String){

        let lowerAnswer = answer.lowercased()
        let errorTitle:String
        let errorMessage:String
    
        if isWordPossible(lowerAnswer){
            if isWordOriginal(lowerAnswer){
                if isWordReal(lowerAnswer){
                    
                    usedWords.insert(lowerAnswer, at: 0)
                    let indexPath = IndexPath(row: 0, section: 0)
                    tableView.insertRows(at: [indexPath], with: .automatic)
                    return
                }else{
                    errorTitle = " \(lowerAnswer) isn't a real word or is too short"
                    errorMessage = "try something else"
                    showErrorMessage(title: errorTitle, message: errorMessage)
                }
                
            }else{
                errorTitle = " \(lowerAnswer) was already used or is the original word  "
                errorMessage = " type in something original "
                showErrorMessage(title: errorTitle, message: errorMessage)
            }
        }else{
            guard let title = title?.lowercased() else{return}
            errorTitle = "not possible"
            errorMessage = "you can't spell \(lowerAnswer) from \(title)"
            showErrorMessage(title: errorTitle, message: errorMessage)
            
        }
    }
    
 
    
// The function is called by  submit() if the input does not meet one or several conditions
    
    func showErrorMessage(title:String,message:String){
        
        let ac = UIAlertController(title: title , message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac,animated: true)
    }

 
// The three fuctions below are called by submit() to perform a condition check on the input
    
    
    
// returns true if the anagram can be made out of a word provided
    
    func isWordPossible(_ word:String)->Bool{
        guard var tempWord = title?.lowercased() else {return false}
        
                for letter in word {
                    
                    if let position = tempWord.firstIndex(of: letter) {
                        tempWord.remove(at: position)
                    }else{ return false }
                }
            return true
        }
    
// returns true if the anagram has not been used before
    
    func isWordOriginal(_ word:String)->Bool{
        let originalWord = title?.lowercased()
        return !usedWords.contains(word) && word != originalWord
    }
    
    
// checks if the anagram is a real word
    
    
    func isWordReal(_ word:String)->Bool{
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
       // if word.count <= 3 { return false }

        return misspelledRange.location == NSNotFound
    }
}


