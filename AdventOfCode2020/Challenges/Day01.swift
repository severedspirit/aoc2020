//
//  Day01.swift
//  AdventOfCode2020
//
//  Created by Apple  on 02/12/2020.
//

import Foundation

struct Day01 {
    
    static func generatePart1Value() -> Int {
        let data = DataHandler.getFileContents(for: .day01p1)
        let intValues = data.split(separator: "\n").compactMap({ Int($0) })
        return getMultipliedValue(from: intValues, thatAddUpTo: 2020, size: 2)!
    }
    
    static func generatePart2Value() -> Int {
        let data = DataHandler.getFileContents(for: .day01p1)
        let intValues = data.split(separator: "\n").compactMap({ Int($0) })
        return getMultipliedValue(from: intValues, thatAddUpTo: 2020, size: 3)!
    }
    
    static func getMultipliedValue(from values: [Int], thatAddUpTo total: Int, size: Int) -> Int? {
        let values = generateValidSumTotals(from: values, thatAddUpTo: total, size: size)
        guard !values.isEmpty else { return nil }
        return values.reduce(1, *)
    }
    
    static func generateValidSumTotals(from values: [Int], thatAddUpTo total: Int, size: Int, existingValues: [Int] = [], existingIndexes: [Int] = []) -> [Int] {
        guard existingValues.count < size else { return [] }
        
        for (index, value) in values.enumerated() {
            
            // We shouldn't reuse a index, keeps the values unique
            guard !existingIndexes.contains(index) else { continue }
            
            // Generate new values
            let newValues = existingValues + [value]
        
            // Calculate the total and ensure its less than the intended total,
            // if it is we don't need to perform further calculations
            let totalledValue = newValues.reduce(0, +)
            guard totalledValue <= total else { continue }
            
            // If we're at the correct size, then return values if the total is correct otherwise continue
            if newValues.count == size {
                guard totalledValue == total else { continue }
                return newValues
            }
            
            // Value not at correct size so continue to calculate
            let foundValue = generateValidSumTotals(from: values, thatAddUpTo: total, size: size, existingValues: newValues, existingIndexes: existingIndexes + [index])
            if !foundValue.isEmpty {
                return foundValue
            }
        }
        
        return []
    }
}
