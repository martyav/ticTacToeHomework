//
//  DrawGrid.swift
//  ticTacToeHomework
//
//  Created by Marty Hernandez Avedon on 08/28/17.
//  Copyright © 2017 Marty's . All rights reserved.
//

import Foundation

func drawGrid(length: Int, width: Int, contents: [[String]]) {
    print("")
    
    for outerIndex in 0..<length {
        for innerIndex in 0..<width {
            if innerIndex != (width - 1) {
                if outerIndex != (length - 1) {
                    print("_\(contents[outerIndex][innerIndex])_", terminator: "|")
                } else {
                    print(" \(contents[outerIndex][innerIndex]) ", terminator: "|")
                }
            } else {
                if outerIndex != (length - 1) {
                    print("_\(contents[outerIndex][innerIndex])_")
                } else {
                    print(" \(contents[outerIndex][innerIndex]) ")
                }
            }
        }
    }
    
    print("")
}
