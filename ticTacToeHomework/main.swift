//
//  main.swift
//  ticTacToeHomework
//
//  Created by Marty Hernandez Avedon on 08/27/17.
//  Copyright © 2017 Marty's . All rights reserved.
//

import Foundation

var ongoingGame: Bool

let prompt = ">> "
let player1Symbol = "✘"
let opponentSymbol = "⦿"
var player1: String = "Anonymous"

let lengthOfGrid = 3
let widthOfGrid = 3
let gridSize = lengthOfGrid * widthOfGrid

var internalGrid: [[String]]
var innerArray: [String]

print(" _Tic_|_____|_____ ")
print("      | Tac |      ")
print(" _____|_____|_Toe_ ")
print("      |     |       \n")
print("Welcome! What is your name?", terminator: " ")

while true {
    print("If you want to stop playing, type 'quit' to exit.", prompt, separator: "\n")
    
    let playersResponse = readLine()!
    
    let quitCommand = try! NSRegularExpression(pattern: "\\b(quit)\\b", options: .caseInsensitive)
    let quitMatch = quitCommand.matches(in: playersResponse, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, playersResponse.characters.count))
    
    if quitMatch.count > 0 {
        print("Bye-bye!")
        break
    }
    
    if playersResponse != "" {
        player1 = playersResponse.uppercased()
    }
    
    print("\nHi, \(player1)! Let's get started!")
    print("Drawing the board...", "\n")
    
    sleep(1)
    
    print("Try to beat me! Make a straight line of X's inside the grid and win! \n")
    
    internalGrid = []
    innerArray = []
    
    for number in 1...gridSize {
        innerArray.append(String(number))
        
        if number % widthOfGrid == 0 { 
            internalGrid.append(innerArray)
            innerArray = []
        }
    }
    
    drawGrid(length: lengthOfGrid, width: widthOfGrid, contents: internalGrid)
    
    ongoingGame = true
    
    while ongoingGame {
        var promptPlayer = true
        
        while promptPlayer {
            print("\nType a number to indicate where on the grid you want your X to go!", prompt, separator: "\n")
            
            let playersChoice = readLine()!
            
            if let coordinate = Int(playersChoice) {
                guard coordinate < 10 else {
                    print("That number is too big!")
                    continue
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
                
                drawGrid(length: lengthOfGrid, width: widthOfGrid, contents: internalGrid)
                
                promptPlayer = false
            } else {
                print("I need a digit between 1 and \(gridSize)!")
            }
        }
        
        ongoingGame = shouldGameKeepRunning(inGrid: internalGrid, withLength: lengthOfGrid, andWidth: widthOfGrid)
        
        if ongoingGame == false {
            break
        }
        
        if isGridIsFilled(internalGrid) {
            print("Looks like a draw!")
            break
        }
        
        print("Now my turn!")
        
        var computerPicks = true
        
        while computerPicks {
            
            sleep(1)
            
            let length = UInt32(lengthOfGrid)
            let width = UInt32(widthOfGrid)
            
            let outerRandom = Int(arc4random_uniform(length))
            
            let innerRandom = Int(arc4random_uniform(width))
            let computersChoice = internalGrid[outerRandom][innerRandom]
            
            if computersChoice == "X" || computersChoice == "O" {
                print("...hm...")
                continue
            } else {
                internalGrid[outerRandom][innerRandom] = "O"
                
                drawGrid(length: lengthOfGrid, width: widthOfGrid, contents: internalGrid)
                
                computerPicks = false
            }
        }
        
        ongoingGame = shouldGameKeepRunning(inGrid: internalGrid, withLength: lengthOfGrid, andWidth: widthOfGrid)
        
        if isGridIsFilled(internalGrid) {
            print("Looks like a draw!")
            break
        }
    }
    
    print("\nDo you want to try again?", prompt, separator: "\n")
    let playAgain = readLine()!
    
    let yesCommand = try! NSRegularExpression(pattern: "\\b(yes)\\b", options: .caseInsensitive)
    let yesMatch = yesCommand.matches(in: playAgain, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, playAgain.characters.count))
    
    if yesMatch.count > 0 {
        ongoingGame = true
        print("\nHi again, \(player1). If you want to change your name, type something new now. If not, just hit enter.", terminator: " ")
    } else {
        print("Bye-bye!")
        break
    }
}
