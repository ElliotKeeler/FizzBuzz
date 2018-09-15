//
//  MenuViewController.swift
//  FizzBuzz
//
//  Created by Elliot Goldman on 9/10/18.
//  Copyright © 2018 Elliot Keeler. All rights reserved.
//

import Foundation
import UIKit

class MenuViewController: UIViewController, FizzBuzz, UserSettings {
    
    let HIGH_SCORE_ANIMATE_OUT_SPEED = 0.06
    let HIGH_SCORE_ANIMATE_OUT_AMOUNT = 6
    
    @IBOutlet weak var crownView: CrownView!
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var startButtonNumberI: UILabel!
    @IBOutlet weak var startButtonNumberII: UILabel!
    @IBOutlet weak var startButton: UIButton!
    
    var set : FizzBuzzNumberSet = .tf{
        didSet{
            startButtonNumberI.text = String(set.numbers().numI)
            startButtonNumberII.text = String(set.numbers().numII)
            resetHighScoreLabel()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = mainColor
        startButton.tintColor = tertiaryColor
        crownView.color = tertiaryColor
        crownView.isOpaque = false
        
        resetHighScoreLabel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        resetHighScoreLabel()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func resetHighScoreLabel(){
        self.highScoreLabel.text = String(self.highScore(set: set))
    }
    
    func animateHighScoreOut(completion : (()->())?){
        let _ = Timer.scheduledTimer(withTimeInterval:HIGH_SCORE_ANIMATE_OUT_SPEED , repeats: true){[unowned self] timer in
            guard var num = Int(self.highScoreLabel.text!) else{
                print("Why was the high score animation screwed up?!")
                return
            }
            if(num > 1 && (num > (self.highScore(set: self.set) - self.HIGH_SCORE_ANIMATE_OUT_AMOUNT))){
                num -= 1
                self.highScoreLabel.text = String(num)
            }else{
                timer.invalidate()
                completion?()
            }
        }
        
    }
    
    @IBAction func startButtonTapped(_ sender: UIButton) {
        //TODO: Animate into
        
        animateHighScoreOut(){[unowned self] in
            let storyBoard = UIStoryboard(name: self.storyboardName, bundle: nil)
            let gameViewController = storyBoard.instantiateViewController(withIdentifier: GameViewController.STORYBOARD_ID) as! GameViewController
            gameViewController.set = self.set
            self.present(gameViewController, animated: false){[unowned self] in
                //Put the high score back
                self.resetHighScoreLabel()
            }
        }
    }
    
    @IBAction func numberViewTapped(_ sender: NumberView) {
        if(set == .tf){
            set = .fs
        }else if(set == .fs){
            set = .ts
        }else if(set == .ts){
            set = .te
        }else if(set == .te){
            set = .tf
        }
    }
}
