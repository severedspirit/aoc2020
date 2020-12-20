//
//  Day15.swift
//  AdventOfCode2020
//
//  Created by Apple  on 20/12/2020.
//

import Foundation

struct Day15 {
    
    static func generatePart1Value() -> Int {
        return getMemoryGameNumber(from: "0,1,5,10,3,12,19", turnNumber: 2020)
    }
    
    static func generatePart2Value() -> Int {
        return getMemoryGameNumber(from: "0,1,5,10,3,12,19", turnNumber: 30000000)
    }
     
     static func getMemoryGameNumber(from data: String, turnNumber: Int) -> Int {
         
         var numberDictionary: [Int: [Int]] = [:]
         let inputNumbers = data.components(separatedBy: ",").compactMap({ Int($0) })
         for (index, number) in inputNumbers.enumerated() {
             numberDictionary[number] = (numberDictionary[number] ?? []) + [index + 1]
         }
         
         var lastNumberSpoken = inputNumbers.last!
         for currentTurn in (numberDictionary.count + 1)...turnNumber {
            
            numberDictionary[lastNumberSpoken] = (numberDictionary[lastNumberSpoken] ?? []) + [currentTurn - 1]
             
             let existingNumberKeys = numberDictionary[lastNumberSpoken] ?? []
             
             if existingNumberKeys.isEmpty {
                 fatalError()
             } else if existingNumberKeys.count == 1 {
                 // If last number had not been spoken before
                 lastNumberSpoken = 0
             } else  {
                 // If last number had been spoken before
                 let lastIndex = existingNumberKeys[existingNumberKeys.count - 1]
                 let priorIndex = existingNumberKeys[existingNumberKeys.count - 2]
                 if existingNumberKeys.count == 3 {
                     // We can remove the first item
                     numberDictionary[lastNumberSpoken] = [priorIndex, lastIndex]
                 }
                 lastNumberSpoken = lastIndex - priorIndex
             }
         }
         return lastNumberSpoken
     }
}
