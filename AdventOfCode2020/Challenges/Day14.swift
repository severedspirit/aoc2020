//
//  Day14.swift
//  AdventOfCode2020
//
//  Created by Apple  on 20/12/2020.
//

import Foundation

struct Day14 {
    
    static func generatePart1Value() -> Int {
        let data = DataHandler.getFileContents(for: .day14p1)
        return computeValue(from: data)
    }
    
    static func generatePart2Value() -> Int {
        let data = DataHandler.getFileContents(for: .day14p1)
        return executeV2(from: data)
    }
    
    static func computeValue(from data: String) -> Int{
        let blankValue = "".padding(toLength: 36, withPad: "0", startingAt: 0).compactMap({ Character(extendedGraphemeClusterLiteral: $0) })
        var memoryDictionary: [Int: Int] = [:]
        
        var mask = ""
        let split = data.components(separatedBy: "\n").filter({ !$0.isEmpty })
        for line in split {
            let lineComponent = line.components(separatedBy: " = ")
            if lineComponent[0] == "mask" {
                mask = lineComponent[1]
            } else if lineComponent[0].hasPrefix("mem[") {
                let memoryLocation = Int(lineComponent[0].components(separatedBy: "[")[1].components(separatedBy: "]")[0])!
                let number = Int(lineComponent[1])!

                let valueToAdd = String(number, radix: 2)
                var value = blankValue
                let offset = mask.count - valueToAdd.count
                
                for (index, maskValue) in mask.enumerated() {
                    
                    if maskValue == "X" {
                        guard index >= offset else { continue }
                        let valueIndex = index - offset
                        let newValue = valueToAdd.character(at: valueIndex)
                        value[index] = newValue
                    } else if maskValue == "0" || maskValue == "1" {
                        value[index] = maskValue
                    } else {
                        fatalError()
                    }
                }
                let stringRep = String(value)
                let intValue = Int(stringRep, radix: 2)
                memoryDictionary[memoryLocation] = intValue
            } else {
                fatalError()
            }
        }
        
        return memoryDictionary.values.reduce(0, +)
    }
    
    static func executeV2(from data: String) -> Int{
        
        let blankValue = "".padding(toLength: 36, withPad: "0", startingAt: 0).compactMap({ Character(extendedGraphemeClusterLiteral: $0) })
        var memoryDictionary: [Int: Int] = [:]
        
        var mask = ""
        let split = data.components(separatedBy: "\n").filter({ !$0.isEmpty })
        for line in split {
            let lineComponent = line.components(separatedBy: " = ")
            if lineComponent[0] == "mask" {
                mask = lineComponent[1]
            } else if lineComponent[0].hasPrefix("mem[") {
                
                // Generate memory locations
                let initialMemoryLocation = Int(lineComponent[0].components(separatedBy: "[")[1].components(separatedBy: "]")[0])!
                let locationAsBinary = String(initialMemoryLocation, radix: 2)
                let paddedBinary = "".padding(toLength: 36 - locationAsBinary.count, withPad: "0", startingAt: 0) + locationAsBinary
                var value = blankValue
                for (index, maskValue) in mask.enumerated() {
                    if maskValue == "0" {
                        value[index] = paddedBinary.character(at: index)
                    } else if maskValue == "1" {
                        value[index] = "1"
                    } else if maskValue == "X" {
                        value[index] = "X"
                    } else {
                        fatalError()
                    }
                }
                
                
                let memoryLocations: [Int]
                if value.contains("X") {
                    // store number into all keys
                    memoryLocations = generateStringMaps(from: value).compactMap({ Int($0, radix: 2)})
                } else {
                    memoryLocations = [initialMemoryLocation]
                }
                
                let number = Int(lineComponent[1])!
                for memoryLocation in memoryLocations {
                    memoryDictionary[memoryLocation] = number
                }
            } else {
                fatalError()
            }
        }
        
        return memoryDictionary.values.reduce(0, +)
    }
    
    static func generateStringMaps(from characters: [Character]) -> [String] {
        var stringReps: [String] = [""]
        
        for char in characters {
            if char == "0" || char == "1" {
                stringReps = stringReps.compactMap({ "\($0)\(char)" })
            } else if char == "X" {
                stringReps = stringReps.compactMap({ "\($0)1" }) + stringReps.compactMap({ "\($0)0" })
            } else {
                fatalError()
            }
        }
        return stringReps
    }
    
    static func generateStringMaps(from stringValue: String) -> [String] {
        return generateStringMaps(from: Array(stringValue))
    }
}
