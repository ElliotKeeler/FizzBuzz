//
//  FizzBuzzGame.swift
//  FizzBuzz
//
//  Created by Elliot Goldman on 9/10/18.
//  Copyright © 2018 Elliot Keeler. All rights reserved.
//

import Foundation

enum FizzBuzzNumberSet : Int{
    case tf = 0
    case fs
    case ts
    case te
    
    func numbers()->(numI : Int, numII : Int){
        if(self == .tf){
            return (3, 5)
        }else if(self == .fs){
            return (4, 6)
        }else if(self == .ts){
            return (3, 7)
        }else{ //self == .te
            return (3, 8)
        }
    }
    
    func toString()->String{
        if(self == .tf){
            return "tf"
        }else if(self == .fs){
            return "fs"
        }else if(self == .ts){
            return "ts"
        }else{ //self == .te
            return "te"
        }
    }
}

enum FizzBuzzGameState{
    case fizz
    case buzz
    case fizzBuzz
    case number
    case wrong
}

protocol FizzBuzzGameDelegate{
    func timeLeft(percent : Double)
    func timeUp()
}

class FizzBuzzGame : NSObject, FizzBuzz, UserSettings{
    
    let UPDATE_TIMER_INTERVAL = 0.1
    
    let set : FizzBuzzNumberSet
    var delegate : FizzBuzzGameDelegate?
    var number : Int = 1
    lazy var time : Double = { //In seconds
        return Double(defaultStartTime)
    }()
    var lastTime = Date()
    lazy var timer : Timer = {
        return Timer(timeInterval: UPDATE_TIMER_INTERVAL, target: self, selector: #selector(self.timerTriggered(sender:)), userInfo: nil, repeats: true)
    }()
    
    
    init(set : FizzBuzzNumberSet){
        self.set = set
        super.init()
        
        RunLoop.main.add(timer, forMode: .defaultRunLoopMode)
    }
    
    @objc func timerTriggered(sender : Timer){
        if((-1 * lastTime.timeIntervalSinceNow) >= time){
            timer.invalidate()
            delegate?.timeUp()
        }else{
            let percent = (-1 * lastTime.timeIntervalSinceNow) / time
            delegate?.timeLeft(percent: percent)
        }
        
    }
    
    func keepPlaying(){
        time -= 0.1
        lastTime = Date()
    }
    
    func gameOver(){
        timer.invalidate()
        //Subtract the number because the player didn't get the current answer correct
        number -= 1
        if(number > highScore(set: set)){
            setHighScore(newHighScore: number, set: set)
        }
    }
    
    func increaseNumber()->FizzBuzzGameState{
        number += 1
        //If the number isn't divisible by either of the numbers
        if(!(number % set.numbers().numI == 0) && !(number % set.numbers().numII == 0)){
            keepPlaying()
            return .number
        }else{
            gameOver()
            return .wrong
        }
    }
    
    func increaseByFizz()->FizzBuzzGameState{
        number += 1
        //If number is divisibble by the first number but not the second
        if((number % set.numbers().numI == 0) && !(number % set.numbers().numII == 0)){
            keepPlaying()
            return .fizz
        }else{
            gameOver()
            return .wrong
        }
    }
    
    func increaseByBuzz()->FizzBuzzGameState{
        number += 1
        //If number is divisibble by the first number but not the second
        if(!(number % set.numbers().numI == 0) && (number % set.numbers().numII == 0)){
            keepPlaying()
            return .buzz
        }else{
            gameOver()
            return .wrong
        }
    }
    
    func increaseByFizzBuzz()->FizzBuzzGameState{
        number += 1
        //If number is divisibble by the first number but not the second
        if((number % set.numbers().numI == 0) && (number % set.numbers().numII == 0)){
            keepPlaying()
            return .fizzBuzz
        }else{
            gameOver()
            return .wrong
        }
    }
}
