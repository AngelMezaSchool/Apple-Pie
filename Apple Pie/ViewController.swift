//
//  ViewController.swift
//  Apple Pie
//
//  Created by Angel Meza on 05/03/24.
//

import UIKit

class ViewController: UIViewController {
    // Outlets
    @IBOutlet weak var treeImageView: UIImageView!
    @IBOutlet weak var correctWordLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet var letterButtons: [UIButton]!
    
    
    // WHAT HAPPEN ON THE APP
    override func viewDidLoad() {
        super.viewDidLoad()
        newRound()
    }
    
    // Actions
    @IBAction func letterButtonPressed(_ sender: UIButton) {
        sender.isEnabled = false
        let letterString = sender.configuration!.title!
        //let letterString = sender.title(for: .normal)! //por alguna razon no funciona - for some reason this line isn't working :v
        let letter = Character(letterString.lowercased())
        currentGame.playerGuessed(letter: letter)
        //updateUI()
        updateGameState()
    }


    // Global logic
    func updateGameState(){
        if currentGame.incorrectMovesRemaining == 0{
            totalLosses += 1
        }else if currentGame.word == currentGame.formattedWord{
            totalWins += 1
        }else {
            updateUI()
        }
    }
    

    var listOfWords = ["buccaner", "swift", "glorious", "incandescent", "bug", "program", "cat", "dog", "television", "backpack"]
    let incorrectMovesAllowed = 7
    var totalWins = 0{
        didSet {
            newRound()
        }
    }
    var totalLosses = 0{
        didSet {
            newRound()
        }
    }
    // call the file Game
    var currentGame: Game!
    
    func newRound() {
        if !listOfWords.isEmpty{
            let newWord = listOfWords.removeFirst()
            currentGame = Game(word: newWord, incorrectMovesRemaining: incorrectMovesAllowed, guessedLetter: []) // from de struct in the swift file Game. IncorrectMovesAllowed: = 7
            enableLetterButtons(true)
            updateUI()
        } else {
            enableLetterButtons(false)
        }
        //updateUI()
    }
    
    func enableLetterButtons(_ enable: Bool){
        for button in letterButtons{
            button.isEnabled = enable
        }
    }
    
    func updateUI(){
        var letters = [String]()
        for letter in currentGame.formattedWord {
            letters.append(String(letter)) // no se que hice :p
        }
        let wordWithSpacing = letters.joined(separator: " ")
        correctWordLabel.text = wordWithSpacing
        //correctWordLabel.text = currentGame.formattedWord //formatteWord is in the Game file
        scoreLabel.text = "Wins: \(totalWins), Losses: \(totalLosses)"
        treeImageView.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)")
    }
    
    
    
}

