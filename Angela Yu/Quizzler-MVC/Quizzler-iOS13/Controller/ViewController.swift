//
//  ViewController.swift
//  Quizzler-iOS13
//
//  Created by Angela Yu on 12/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var progressBar: UIProgressView!
    @IBOutlet var q1: UIButton!
    @IBOutlet var q2: UIButton!
    @IBOutlet var q3: UIButton!
    @IBOutlet var scoreLabel: UILabel!
    
    var quizBrain = QuizBrain()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uiReload()
        
    }
    
    @IBAction func answerButonPressed(_ sender: UIButton) {
        
        let userAnswer = sender.currentTitle!
        let userGotItRight =  quizBrain.answerCheck(userAnswer)
        
        if userGotItRight {
            sender.backgroundColor = .green
        }else{
            
            sender.backgroundColor = .red
        }
        
        quizBrain.nextQuestion()
        
        Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(uiReload), userInfo: nil, repeats: false)
    }
    
    @objc func uiReload(){
        questionLabel.text = quizBrain.getQuestionText()
        progressBar.progress = quizBrain.getProgres()
        scoreLabel.text = "Score: \(quizBrain.getScore())"
        
        self.q1.setTitle(quizBrain.getAnswers()[0], for: .normal)
        self.q2.setTitle(quizBrain.getAnswers()[1], for: .normal)
        self.q3.setTitle(quizBrain.getAnswers()[2], for: .normal)
        self.q1.backgroundColor = .clear
        self.q2.backgroundColor = .clear
        self.q3.backgroundColor = .clear
    }
    
}

