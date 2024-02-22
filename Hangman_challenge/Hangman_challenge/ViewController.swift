
//   build a hangman game

import UIKit

class ViewController: UIViewController {
    
    var clueLabel:UILabel!
    var answerLabel:UILabel!
    var correctAnswersCountLabel:UILabel!
    var gallowsLabel:UILabel!

    
    var keyLetters = [String]()
    var levels = [String]()
    var letterButtons = [UIButton]()
    var activatedButtons = [UIButton]()
    var charWordSet = [Character]()
    
    
    var correctAnswer = ""
    
    
    var gallowsScene = [
        "The gallows appears\n",
        "The noose appears\n",
        "The head appears\n",
        "The body appears\n",
        "The left hand appears\n",
        "The right hand appears\n",
        "The left leg appears\n",
        "The right leg appears\n",
        "YOU ARE HANGED!"]
    
    
    var score = 0 {
        
        didSet{
            correctAnswersCountLabel.text = "Score : \(score)"
        }
    }
    
    
    var correctAnswers = 0
    
    var wrongAnswers = 0{
        didSet{
            if wrongAnswers == 0 {
                gallowsLabel.text = ""
            }else{
                gallowsLabel.text! += gallowsScene[wrongAnswers - 1]
            }
        }
    }
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
            
            correctAnswers = 0
            wrongAnswers = 0
            correctAnswer = ""
            charWordSet.removeAll()
            
            let currentLevel = levels[level]
            
            let levelContents = currentLevel.components(separatedBy: "|")
            
            
            clueLabel.text = "\(levelContents[0]) (\(levelContents[1].count))"
            
            let answer = levelContents[1]
         //   let answerLetterCount = answer.count
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
        
        performSelector(inBackground: #selector(loadLevels), with: nil)
        
        
        clueLabel = UILabel()
        clueLabel.translatesAutoresizingMaskIntoConstraints = false
        clueLabel.font = UIFont.systemFont(ofSize: 26)
        clueLabel.textColor = .white
        clueLabel.numberOfLines = 0
        clueLabel.text = "( CLUES ) "
        view.addSubview(clueLabel)
        
        
        correctAnswersCountLabel = UILabel()
        correctAnswersCountLabel.translatesAutoresizingMaskIntoConstraints = false
        correctAnswersCountLabel.textAlignment = .left
        correctAnswersCountLabel.font = UIFont.systemFont(ofSize: 20)
        correctAnswersCountLabel.textColor = .white
        correctAnswersCountLabel.text = "Score : \(correctAnswers)"
        view.addSubview(correctAnswersCountLabel)
        
        gallowsLabel = UILabel()
        gallowsLabel.translatesAutoresizingMaskIntoConstraints = false
        gallowsLabel.font = UIFont.systemFont(ofSize: 20)
        gallowsLabel.textColor = .white
        gallowsLabel.numberOfLines = 0
        gallowsLabel.text = ""
        
        
        
        
        gallowsLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        view.addSubview(gallowsLabel)
        
        
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
        
            correctAnswersCountLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor,constant: 10),
            correctAnswersCountLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            gallowsLabel.topAnchor.constraint(equalTo: correctAnswersCountLabel.bottomAnchor, constant: 40),
            gallowsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
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
    
    @objc func loadLevels(){
        
        if let levelsURL = Bundle.main.url(forResource: "levels", withExtension: "txt"){
            if let levelsString = try? String.init(contentsOf: levelsURL){
                levels = levelsString.components(separatedBy: "\n")
                
                // getting rid of an empty line at the end of a text file ex. ["aa","dd","ee",""]
                
                for (index,level) in levels.enumerated() {
                    if level == "" {levels.remove(at: index)}
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
                correctAnswers += 1
               
                
            }

        }
        
        if currentCorrectAnswer > 0 {
            score += 1
            
        }else{
            wrongAnswers +=  1
            sender.setTitleColor(.red, for: .disabled)
        }
        
        answerLabel.text = String.init(charWordSet)
        
        updateUI()
        
      
        
    }
    
    func updateUI(){
        
        if wrongAnswers == gallowsScene.count {
            
            let ac = UIAlertController(title: "You are a hangman !", message: "Do you want to rise from the dead and start over ? ", preferredStyle: .alert)
            let restart = UIAlertAction(title: "Restart", style: .default){ action in
               // self.level = 0
             
                self.loadLevel()
            }
            
            ac.addAction(restart)
            present(ac,animated: true)
        }
        print(correctAnswers,correctAnswer.count)
        
        
        if correctAnswers == correctAnswer.count  {
            
            
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
                
                ac.addAction(restart)
                present(ac,animated: true)
                
            }
            
        }
        
        
        
    }
}

