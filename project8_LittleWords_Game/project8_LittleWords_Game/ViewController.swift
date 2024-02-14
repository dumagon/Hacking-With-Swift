
// Day 38


import UIKit

class ViewController: UIViewController {

    // interface elements
    
    var cluesLabel:UILabel!
    var answersLabel:UILabel!
    var currentAnswer:UITextField!
    var scoreLabel:UILabel!
    var letterButtons = [UIButton]()
    
    // creating arrays to keep temporary letter buttons
    
    var activatedButtons = [UIButton]()
    var solutions = [String]()
    
    // initializing two variables that will hold a score and level
    
    var successfulAnswers = 0
    
    var score = 0 {
        didSet{
            
            scoreLabel.text = "Score: \(score)"
        }
    }
    var level = 1
    

    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        
        // setting up  the score label
    
        scoreLabel = UILabel()
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.textAlignment = .right
        scoreLabel.text = "Score:0"
        view.addSubview(scoreLabel)
        
        // setting up the clues label
        
        cluesLabel = UILabel()
        cluesLabel.translatesAutoresizingMaskIntoConstraints = false
        cluesLabel.font = UIFont.systemFont(ofSize: 24)
        cluesLabel.textColor = .darkGray
        cluesLabel.numberOfLines = 0
        cluesLabel.text = "CLUES"
        view.addSubview(cluesLabel)
        
        //setting up the answers label
        
        answersLabel = UILabel()
        answersLabel.translatesAutoresizingMaskIntoConstraints = false
        answersLabel.font = UIFont.systemFont(ofSize: 24)
        answersLabel.textColor = .darkGray
        answersLabel.numberOfLines = 0
        answersLabel.text = "ANSWERS"
        answersLabel.textAlignment = .right
        view.addSubview(answersLabel)
        
        // giving the answers and clues a content hugging (stretching ) priority
        // the small the value the more likely a view will be stretched to satisfy AuotoLayout constraints
        
        cluesLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        answersLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        
        // setting up the text field ( input box)
        
        currentAnswer = UITextField()
        currentAnswer.translatesAutoresizingMaskIntoConstraints = false
        currentAnswer.font = UIFont.systemFont(ofSize: 44)
        currentAnswer.placeholder = "Tap letters to fill in "
        currentAnswer.textAlignment = .center
        currentAnswer.isUserInteractionEnabled = false
        view.addSubview(currentAnswer)
        
        // creating buttons
        
        // "submit"
        
        let submit = UIButton(type: .system)
        submit.translatesAutoresizingMaskIntoConstraints = false
        submit.setTitle("SUBMIT", for: .normal)
        submit.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)
        view.addSubview(submit)
        
        // clear
        
        let clear = UIButton(type: .system)
        clear.translatesAutoresizingMaskIntoConstraints = false
        clear.setTitle("CLEAR", for: .normal)
        clear.addTarget(self, action: #selector(clearTapped), for: .touchUpInside)
        view.addSubview(clear)
        
        // creating a subview that will host multiple letter buttons
        
        let buttonsView = UIView()
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonsView)
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        // introducing constraints
        
        // this structure comes in handy when we need to activate many constraints all at once
        
        NSLayoutConstraint.activate([
        
            scoreLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            scoreLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            cluesLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor),
            cluesLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 100),
            cluesLabel.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.6, constant: -100),
            answersLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor),
            answersLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor,constant: -100),
            answersLabel.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor,multiplier: 0.4,constant: -100),
            answersLabel.heightAnchor.constraint(equalTo: cluesLabel.heightAnchor),
            currentAnswer.topAnchor.constraint(equalTo: cluesLabel.bottomAnchor,constant: 20),
            currentAnswer.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            currentAnswer.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor,multiplier: 0.5),
            submit.topAnchor.constraint(equalTo: currentAnswer.bottomAnchor,constant: 20),
            submit.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor, constant: -100),
            submit.heightAnchor.constraint(equalToConstant: 44),
            clear.centerYAnchor.constraint(equalTo: submit.centerYAnchor),
            clear.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 100),
            clear.heightAnchor.constraint(equalToConstant: 44),
            buttonsView.widthAnchor.constraint(equalToConstant: 750),
            buttonsView.heightAnchor.constraint(equalToConstant: 320),
            buttonsView.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            buttonsView.topAnchor.constraint(equalTo: submit.bottomAnchor,constant: 20),
            buttonsView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -150)
            
            
        
        
        ])
        
        
        // creating letter buttons and calculating their position inside the buttonsView
        
        let height = 80
        let width = 150
        
        for row in 0..<4 {
            for col in 0..<5 {
                
                let letterButton = UIButton(type: .system)
                letterButton.titleLabel?.font = UIFont.systemFont(ofSize: 33)
                letterButton.setTitle("WWW", for: .normal)
                letterButton.setTitleColor(.darkGray, for: .normal)
                let frame = CGRect(x: col * width, y: row * height, width: width, height: height)
                letterButton.frame = frame
                letterButton.layer.borderWidth = 1
                letterButton.layer.borderColor = UIColor.gray.cgColor
                buttonsView.addSubview(letterButton)
                letterButtons.append(letterButton)
                letterButton.addTarget(self, action: #selector(lettersTapped), for: .touchUpInside)
            }
        }
        


    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        loadLevel()
        
    }
    
    
// methods to respond to the buttons being tapped
    
    @objc func lettersTapped(_ sender:UIButton){
        
        guard let buttonTitle = sender.titleLabel?.text else {return}
        currentAnswer.text = currentAnswer.text?.appending(buttonTitle)
     // we'll need a list of tapped buttons to bring them back to live later on ( .isHidden = false )
        activatedButtons.append(sender)
        sender.isHidden = true
    }
    
    
   
    
    
    @objc func submitTapped(_ sender:UIButton){
        
        guard let userAnswer = currentAnswer.text else {return}
        
        if let solutionPosition = solutions.firstIndex(of: userAnswer){
            
            activatedButtons.removeAll()
            
            var splitAnswers = answersLabel.text?.components(separatedBy: "\n")
            splitAnswers?[solutionPosition] = userAnswer
            answersLabel.text = splitAnswers?.joined(separator: "\n")
            
            currentAnswer.text = ""
            score += 1
            successfulAnswers += 1
            
            if successfulAnswers % 7 == 0 {
                level += 1
                if level <= 2 {
                    let ac = UIAlertController(title: "Well done!", message: "Are you ready for the next level?", preferredStyle: .alert)
                    ac.addAction(UIAlertAction(title: "Let's go!", style: .default, handler: levelUp))
                    present(ac,animated: true)
                }else {
                    let ac = UIAlertController(title: "Great!", message: "You have finished the game ,score: \(score)", preferredStyle: .alert)
                    ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
                    present(ac,animated: true)
                }
            }
            
        }else {
            
            let ac = UIAlertController(title: "Oops ", message: "Nuhh , it's not the word in question ", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Back", style: .cancel))
            present(ac,animated: true)
            if score > 0 { score -= 1}
            clearTapped(nil)
        }
        
    }
    
    
    
    
    @objc func clearTapped(_ sender:UIButton?){
        
        currentAnswer.text = ""
        
        for button in activatedButtons {
            button.isHidden = false
        }
        
        activatedButtons.removeAll()
    }

    
    
    
   
    
    
    
    
    
    
    // a method that loads every next level of the game
    
  func loadLevel(){
        
        var clueString = ""
        var solutionString = ""
        var letterBits = [String]()
        
        // extracting level data from a text file and arraging it accordingly
      
 
          
          if let levelFileURL = Bundle.main.url(forResource: "level\(level)", withExtension: "txt"){
              if let levelComponents = try? String.init(contentsOf: levelFileURL){
                  var lines = levelComponents.components(separatedBy: "\n")
                //  lines.shuffle()
                  
                  for (index,line) in lines.enumerated() {  // enumerated() will place the index of an item into "index" and the value into "line"
                      
                      let parts = line.components(separatedBy: ":")
                      let answer = parts[0]
                      let clue = parts[1]
                      
                      clueString += "\(index + 1). \(clue)\n"
                      
                      let solutionWord = answer.replacingOccurrences(of: "|", with: "")
                      solutionString += " \(solutionWord.count) letters\n"
                      solutions.append(solutionWord)
                      
                      let bits = answer.components(separatedBy: "|")
                      letterBits += bits
                      letterBits.shuffle()
                  
                      
                  }
              }
          }
          
      
        
        
        
        
        // configuring labels and buttons
     
          
          cluesLabel.text = clueString.trimmingCharacters(in: .whitespacesAndNewlines)
          answersLabel.text = solutionString.trimmingCharacters(in: .whitespacesAndNewlines)
          
          if letterBits.count == letterButtons.count {
              for i in 0..<letterButtons.count {
                  letterButtons[i].setTitle(letterBits[i], for: .normal)
              }
          }
    }
    
    
    
    func levelUp(action: UIAlertAction){
        
        
        solutions.removeAll(keepingCapacity: true)
        
        loadLevel()
        
        for button in letterButtons {
            button.isHidden = false
            
        }
    }

}



