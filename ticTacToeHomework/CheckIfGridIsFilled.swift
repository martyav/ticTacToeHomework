//
//  CheckIfGridIsFilled.swift
//  ticTacToeHomework
//
//  Created by Marty Hernandez Avedon on 08/28/17.
//  Copyright © 2017 Marty's . All rights reserved.
//

import Foundation

func isGridIsFilled(_ grid: [[String]]) -> Bool {
    let flattenedGrid = grid.flatMap({$0}).joined()
    let regExp = try! NSRegularExpression(pattern: "\\d")
    let matchResult = regExp.matches(in: flattenedGrid, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, flattenedGrid.characters.count))
    
    
    if matchResult.count > 0 {
        return false
    } else {
        return true
    }
}
