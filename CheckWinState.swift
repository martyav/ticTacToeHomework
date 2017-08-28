//
//  CheckWinState.swift
//  ticTacToeHomework
//
//  Created by Marty Hernandez Avedon on 08/28/17.
//  Copyright © 2017 Marty's . All rights reserved.
//

import Foundation

func checkWinState(player: String) {
    /* 
     The function doesn't know about any of the variables inside the game yet. 
     When we use the function in our game, we tell it the player's name so it can
     print out the proper messages. Like so --
     
     checkWinState(player: player1)
     */
    
    // this function is very long...mostly because i wanted to avoid hardcoding in what a win looks like
    
    var checkForwardDiagonals = "" // in a regular Tic-Tac-Toe grid, these are 1, 5, 9
    var checkBackwardDiagonals = "" // in a regular Tic-Tac-Toe grid, these are 3, 5, 7
    var checkColumns: [String] = []
    
    for outerIndex in 0..<lengthOfGrid {
        // check rows
        
        if internalGrid[outerIndex].joined() == String(repeating: "X", count: widthOfGrid) {
            print("\(player) wins!") // .joined() gives us a single string made up of everything inside the array
            ongoingGame = false
            break
        }
        
        if internalGrid[outerIndex].joined() == String(repeating: "O", count: widthOfGrid) {
            print("Computer wins!")
            ongoingGame = false
            break
        }
        
        // load up our diagnol & column checkers
        
        for innerIndex in 0..<widthOfGrid {
            checkColumns.append(internalGrid[outerIndex][innerIndex])
            
            if innerIndex == outerIndex {
                checkForwardDiagonals += internalGrid[outerIndex][innerIndex]
            }
            
            if innerIndex == widthOfGrid - outerIndex - 1 {
                checkBackwardDiagonals += internalGrid[outerIndex][innerIndex]
            }
            
        }
        
        // check forward diagonals
        
        if checkForwardDiagonals == String(repeating: "X", count: widthOfGrid) {
            print("\(player) wins!")
            ongoingGame = false
            break
        }
        
        if checkForwardDiagonals == String(repeating: "O", count: widthOfGrid) {
            print("Computer wins!")
            ongoingGame = false
            break
        }
        
        // check backward diagonals
        
        if checkBackwardDiagonals == String(repeating: "X", count: widthOfGrid) {
            print("\(player) wins!")
            ongoingGame = false
            break
        }
        
        if checkBackwardDiagonals == String(repeating: "O", count: widthOfGrid) {
            print("Computer wins!")
            ongoingGame = false
            break
        }
        
        // check columns
        
        for currentColumn in 0..<widthOfGrid {
            var column = ""
            
            for index in stride(from: currentColumn, to: checkColumns.count, by: widthOfGrid) {
                column += checkColumns[index]
            }
            
            /*
             We made checkColumns one long array of strings so we could use stride on it.
             Stride lets us go through the array by skipping over some elements 
             and by starting in different places on each trip through the loop.
             
             On our first trip, we start on index 0, and stride by 3's, so we go down 1, 4, 7.
             Then we go to index 1, and stride down by 3's -- 2, 5, 8.
             Then we hit our last index, 2, and stride down by 3's -- 3, 6, 9.
             
             There is a method called .flatMap() that we could have used to make 
             our three-array grid into one long array. We didn't use it here because
             .flatMap()'s use can get kind of confusing...especially since you 
             haven't covered closures yet.
             */
            
            if column == String(repeating: "O", count: widthOfGrid) {
                print("Computer wins!")
                ongoingGame = false
                break
            }
            
            if column == String(repeating: "X", count: widthOfGrid) {
                print("\(player) wins!")
                ongoingGame = false
                break
            }
            
        }
    }
}

// this function contains a lot of repetitive code. how could we make it smaller?

// how could we write code so we track wins and losses?
