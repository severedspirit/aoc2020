//
//  Day09.swift
//  AdventOfCode2020
//
//  Created by Apple  on 09/12/2020.
//

import Foundation

struct Day09 {

    static func getAddition(from ary: [Int], toMakeValue target: Int) -> (Int, Int)? {
        for i in 0..<(ary.count - 1) {
            for j in 1..<(ary.count) {
                guard i != j else { continue }
                if ary[i] + ary[j] == target {
                    return (ary[i], ary[j])
                }
            }
            
        }
        return nil
    }

    static func getContinuosNumbers(from ary: [Int], toMake: Int) -> [Int]? {
        for i in 0..<ary.count {
            var aryValues: [Int] = []
            var currentTotal = 0
            var insideIndex = 0
            while currentTotal < toMake {
                let valueAtIndex = ary[i + insideIndex]
                currentTotal += valueAtIndex
                aryValues.append(valueAtIndex)
                if currentTotal == toMake {
                    return aryValues
                }
                insideIndex += 1
            }
        }
        return nil
    }
    
    static func getInvalidNumber(from data: String, subsetLength: Int) -> Int {
        let digits = data.components(separatedBy: "\n").compactMap({ Int($0) })
        for i in 0..<(digits.count - subsetLength) {
            let valueToMake = digits[i + subsetLength]
            
            let subset = Array(digits[i..<(i + subsetLength)])
            if Day09.getAddition(from: subset, toMakeValue: valueToMake) == nil {
                return valueToMake
            }
        }
        fatalError()
    }
    
    static func getEncryptionWeakness(from data: String, invalidNumber: Int) -> Int {
        let digits = data.components(separatedBy: "\n").compactMap({ Int($0) })
        let continuousValue = getContinuosNumbers(from: digits, toMake: invalidNumber)!
        return continuousValue.min()! + continuousValue.max()!
    }
    
    static func generatePart1Value() -> Int {
        let data = DataHandler.getFileContents(for: .day09p1)
        return getInvalidNumber(from: data, subsetLength: 25)
    }
    
    static func generatePart2Value() -> Int {
        let data = DataHandler.getFileContents(for: .day09p1)
        let invalidNumber = getInvalidNumber(from: data, subsetLength: 25)
        return getEncryptionWeakness(from: data, invalidNumber: invalidNumber)
    }
}
