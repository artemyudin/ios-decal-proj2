//
//  ViewController.swift
//  Hangman
//
//  Created by Gene Yoo on 10/13/15.
//  Copyright © 2015 cs198-ios. All rights reserved.
//

import UIKit

class HangmanViewController: UIViewController {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var alreadyGuessed: UILabel!
    @IBOutlet weak var knownString: UILabel!
    @IBOutlet weak var guessTextField: UITextField!
    
    @IBAction func onFinishedEntering() {
        guessLetter()
    }
    
    var api: Hangman!
    var done = false
    
    var stage = 1
    
    @IBAction func guessLetter() {
        if done {
            return
        }
        if let guess = guessTextField.text {
            guessTextField.text = ""
            if (guess.isEmpty) {
                return
            }
            let firstChar = guess.lowercaseString[guess.startIndex]
            if (firstChar >= "a" && firstChar <= "z") {
                // Valid guess, process it
                if (api.guessLetter(String(firstChar))) {
                    knownString.text = api.knownString
                    if (!api.knownString!.containsString("_")) {
                        done = true
                        showAlert("WON")
                        print("YOU WON")
                        return
                    }
                } else {
                    stage++
                    image.image = UIImage(named: "hangman\(stage).gif")
                    if (stage == 7) {
                        done = true
                        showAlert("LOST")
                        print("YOU LOST")
                        return
                    }
                }
                alreadyGuessed.text = api.guesses()
            }
            
        }
    }
    @IBAction func NewGamePressed() {
        done = false
        stage = 1
        alreadyGuessed.text = " "
        image.image = UIImage(named: "hangman\(stage).gif")
        api = Hangman()
        api.start()
        knownString.text = api.knownString
        print("Secret word: \(api.answer)")
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NewGamePressed()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func showAlert(state: String) {
        //Create the AlertController
        let actionSheetController: UIAlertController = UIAlertController(title: "Alert", message: "Hey, you just \(state)", preferredStyle: .Alert)
        
        //Create and an option action
        let nextAction: UIAlertAction = UIAlertAction(title: "Ok", style: .Default) { action -> Void in
        }
        actionSheetController.addAction(nextAction)
        
        //Present the AlertController
        self.presentViewController(actionSheetController, animated: true, completion: nil)
    }
    
}

