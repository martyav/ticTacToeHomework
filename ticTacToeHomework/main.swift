//
//  main.swift
//  ticTacToeHomework
//
//  Created by Marty Hernandez Avedon on 08/27/17.
//  Copyright © 2017 Marty's . All rights reserved.
//

import Foundation // importing Foundation lets you use many basic functions & classes

var ongoingGame: Bool

let prompt = ">> "
var player1: String = "Anonymous" // this gives the player a default name

let lengthOfGrid = 3 // we make these variable so we can play different-sized games
let widthOfGrid = 3 // our game logic really only allows for square grids, tho!
let gridSize = lengthOfGrid * widthOfGrid

var internalGrid: [[String]] // our game board
var innerArray: [String] // this will be used to fill our grid with rows

var markedSpaces: Int

print(" _Tic_|_____|_____ ")
print("      | Tac |      ")
print(" _____|_____|_Toe_ ")
print("      |     |       \n")
print("Welcome! What is your name?", terminator: " ")

while true { // we want our game to keep running until we break this loop and quit
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
     
     If we used something called regular expressions, we wouldn't have to use
     .lowercased(), but regular expressions are a much more complicated topic
     than String methods!
     
     See https://code.tutsplus.com/tutorials/swift-and-regular-expressions-swift--cms-26626
     */
    
    if playersResponse != "" {
        player1 = playersResponse
        /*
         if we get no answer the first time the player plays, the default value
         is "Anonymous". If they win or lose a game and restart, they can choose
         to keep their current name or change it
         */
    }
    
    print("\nHi, \(player1)! Let's get started!")
    print("Drawing the board...", "\n")
    
    sleep(1) // the pause makes it seem like drawing a grid is really intense
    
    print("Try to beat me! Make a straight line of X's inside the grid and win! \n")
    
    internalGrid = [] // we set the grid to empty
    innerArray = [] // we initialize this as empty, too
    
    /*
     setting these two as empty down here ensures the grid will be fresh every
     time the player starts a new game.
     */
    
    for number in 1...gridSize {
        innerArray.append(String(number))
        // on each trip thru a row, we append the new number to our inner array
        
        if number % widthOfGrid > 0 { // These are our first & middle columns
            if gridSize - number > widthOfGrid {
                print("_\(number)_|", terminator: "")
            } else {
                print(" \(number) |", terminator: "") // the last row
            }
        } else { // This is our last column -- 3, 6, 9, if we're doing a 3x3 grid
            if gridSize - number > widthOfGrid - 1 {
                print("_\(number)_")
            } else {
                print(" \(number) ") // the last row
            }
            
            internalGrid.append(innerArray)
            /*
             once we reach the last column in a row, we append the innerArray
             we just filled up...
             */
            
            innerArray = []
            /*
             ...and then empty the innerArray for the next trip through a row
             */
        }
        
        /*
         Note: We fill up our grid while printing another grid just for show.
         Doing it this way means we don't have to write two loops -- one to fill
         the grid and one to display it
         */
    }
    
    ongoingGame = true // we have a player and a grid! we can now start playing!
    markedSpaces = 0 // our grid hasn't been played on yet
    
    while ongoingGame {
        var promptPlayer = true
        
        while promptPlayer {
            print("\nType a number to indicate where on the grid you want your X to go!", prompt, separator: "\n")
            
            let playersChoice = readLine()!
            
            if let coordinate = Int(playersChoice) {
                guard coordinate < 10 else {
                    /*
                     guard statements help us handle errors in user input before
                     we get too far into the loop
                     */
                    
                    print("That number is too big!")
                    /*
                     it's a good idea to give your user advice on what wrong
                     when they make an error
                     */
                    
                    continue // go to top of the promptPlayer loop and start again
                }
                
                guard coordinate > 0 else {
                    print("That number is too small!")
                    continue
                }
                
                let innerIndex: Int
                let outerIndex: Int
                
                /*
                 these calculations are only true for square grids...if you
                 can figure out the math for a grid with unequal sides, congrats.
                 */
                
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
                markedSpaces += 1
                
                print("")
                for outerIndex in 0..<lengthOfGrid {
                    for innerIndex in 0..<widthOfGrid {
                        if innerIndex != (widthOfGrid - 1) {
                            if outerIndex != (lengthOfGrid - 1) {
                                print("_\(internalGrid[outerIndex][innerIndex])_", terminator: "|")
                            } else {
                                print(" \(internalGrid[outerIndex][innerIndex]) ", terminator: "|")
                            }
                        } else {
                            if outerIndex != (lengthOfGrid - 1) {
                                print("_\(internalGrid[outerIndex][innerIndex])_")
                            } else {
                                print(" \(internalGrid[outerIndex][innerIndex]) ")
                            }
                        }
                    }
                }
                
                print("")
                
                promptPlayer = false
            } else {
                print("I need a digit between 1 and \(gridSize)!")
                /*
                 this else statement only runs if the user doesn't type a number
                 */
            }
        }
        
        checkWinState(player: player1)
        /*
         checkWinState is a long function put inside its own file. I tried doing
         this homework without using any functions in case you all haven't
         covered them yet, but it got pretty brutal since I'm also trying to
         avoid hardcoding the win/lose positions
         */
        
        if ongoingGame == false {
            break
            /*
             oddly, we can have the checkWinState function set ongoingGame to
             false...but the game will keep running...so we need this block to
             break the loop before the computer takes a turn.
             */
        }
        
        print("\nNow my turn!\n")
        
        var computerPicks = true
        
        while computerPicks {
            sleep(1) // makes it seem like the computer is thinking carefully
            
            let length = UInt32(lengthOfGrid) // we need UINT32s for the method below
            let width = UInt32(widthOfGrid)
            
            let outerRandom = Int(arc4random_uniform(length))
            /*
             as dave posted in code snippets, we can use this built in function
             to randomize our games. But we need to make the result an Int,
             because otherwise we get an Int32, and we can't use that type as an
             index
             */
            
            let innerRandom = Int(arc4random_uniform(width))
            let computersChoice = internalGrid[outerRandom][innerRandom]
            
            if computersChoice == "X" || computersChoice == "O" {
                // doublecheck that there are spots still open!
                if markedSpaces != gridSize {
                    continue
                } else {
                    break
                }
            } else {
                internalGrid[outerRandom][innerRandom] = "O"
                markedSpaces += 1
                
                for outerIndex in 0..<lengthOfGrid {
                    for innerIndex in 0..<widthOfGrid {
                        if innerIndex != (widthOfGrid - 1) {
                            if outerIndex != (lengthOfGrid - 1) {
                                print("_\(internalGrid[outerIndex][innerIndex])_", terminator: "|")
                            } else {
                                print(" \(internalGrid[outerIndex][innerIndex]) ", terminator: "|")
                            }
                        } else {
                            if outerIndex != (lengthOfGrid - 1) {
                                print("_\(internalGrid[outerIndex][innerIndex])_")
                            } else {
                                print(" \(internalGrid[outerIndex][innerIndex]) ")
                            }
                        }
                    }
                }
                print("")
                
                computerPicks = false
            }
        }
        
        checkWinState(player: player1)
        
        if markedSpaces == gridSize {
            /*
             it would be nice if we had some logic for checking to see if the
             game is unwinnable...but this will do for now
             */
            
            print("Looks like a draw!")
            break
        }
    }
    
    // this stuff below is only displayed once the game is over
    
    print("\nDo you want to try again?", prompt, separator: "\n")
    let playAgain = readLine()!
    
    if playAgain.lowercased() == "yes" {
        ongoingGame = true
        print("\nHi again, \(player1). If you want to change your name, type something new now. If not, just hit enter.", terminator: " ")
    } else {
        print("Bye-bye!")
        break
    }
}
