//
//  ViewController.swift
//  Concentration
//
//  Created by Toan Nguyen on 01.02.18.
//  Copyright © 2018 Toan Nguyen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    var numberOfPairsOfCards: Int {
        return cardButtons.count / 2
    }
    private var themeBackgroundColor: UIColor?
    private var themeCardColor: UIColor?
    private var themeCardTitles: [String]?
    private var emoji = [Card: String]()
    
    private let halloweenTheme = Theme.init(backgroundColor: .black, cardColor: .orange, cardTitles: ["👻", "🎃", "💀", "😈", "😱", "🦇", "🕷", "🤡", "🕸", "🦉"])
    private let happyTheme = Theme.init(backgroundColor: #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1), cardColor: #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1), cardTitles: ["🤗", "😍", "🤣", "😁", "🙆", "😘", "🙆‍♂️", "🎉", "😋", "😛"])
    private let sadTheme = Theme.init(backgroundColor: #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1), cardColor: #colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1), cardTitles: ["😭", "😢", "🙁", "😔", "🤧", "😩", "😨", "☹️", "😐", "😓"])
    private let foodTheme = Theme.init(backgroundColor: #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1), cardColor: #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1), cardTitles: ["🍕", "🍉", "🍔", "🍟", "🍫", "🌭", "🍖", "🌯", "🍗", "🍝"])
    
    @IBOutlet private weak var matchLabel: UILabel!
    @IBOutlet private weak var scoreLabel: UILabel!
    @IBOutlet private weak var timeBonusLabel: UILabel!
    @IBOutlet private(set) var cardButtons: [UIButton]!
    @IBOutlet private weak var restartButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingTheme()
        updateView()
        restartButton.isHidden = true
    }
    
    private func settingTheme() {
        let themes = [halloweenTheme, happyTheme, sadTheme, foodTheme]
        let randomTheme = themes.count.arc4random
//        print(themes[randomTheme])
        themeBackgroundColor = themes[randomTheme].backgroundColor
        themeCardColor = themes[randomTheme].cardColor
        themeCardTitles = themes[randomTheme].cardTitles
        view.backgroundColor = themeBackgroundColor
        scoreLabel.textColor = themeCardColor
        matchLabel.textColor = themeCardColor
        restartButton.tintColor = themeCardColor
        timeBonusLabel.textColor = themeCardColor
    }
    
    private func updateView() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: .normal)
                button.backgroundColor = .white
                button.isEnabled = false
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : themeCardColor
                button.isEnabled = true
            }
        }
    }
    
    @IBAction private func selectCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateView()
            timeBonusLabel.text = game.bonus
            timeBonusLabel.alpha = 1
            UIView.animate(withDuration: 1.5, animations: {
                self.timeBonusLabel.alpha = 0
            })
            game.resetTimeBonus()
            matchLabel.text = "Matches: \(game.matches)"
            scoreLabel.text = "Score: \(game.score)"
        } else {
            print("Chosen card was not in cardButtons")
        }
        if game.matches == numberOfPairsOfCards {
            restartButton.isHidden = false
        }
    }
    
    @IBAction private func restartButtonPressed(_ sender: UIButton) {
        restartButton.isHidden = true
        game.resetCards()
        game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
        emoji.removeAll()
        settingTheme()
        updateView()
        scoreLabel.text = "Score: \(game.score)"
        matchLabel.text = "Matches: \(game.matches)"
    }
    
    private func emoji(for card: Card) -> String {
        if emoji[card] == nil && themeCardTitles != nil {
            emoji[card] = themeCardTitles!.remove(at: themeCardTitles!.count.arc4random)
        }
        return emoji[card] ?? "?"
    }
    
}

extension Int {
    
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
    
}
