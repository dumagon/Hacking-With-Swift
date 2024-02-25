
//   build a hangman game

import UIKit

class ViewController: UIViewController {
    
    var clueLabel:UILabel!                   //  provides a clue
    var answerLabel:UILabel!                // the answer word goes in here
    var scoreLabel:UILabel!                // displays users's score ex. - - - - - , - A - - E, etc
    var gallowsLabel:UILabel!             // shows the gallows
    var hangmanLabel:UILabel!            // gradually reveals the body of a hanged man

    
    var levels = [String]()                       // loaded levels strings are going in here
    var letterButtons = [UIButton]()             //  buttons that represent letters
    var charWordSet = [Character]()             //   used to replace - with a letter if guessed wright and rebuild a string
                                               //    that will represent the answer
    
   
 // the word a player has to guess ( gets initialized in loadLevel()
    
    var correctAnswer = ""
 

// the picture of a hanged man and gallows represented by two arrays of Strings ( appear according to the number of wrong answers
    
    var gallowsScene = [String]()
    var hangmanScene = [String]()
    

// score and correct answers / wrong answers counts
    
    var score = 0 {
        
        didSet{
            scoreLabel.text = "Score : \(score)"
        }
    }
    
    var correctAnswersCount = 0
    
    var wrongAnswersCount = 0{              // value observer that reacts to a wrong letter being touched
        didSet{
            if wrongAnswersCount == 0 {    // gets executed when a level is reloaded
                gallowsLabel.text = ""
                hangmanLabel.text = ""
                
            }else{
                if wrongAnswersCount == 1 {                    // the gallows appear at the first incorrect guess
                    gallowsLabel.text = gallowsScene[0]
                }else{
                    hangmanLabel.text? += "\(hangmanScene[wrongAnswersCount - 2 ])\n"  // as more wrong letters are pressed a body of
                }                                                                     //  a hangman appears out of the dark
            }
        }
        
    }
                       // a level to be loaded
    var level = 0
    
    
    
    
    
    
    
    override func loadView() {
        
        configureUIElements()
        
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadLevel()
        
    }
    
  
    
    
    
    func loadLevel() {
        
        
        
        if levels.isEmpty { print("oops")
        }else{
            
            correctAnswersCount = 0
            wrongAnswersCount = 0
            correctAnswer = ""
            charWordSet.removeAll()
            
            let currentLevel = levels[level]
            
            let levelContents = currentLevel.components(separatedBy: "|")
            
            
            clueLabel.text = "\(levelContents[0]) (\(levelContents[1].count))"
            
            let answer = levelContents[1]
            correctAnswer = answer
            
            for _ in 0..<correctAnswer.count {
                
                charWordSet.append("-")
            }
            
            answerLabel.text = String.init(charWordSet)
            
//            for button in letterButtons{
//                button.isEnabled = true
//            }
            
            
            var letters = levelContents[2].components(separatedBy: ":")
                letters.shuffle()
            
            for (index,letter) in letters.enumerated() {
                letterButtons[index].setTitle(letter, for: .normal)
                letterButtons[index].isEnabled = true
            }
            
            
       

            
        }
        
        
    }



}









extension ViewController {
    
    func configureUIElements(){
        
        
        view = UIView()
        view.backgroundColor = .black
        
        performSelector(inBackground: #selector(loadData), with: nil)
        
        
        clueLabel = UILabel()
        clueLabel.translatesAutoresizingMaskIntoConstraints = false
        clueLabel.font = UIFont.systemFont(ofSize: 26)
        clueLabel.textColor = .white
        clueLabel.numberOfLines = 0
        clueLabel.text = "( CLUES ) "
        view.addSubview(clueLabel)
        
        
        scoreLabel = UILabel()
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.textAlignment = .left
        scoreLabel.font = UIFont.systemFont(ofSize: 20)
        scoreLabel.textColor = .white
        scoreLabel.text = "Score : \(correctAnswersCount)"
        view.addSubview(scoreLabel)
        
        
        gallowsLabel = UILabel()
        gallowsLabel.translatesAutoresizingMaskIntoConstraints = false
        gallowsLabel.font = UIFont.systemFont(ofSize: 24)
        gallowsLabel.textColor = .white
        gallowsLabel.numberOfLines = 0
        gallowsLabel.text = ""
        gallowsLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        view.addSubview(gallowsLabel)
        
        hangmanLabel = UILabel()
        hangmanLabel.translatesAutoresizingMaskIntoConstraints = false
        hangmanLabel.font = UIFont.systemFont(ofSize: 24)
        hangmanLabel.textColor = .white
        hangmanLabel.numberOfLines = 0
        hangmanLabel.text = ""
        hangmanLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        view.addSubview(hangmanLabel)
        
        
        
        
      
       
        
        
        answerLabel = UILabel()
        answerLabel.translatesAutoresizingMaskIntoConstraints = false
        answerLabel.font = UIFont.systemFont(ofSize: 30)
        answerLabel.textColor = .cyan
        answerLabel.numberOfLines = 1
        answerLabel.text = "WORD"
      //  answerLabel.backgroundColor = .brown
        view.addSubview(answerLabel)
        
        let buttonView = UIView()
        buttonView.translatesAutoresizingMaskIntoConstraints = false
        let height = 350.0
        let width = 300.0
        buttonView.setContentCompressionResistancePriority(UILayoutPriority(1), for: .vertical)
        //buttonView.backgroundColor = .lightGray
        view.addSubview(buttonView)
    
        
        
        
        
        NSLayoutConstraint.activate([
        
            scoreLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor,constant: 10),
            scoreLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            gallowsLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor, constant: 40),
            gallowsLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor,constant: 10),
            gallowsLabel.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.5 ,constant: -5),
            hangmanLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor,constant: -10),
            hangmanLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor,constant: 69),
            hangmanLabel.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.5,constant: -5),
            clueLabel.topAnchor.constraint(equalTo: gallowsLabel.topAnchor,constant: 250),
            clueLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            clueLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 40),
            answerLabel.topAnchor.constraint(equalTo: clueLabel.bottomAnchor, constant: 20),
            answerLabel.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            buttonView.widthAnchor.constraint(equalToConstant: width),
            buttonView.heightAnchor.constraint(equalToConstant: height),
            buttonView.topAnchor.constraint(equalTo: answerLabel.bottomAnchor, constant: 20),
            buttonView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor,constant: -20),
            buttonView.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor)
            
            
        
        
        ])
        
        
        // populating buttonView with buttons
     
       
        let buttonHeight = Int(height/5)
        let buttonWidth = Int(width/4)
        print(buttonHeight,buttonWidth)
        
        for row in 0..<4{
            for col in 0..<4{
                let button = UIButton()
                button.titleLabel?.font = UIFont.systemFont(ofSize: 29, weight: .bold)
                button.setTitle("R", for: .normal)
                button.setTitleColor(.lightGray, for: .normal)
                let frame = CGRect(x: buttonWidth * row , y: buttonWidth * col , width: buttonWidth, height: buttonHeight)
                button.frame = frame
                buttonView.addSubview(button)
                letterButtons.append(button)
                button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
                
              
            }
            
        }
        
        
    }
    
    @objc func loadData(){
        
        if let levelsURL = Bundle.main.url(forResource: "levels", withExtension: "txt"){
            if let levelsString = try? String.init(contentsOf: levelsURL){
                levels = levelsString.components(separatedBy: "\n")
                
                // getting rid of an empty line at the end of a text file ex. ["aa","dd","ee",""]
                
                for (index,level) in levels.enumerated() {
                    if level == "" {levels.remove(at: index)}
                }
               
            }
        }
        
        if let gallowsURL = Bundle.main.url(forResource: "gallows", withExtension: "txt"){
            if let gallowsString = try? String.init(contentsOf: gallowsURL){
                gallowsScene.append(gallowsString)
                
            }
        }
        
        if let hangmanURL = Bundle.main.url(forResource: "hangman", withExtension: "txt"){
            if let hangmanString = try? String.init(contentsOf: hangmanURL){
               let hangmanSceneProto = hangmanString.components(separatedBy: "\n")
                for string in hangmanSceneProto {
                    if string == "" {
                        // do nothing
                    }else{
                        hangmanScene.append(string)
                        
                    }
                }
                
            }
        }
        
    }
    
    
    @objc func buttonTapped(_ sender: UIButton){
        
        let guessedLetter = sender.titleLabel?.text
        
        sender.isEnabled = false
        sender.setTitleColor(.darkGray, for: .disabled)
        
     
        var currentCorrectAnswer = 0
        
        
        for (index,letter) in correctAnswer.enumerated() {
            
            if  letter == Character(guessedLetter!){
             
                charWordSet[index] = letter
               currentCorrectAnswer += 1
                correctAnswersCount += 1
               
                
            }

        }
        
        if currentCorrectAnswer > 0 {
            score += 1
            
        }else{
            wrongAnswersCount +=  1
            sender.setTitleColor(.red, for: .disabled)
        }
        
        answerLabel.text = String.init(charWordSet)
        
        updateUI()
        
      
        
    }
    
    func updateUI(){
        
        if wrongAnswersCount == hangmanScene.count + 1 {
            
            let ac = UIAlertController(title: "You are a hangman !", message: "Do you want to rise from the dead and start over ? ", preferredStyle: .alert)
            let restart = UIAlertAction(title: "Restart", style: .default){ action in
               // self.level = 0
             
                self.loadLevel()
            }
            
            let cancel = UIAlertAction(title: "Quitting?", style: .default){ action in
                
            let vc = HangedViewController()
                vc.modalPresentationStyle = .fullScreen
                self.present(vc,animated: true)
            }
            
            ac.addAction(restart)
            ac.addAction(cancel)
            present(ac,animated: true)
        }
        
        
        
        if correctAnswersCount == correctAnswer.count  {
            
            
            level += 1
            if level < levels.count {
                loadLevel()
            }else{
               
                let ac = UIAlertController(title: "Your score is \(score)", message: "Do you want to push your luck one more time  ? ", preferredStyle: .alert)
                let restart = UIAlertAction(title: "Restart", style: .default){ action in
                    self.level = 0
                    self.score = 0
                    self.loadLevel()
                }
                
                let cancel = UIAlertAction(title: "Quitting?", style: .default){ action in
                    
                let vc = HangedViewController()
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc,animated: true)
                }
                
                ac.addAction(restart)
                ac.addAction(cancel)
                present(ac,animated: true)
                
            }
            
        }
        
        
        
    }
}

