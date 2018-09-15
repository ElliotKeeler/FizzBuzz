//
//  UserSettings.swift
//  FizzBuzz
//
//  Created by Elliot Goldman on 9/10/18.
//  Copyright © 2018 Elliot Keeler. All rights reserved.
//

import Foundation
import UIKit

let HIGH_SCORE_KEY = "HighScoreKey"
let SET_KEY = "SetKey"

protocol UserSettings {}

extension UserSettings{
    
    func highScore(set : FizzBuzzNumberSet)->Int{
        let hsDictionary = UserDefaults.standard.dictionary(forKey: HIGH_SCORE_KEY)//.integer(forKey: HIGH_SCORE_KEY)
        
        //If the dictionary is there and it has the key as an int
        if let hs = hsDictionary?[set.toString()] as? Int{
            return hs
        }else{
            //Default is 1
            return 1
        }
    }
    
    func setHighScore(newHighScore : Int, set : FizzBuzzNumberSet){
        //Get the current dictionary and if it doesn't exist, create it
        var hsDictionary = UserDefaults.standard.dictionary(forKey: HIGH_SCORE_KEY)
        if(hsDictionary == nil){
            hsDictionary = [String : Any]()
        }
        hsDictionary![set.toString()] = newHighScore
        
        UserDefaults.standard.set(hsDictionary, forKey: HIGH_SCORE_KEY)
        UserDefaults.standard.synchronize()
    }
}
