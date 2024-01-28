//
//  ViewController.swift
//  Project2
//
//  Created by Zach Nazarov on 02/11/2023.
//

import UIKit

class ViewController: UIViewController {
    
    // connection storyboard buttons to our code
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    var correctAnswer = 0
    var questionsAsked = 0  // guess limit
    var score = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countries += [ "estonia", "france", "germany",
                       "ireland", "italy", "monaco",
                       "nigeria", "poland", "russia",
                       "spain", "uk", "us" ]
        
       // creating a frame around the button
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
       // creating a button on the right that will display a current score
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "\(score)", style: .plain, target: self, action: nil)
        navigationItem.rightBarButtonItem?.tintColor = .lightGray
        
       // this func will display the  game layout
        askQuestion()
    }
    
    func askQuestion(action: UIAlertAction! = nil){
        
        // setting the guess limit
        if questionsAsked <  5 {
            
            countries.shuffle()
            
            // laying out flags to guess
            button1.setImage(UIImage(named: countries[0]),for: .normal)
            button2.setImage(UIImage(named: countries[1]),for: .normal)
            button3.setImage(UIImage(named: countries[2]),for: .normal)
            
            // setting the correct answer
            correctAnswer = Int.random(in: 0...2)
            title = "\(countries[correctAnswer].uppercased()) "
            
        }else{
            
        // in case the guessing limit was reached
        let messageToShow = " you guessed \(score) out of \(questionsAsked) correctly. "
           // creating a popup alert view
        let gameOverAlert = UIAlertController(title: nil, message: messageToShow , preferredStyle: .alert)
        gameOverAlert.addAction(UIAlertAction(title:"Continue?",style: .default , handler: askQuestion))
            
        questionsAsked = 0
        score = 0
            
        present(gameOverAlert,animated: true)
            
           // updating rightBar button
        navigationItem.rightBarButtonItem?.title = "\(score)"
            
            
            
        }
        
    }
    // connected to storyboard buttons (3)
    @IBAction func buttonTapped(_ sender: UIButton ) {
        
       
        var title:String
        var messageToShow:String
        
        
        
       if sender.tag == correctAnswer {
           
            title = " Correct "
            messageToShow = "Your score is \((score)+1) . "
            score += 1
            self.title = " \(countries[correctAnswer].uppercased()) "
           
        }else{
            
            title = " Wrong "
            messageToShow = " you're wrong it's the flag of \(countries[correctAnswer].uppercased())"
            self.title = " Fucked! "
        }
        
          // updating rightBar button
        navigationItem.rightBarButtonItem?.title = "\(score)"
        
       questionsAsked += 1
       // creating a popup alert view
        let gameOnAlert = UIAlertController(title: title , message: messageToShow , preferredStyle:.alert)
        gameOnAlert.addAction(UIAlertAction(title: "Continue", style: .default , handler: askQuestion))
        
        present(gameOnAlert,animated: true)
    
    }
    
        
    
}























