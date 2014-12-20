//
//  ViewController.swift
//  TicTacToe
//
//  Created by Giles Van Gruisen on 12/19/14.
//  Copyright (c) 2014 Giles Van Gruisen. All rights reserved.
//

import Foundation
import UIKit

enum TicTacCharacter: String {
    case X = "X"
    case O = "O"
    case Unset = "Unset"
}

class TicTacBox: UIButton {

    var character: TicTacCharacter = TicTacCharacter.Unset {
        didSet {
            self.setTitle(character.rawValue, forState: .Normal)
        }
    }

}

class GameViewController: UIViewController {

    @IBOutlet var boxes: [TicTacBox]!

    var winningCombinations = [[0, 1, 2], [0, 3, 6], [1, 4, 7], [2, 5, 9], [3, 4, 5], [6, 7, 9], [0, 4, 8], [6, 4, 2]]

    var currentPlayer: TicTacCharacter!

    override func viewDidLoad() {
        super.viewDidLoad()

        currentPlayer = .X
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func tryMakeMove(senderBox: TicTacBox) {

        // Fetch index for box
        var senderBoxIndex = find(boxes, senderBox)

        // Ensure box is not yet set
        if !boxIsSet(senderBox) {

            // Set sender box to current player
            setBoxToCurrentPlayer(senderBox)

            if checkForWin() {
                println("WIN!!!")
            }

            // Switch player for next turn
            switchPlayer()

        } else {

            println("Oops! Box \(senderBoxIndex) already set to \(currentPlayer.rawValue)")

        }
    }

    func boxIsSet(box: TicTacBox) -> Bool {
        return box.character != .Unset
    }

    func setBoxToCurrentPlayer(box: TicTacBox) {
        return box.character = currentPlayer
    }

    func indexOfBox(box: TicTacBox) -> Int? {
        return find(boxes, box)
    }

    func checkForWin() -> Bool {

        let currentPlayerBoxes = boxesWithCharacter(currentPlayer)
        let currentPlayerBoxIndices = currentPlayerBoxes.map { box -> Int in
            return find(self.boxes, box)!
        }

        for combination in winningCombinations {
            let mutualKeys = combination.filter({ return contains(currentPlayerBoxIndices, $0) })

            if mutualKeys.count == combination.count {
                return true
            }
        }

        return false
    }

    func boxesWithCharacter(player: TicTacCharacter) -> [TicTacBox] {
        return boxes.filter { box -> Bool in
            return box.character == player
        }
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

