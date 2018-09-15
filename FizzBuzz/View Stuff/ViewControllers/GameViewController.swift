//
//  ViewController.swift
//  FizzBuzz
//
//  Created by Elliot Goldman on 9/10/18.
//  Copyright © 2018 Elliot Keeler. All rights reserved.
//

import UIKit

class GameViewController: UIViewController, FizzBuzz{

    static let STORYBOARD_ID = "GameViewController"
    
    @IBOutlet weak var gradientView: GradientView!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var touchView: UIView!
    
    @IBOutlet weak var fizzButton: UIButton!
    @IBOutlet weak var fizzBuzzButton: UIButton!
    @IBOutlet weak var buzzButton: UIButton!
    
    
    var set : FizzBuzzNumberSet?{
        didSet{
            fizzBuzzGame = FizzBuzzGame(set: set!)
        }
    }
    lazy var fizzBuzzGame : FizzBuzzGame = {
        if let set = set{
            return FizzBuzzGame(set : set)
        }else{
            print("You didn't set numbers before the game loaded!")
            return FizzBuzzGame(set : .tf)
        }
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fizzBuzzGame.delegate = self
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.viewTapped(sender: )))
        touchView.addGestureRecognizer(tap)
        
        numberLabel.text = String(fizzBuzzGame.number)
        
        fizzButton.tintColor = tertiaryColor
        buzzButton.tintColor = tertiaryColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @objc func viewTapped(sender : UITapGestureRecognizer){
        let result = fizzBuzzGame.increaseNumber()
        numberLabel.text = String(fizzBuzzGame.number)
        if(result == FizzBuzzGameState.number){
            print("number")
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
        }else{
            gameOver()
        }
    }
    
    
    @IBAction func fizzButtonTapped(_ sender: UIButton) {
        print("fizz")
        let result = fizzBuzzGame.increaseByFizz()
        if(result == FizzBuzzGameState.wrong){
            gameOver()
        }else{
            numberLabel.text = String(fizzBuzzGame.number)
            UIImpactFeedbackGenerator(style: .medium).impactOccurred()
        }
        
    }
    
    @IBAction func fizzBuzzButtonTapped(_ sender: UIButton) {
        print("fizzBuzz")
        let result = fizzBuzzGame.increaseByFizzBuzz()
        if(result == FizzBuzzGameState.wrong){
            gameOver()
        }else{
            numberLabel.text = String(fizzBuzzGame.number)
            UIImpactFeedbackGenerator(style: .medium).impactOccurred()
        }
    }
    
    @IBAction func buzzButtonTapped(_ sender: UIButton) {
        print("buzz")
        let result = fizzBuzzGame.increaseByBuzz()
        if(result == FizzBuzzGameState.wrong){
            gameOver()
        }else{
            numberLabel.text = String(fizzBuzzGame.number)
            UIImpactFeedbackGenerator(style: .medium).impactOccurred()
        }
    }
    
    func gameOver(){
        print("Game Over!")
        UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
        dismiss(animated: false){
            
        }
    }
}

extension GameViewController : FizzBuzzGameDelegate {
    func timeUp() {
        print("Times Up!!!")
        gameOver()
    }
    
    func timeLeft(percent: Double) {
        gradientView.percent = percent
    }
}
