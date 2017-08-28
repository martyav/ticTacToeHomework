//
//  main.swift
//  ticTacToeHomework
//
//  Created by Marty Hernandez Avedon on 08/27/17.
//  Copyright © 2017 Marty's . All rights reserved.
//

import Foundation // importing Foundation lets you use all sorts of built-in functions and classes

var ongoingGame: Bool

let prompt = ">> "
var player1: String = "Anonymous" // this gives the player a default name if they don't type one in later

let lengthOfGrid = 3 // we make the length and width variable in case we want to play bigger or smaller games
let widthOfGrid = 3
let gridSize = lengthOfGrid * widthOfGrid

var internalGrid: [[String]] // our game board. it's not initialized yet because the game hasn't started
var innerArray: [String] // this will be used and resused to fill our grid with rows

var round: Int


print("*--- _Tic_|_Tac_|_Toe_ ---* \n")
print("Welcome! What is your name?", terminator: " ") // personalizing the game is always a nice touch

while true { // we want our game to keep running and running, until we break this loop and quit
    print("If you want to stop playing, type 'quit' to exit.", prompt, separator: "\n")
    
    let playersResponse = readLine()!
    
    if playersResponse.lowercased() == "quit" {
        break
    }
    
    /*
     using the String method .lowercased() above makes it easier to match the 
     user's answer with our string, "quit".
     
     when we take in user input, we should make it all the same case --
     otherwise we'll have to check if the user typed quit, Quit, QUIT, etc. 
     
     If we used something called regular expressions, we wouldn't have to use .lowercased(),
     but regular expressions are a much more complicated topic than String methods!
     
     See https://code.tutsplus.com/tutorials/swift-and-regular-expressions-swift--cms-26626
     */
    
    round = 0 // we start counting rounds once we know the player hasn't quit
    
    if playersResponse != "" {
        player1 = playersResponse // if we get no answer the first time the player plays, the default value is "Anonymous". If they win or lose a game and restart, they can choose to keep their current name or change it
    }
    
    print("\nHi, \(player1)! Let's get started!")
    print("Drawing the board...", "\n")
    
    sleep(1) // the pause makes it seem like drawing a grid is really intense
    
    print("Try to beat me! Make a straight line of X's inside the grid and win! \n")
    
    internalGrid = [] // we reset the grid to empty
    innerArray = [] // this is a container for the rows inside our grid. It gets reset on each trip through the loop
    
    for number in 1...gridSize {
        innerArray.append(String(number)) // on each trip through a row, we append the number to our inner array
        
        if number % widthOfGrid > 0 { // These are our first & middle columns
            print("_\(number)_|", terminator: "")
        } else { // This is our last column -- 3, 6, 9, if we're doing the usual Tic-Tac-Toe
            print("_\(number)_\n")
            
            internalGrid.append(innerArray) // once we reach the last column in a row, we append the innerArray we just filled up...
            innerArray = [] //  and then empty the innerArray for the next trip through a row
        }
        
        // Note: We fill up our grid while printing another grid just for show. Doing it this way means we don't have to write two loops -- one to fill the grid and one to display it
    }
    
    ongoingGame = true // we have a player and a grid! we can now start playing!
    
    while ongoingGame {
        round += 1
        
        var promptPlayer = true
        
        while promptPlayer {
            print("\nType a number to indicate where on the grid you want your X to go!", prompt, separator: "\n")
            
            let playersChoice = readLine()!
            
            if let coordinate = Int(playersChoice) {
                guard coordinate < 10 else { // guard statements help us handle errors in user input before we get too far into the loop
                    print("That number is too big!") // it's a good idea to give your user advice on what wrong when they make an error
                    continue // go to top of the promptPlayer loop and start again
                }
                
                guard coordinate > 0 else {
                    print("That number is too small!")
                    continue
                }
                
                let innerIndex: Int
                let outerIndex: Int
                
                // these calculations are only true for square grids...if you can figure out the math for any kind of grid, congrats.
                
                if coordinate % widthOfGrid != 0 {
                    innerIndex = (coordinate % widthOfGrid) - 1
                    outerIndex =  coordinate / (gridSize / widthOfGrid)
                } else {
                    innerIndex = widthOfGrid - 1
                    outerIndex = (coordinate / (gridSize / lengthOfGrid)) - 1
                }
                
                if internalGrid[outerIndex][innerIndex] == "X" || internalGrid[outerIndex][innerIndex] == "O" {
                    print("Oops, that spot is already filled!")
                    continue
                }
                
                internalGrid[outerIndex][innerIndex] = "X"
                
                print("")
                for outerIndex in 0..<lengthOfGrid {
                    for innerIndex in 0..<widthOfGrid {
                        if innerIndex != (widthOfGrid - 1) {
                            print("_\(internalGrid[outerIndex][innerIndex])_", terminator: "|")
                        } else {
                            print("_\(internalGrid[outerIndex][innerIndex])_")
                        }
                    }
                }
                print("")
                
                promptPlayer = false
            } else {
                print("I need a digit between 1 and \(gridSize)!") // this else statement only runs if the user doesn't type a number
            }
        }
        
        checkWinState(player: player1) // checkWinState is a long function put inside its own file. I tried doing this homework without using functions in case you all haven't covered them yet, but it got pretty brutal since I'm also trying to avoid hardcoding the win/lose positions
        
        if ongoingGame == false {
            break // oddly, we can have the checkWinState function set ongoingGame to false...but the game will keep running...so we need this extra break
        }
        
        print("\nNow my turn!\n")
        
        var computerPicks = true
        
        while computerPicks {
            
            let outerRandom = Int(arc4random_uniform(3)) // as dave posted in code snippets, we can use this built in function to randomize our games. But we need to make the result an Int, because otherwise we get an Int32, and we can't use that as an index
            let innerRandom = Int(arc4random_uniform(3))
            let computersChoice = internalGrid[outerRandom][innerRandom]
            
            if computersChoice == "X" || computersChoice == "O" {
                continue
            } else {
                internalGrid[outerRandom][innerRandom] = "O"
                
                for outerIndex in 0..<lengthOfGrid {
                    for innerIndex in 0..<widthOfGrid {
                        if innerIndex != (widthOfGrid - 1) {
                            print("_\(internalGrid[outerIndex][innerIndex])_", terminator: "|")
                        } else {
                            print("_\(internalGrid[outerIndex][innerIndex])_")
                        }
                    }
                }
                print("")
                
                computerPicks = false
            }
        }
        
        checkWinState(player: player1)
        
        if round == 9 { // it would be nice if we had some logic for checking to see if the game is unwinnable...but this will do for now
            print("Looks like a draw!")
            break
        }
    }
    
    // this stuff is only displayed once the game is over
    
    print("\nDo you want to try again?", prompt, separator: "\n")
    let playAgain = readLine()!
    
    if playAgain.lowercased() == "yes" {
        ongoingGame = true
        print("\nIf you want to change your name, type something new now. If not, just hit enter.", terminator: " ")
    } else {
        break
    }
}
