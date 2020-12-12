//
//  Day10.swift
//  AdventOfCode2020
//
//  Created by Apple  on 12/12/2020.
//

import Foundation

struct Day10 {
    
    struct Jolts {
        let jolt1: [Int]
        let jolt2: [Int]
        let jolt3: [Int]
    }
    
    // MARK: - Functions
    
    static func generatePart1Value() -> Int {
        let data = DataHandler.getFileContents(for: .day10p1)
        return getNumbersInt(from: data)
    }
    
    static func generatePart2Value() -> Int {
        let data = DataHandler.getFileContents(for: .day10p1)
        return calculateValue(data: data)
    }
    
    static func getNumbersInt(from data: String) -> Int {
        let result = getNumbers(from: data)
        let total = result.jolt1.count * result.jolt3.count
        return total
    }
    
    static func getNumbers(from data: String) -> Jolts {
        let split = data
            .components(separatedBy: "\n")
            .compactMap({ Int($0) })
            .sorted()
        return getNumbers(from: split)
    }
    
    static func getNumbers(from data: [Int]) -> Jolts {
        var currentNumber = 0
        var jolt1: [Int] = []
        var jolt2: [Int] = []
        var jolt3: [Int] = []
        
        var index = 0
        while index < data.count {
            let maxIndex = index + 3 <= data.count ? index + 3 : data.count
            let slice = data[index..<maxIndex]
            let smallestNumber = slice.first!
            if smallestNumber == currentNumber + 1 {
                jolt1.append(smallestNumber)
            } else if smallestNumber == currentNumber + 2 {
                jolt2.append(smallestNumber)
            } else if smallestNumber == currentNumber + 3 {
                jolt3.append(smallestNumber)
            } else {
                fatalError()
            }
            index += 1
            currentNumber = smallestNumber
        }
        
        // Include maximum
        jolt3.append(currentNumber + 3)
        
        return .init(jolt1: jolt1, jolt2: jolt2, jolt3: jolt3)
    }
    
    // Ultimately this was not used but this can be used as an alternative way to calculate the value
    static func recursivelyCalculateValue(from data: [Int], index: Int = 0, currentNumber: Int = 0) -> Int {
        var value = 0
        let dataCount = data.count
        let numberToReach = data.last
        
        var index = index
        while index < data.count  {
            let maxIndex = index + 3 <= dataCount ? index + 3 : dataCount
            let slice = Array(data[index..<maxIndex])

            index += 1
            var foundAValueToUse = false
            for i in 0..<slice.count {
                let newNumber = slice[i]
                guard newNumber <= currentNumber + 3 else { return value }
                
                // Got an answer
                if newNumber == numberToReach {
                    return value + 1
                }
                
                // Not got the answer yet
                foundAValueToUse = true
                value += recursivelyCalculateValue(from: data, index: index + i, currentNumber: newNumber)
                break
            }
            
            if !foundAValueToUse {
                return value
            }
        }
        
        return value
    }
    
    static func calculateValue(data: String) -> Int {
        let split = data
            .components(separatedBy: "\n")
            .compactMap({ Int($0) })
            .sorted()
        return calculateValue(data: split)
    }
    
    static func calculateValue(data: [Int]) -> Int {
        var data = data
        // This is the final adapter jumt thats possible
        data.append(data.last! + 3)
        
        var currentTotals: [Int: Int] = [:]
        // As the calculation starts with the first index the value will alwas be the root value
        currentTotals[0] = data.first
        
        // The result is calculated from its previous results (ie its value at -1, -2 & -3). As it progresses it
        // adds those values together and stores it.
        for item in data {
            let adapterFrom1JumpAgo = currentTotals[item - 1] ?? 0
            let adapterFrom2JumpAgo = currentTotals[item - 2] ?? 0
            let adapterFrom3JumpAgo = currentTotals[item - 3] ?? 0
            currentTotals[item] = adapterFrom1JumpAgo + adapterFrom2JumpAgo + adapterFrom3JumpAgo
        }
        
        // The result is the total value in the last index as that is the final adapter
        return currentTotals[data.last!]!
    }
}
