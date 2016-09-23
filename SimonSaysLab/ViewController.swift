//
//  ViewController.swift
//  SimonSaysLab
//
//  Created by James Campagno on 5/31/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var displayColorView: UIView!
    @IBOutlet weak var startGameButton: UIButton!
    @IBOutlet weak var winLabel: UILabel!
    
    @IBOutlet weak var redButton: UIButton!
    @IBOutlet weak var greenButton: UIButton!
    @IBOutlet weak var yellowButton: UIButton!
    @IBOutlet weak var blueButton: UIButton!
    
    @IBOutlet weak var playAgain: UIButton!
    
    var simonSaysGame = SimonSays()
    var buttonsClicked = 0
    
    @IBAction func redButtonPressed(_ sender: AnyObject) {
        checkGuess(colorGuessed: "Red")
    }
    
    @IBAction func greenButtonPressed(_ sender: AnyObject) {
        checkGuess(colorGuessed: "Green")
    }
    
    @IBAction func yellowButtonPressed(_ sender: AnyObject) {
        checkGuess(colorGuessed: "Yellow")
        }
    
    @IBAction func blueButtonPressed(_ sender: AnyObject) {
        checkGuess(colorGuessed: "Blue")
    }
    
    @IBAction func playAgainPlease (_ sender: AnyObject) {
        viewDidLoad()
    }
    
    func checkGuess (colorGuessed: String) {
        if colorGuessed == String(describing: simonSaysGame.patternToMatch[buttonsClicked]) && buttonsClicked == 4 {
            winLabel.text = "You Won!"
            winLabel.isHidden = false
            playAgain.isHidden = false
            hideSquares()
        } else if colorGuessed == String(describing: simonSaysGame.patternToMatch[buttonsClicked]) {
            winLabel.text = "Correct! \(buttonsClicked + 1)/\(simonSaysGame.patternToMatch.count)"
            winLabel.isHidden = false
            buttonsClicked += 1
        } else {
            winLabel.text = "You Lose"
            winLabel.isHidden = false
            playAgain.isHidden = false
            hideSquares()
        }

    }
    
    func hideSquares () {
        redButton.isHidden = true
        blueButton.isHidden = true
        yellowButton.isHidden = true
        greenButton.isHidden = true
    }
    
    func showSquares () {
        redButton.isHidden = false
        blueButton.isHidden = false
        yellowButton.isHidden = false
        greenButton.isHidden = false
    }
    
    override func viewDidLoad() {
        winLabel.isHidden = true
        playAgain.isHidden = true
        startGameButton.isHidden = false
        hideSquares()
        simonSaysGame.chosenColors = [Color]()
        simonSaysGame.colorToDisplay = 0
        buttonsClicked = 0
        super.viewDidLoad()
    }
}

// MARK: - SimonSays Game Methods
extension ViewController {
    
    @IBAction func startGameTapped(_ sender: UIButton) {
        UIView.transition(with: startGameButton, duration: 0.9, options: .transitionFlipFromBottom , animations: {
            self.startGameButton.isHidden = true
            }, completion: nil)
        
        displayTheColors()
        showSquares()
    }
    
    fileprivate func displayTheColors() {
        self.view.isUserInteractionEnabled = false
        UIView.transition(with: displayColorView, duration: 1.5, options: .transitionCurlUp, animations: {
            self.displayColorView.backgroundColor = self.simonSaysGame.nextColor()?.colorToDisplay
            self.displayColorView.alpha = 0.0
            self.displayColorView.alpha = 1.0
            }, completion: { _ in
                if !self.simonSaysGame.sequenceFinished() {
                    self.displayTheColors()
                } else {
                    self.view.isUserInteractionEnabled = true
                    print("Pattern to match: \(self.simonSaysGame.patternToMatch)")
                }
        })
    }
}
