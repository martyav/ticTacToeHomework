//
//  CheckWinState.swift
//  ticTacToeHomework
//
//  Created by Marty Hernandez Avedon on 08/28/17.
//  Copyright © 2017 Marty's . All rights reserved.
//

import Foundation

func shouldGameKeepRunning(inGrid grid: [[String]], withLength length: Int, andWidth width: Int) -> Bool {
    
    var rows: String
    var forwardDiagonals = "" // in a regular Tic-Tac-Toe grid, these are 1, 5, 9
    var backwardDiagonals = "" // in a regular Tic-Tac-Toe grid, these are 3, 5, 7
    var columns: [String] = []
    
    func check(_ line: String, for mark: String = "X", versus: String = "O", player: String = player1, opponent: String = "Computer") -> Bool {
        if line.contains(String(repeating: mark, count: width)) {
            print("\(player) wins!")
            return true
        } else if line.contains(String(repeating: versus, count: width)) {
            print("\(opponent) wins!")
            return true
        } else {
            return false
        }
    }
    
    for outerIndex in 0..<length {
        
        rows = grid[outerIndex].joined() // makes each inner array into one string
        columns = grid.flatMap {$0} // makes the grid into one long array
        
        for innerIndex in 0..<width {
            
            if innerIndex == outerIndex {
                forwardDiagonals += grid[outerIndex][innerIndex]
            }
            
            if innerIndex == width - outerIndex - 1 {
                backwardDiagonals += grid[outerIndex][innerIndex]
            }
            
        }
        
        let winnerInRows = check(rows)
        let winnerInForwardDiagonal = check(forwardDiagonals)
        let winnerInBackwardDiagonal = check(backwardDiagonals)
        
        if winnerInRows || winnerInForwardDiagonal || winnerInBackwardDiagonal {
            // if we have a winner, game shouldn't keep going!
            return false
        }
        
        // load up columns
        
        for currentColumn in 0..<width {
            let winnerInColumn: Bool
            var tempColumn = ""
            
            for index in stride(from: currentColumn, to: columns.count, by: width) {
                tempColumn += columns[index]
            }
            
            winnerInColumn = check(tempColumn)
            
            if winnerInColumn == true {
                return false
            }
        }
    }
    
    // keep going until we have a winner
    return true
}

