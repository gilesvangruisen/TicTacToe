//
//  ViewController.swift
//  TicTacToe
//
//  Created by Giles Van Gruisen on 12/19/14.
//  Copyright (c) 2014 Giles Van Gruisen. All rights reserved.
//

import Foundation
import UIKit

enum TicTacCharacters: String {
    case X = "X"
    case O = "O"
    case Unset = "Unset"
}

class TicTacButton: UIButton {

    func setCharacter(character: TicTacCharacters) {
        self.setTitle(character.rawValue, forState: .Normal)
    }

}

class GameViewController: UIViewController {

    @IBOutlet var button1: TicTacButton!
    @IBOutlet var button2: TicTacButton!
    @IBOutlet var button3: TicTacButton!
    @IBOutlet var button4: TicTacButton!
    @IBOutlet var button5: TicTacButton!
    @IBOutlet var button6: TicTacButton!
    @IBOutlet var button7: TicTacButton!
    @IBOutlet var button8: TicTacButton!
    @IBOutlet var button9: TicTacButton!

    var buttons: [TicTacButton]!

    var combinations = [(0, 1, 2), (0, 3, 6), (1, 4, 7), (2, 5, 9), (3, 4, 5), (6, 7, 9), (0, 4, 5), (6, 4, 2)]

    var boxes: [TicTacCharacters] = [.Unset, .Unset, .Unset, .Unset, .Unset, .Unset, .Unset, .Unset, .Unset]

    var currentPlayer: TicTacCharacters!

    override func viewDidLoad() {
        super.viewDidLoad()

        currentPlayer = .X
        buttons = [button1, button2, button3, button4, button5, button6, button7, button8, button9]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func buttonTapped(sender: TicTacButton) {
        let buttonIndex = find(buttons, sender)!

        setCharacterForBoxIndex(buttonIndex, character: currentPlayer)
    }

    func setCharacterForBoxIndex(index: Int, character: TicTacCharacters) {

        let currentCharacter = boxes[index]

        switch currentCharacter {
        case .Unset:

            // If unset, set it and set button text
            boxes[index] = currentPlayer
            buttons[index].setCharacter(currentPlayer)

            println("Button \(index)) now = \(currentPlayer.rawValue)")

            break

        default:

            // If set, do nothing
            println("Button already tapped")

            break

        }

        // Switch player for next turn
        switchPlayer()

    }

    func switchPlayer() {
        if currentPlayer == .X {
            currentPlayer = .O
        } else {
            currentPlayer = .X
        }
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

