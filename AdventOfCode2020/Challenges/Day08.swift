//
//  Day08.swift
//  AdventOfCode2020
//
//  Created by Apple  on 08/12/2020.
//

import Foundation

struct Day08 {
    
    enum InstructionId: String {
        case noOperation = "nop"
        case accumulator = "acc"
        case jump = "jmp"
    }
    
    enum CompletionReason {
        case infiniteLoopFound
        case success
    }
    
    static func generatePart1Value() -> Int {
        return getValue(from: DataHandler.getFileContents(for: .day08p1)).0
    }
    
    static func generatePart2Value() -> Int {
        return getAttemptAccumulationFix(DataHandler.getFileContents(for: .day08p1))
    }
    
    static func getValue(from data: String) -> (Int, CompletionReason) {
        let instructions = data
            .components(separatedBy: "\n")
            .filter({ !$0.isEmpty })
            .compactMap({ generateIntruction(from: $0) })
        return getValue(from: instructions)
    }
    
    static func getValue(from instructions: [(InstructionId, Int)]) -> (Int, CompletionReason) {
        var index = 0
        var accumulator = 0
        var existingIndexes: [Int] = []
        while true {
            
            // If index is at the bottom the executions must be finished
            if index == instructions.count {
                return (accumulator, .success)
            }
            
            // Check existing indexes
            if existingIndexes.contains(index) {
                return (accumulator, .infiniteLoopFound)
            }
            existingIndexes.append(index)
            
            let (instruction, value) = instructions[index]
            switch instruction {
            case .accumulator:
                accumulator += value
            case .jump:
                index += value - 1
            case .noOperation:
                break
            }
            
            index += 1
        }
        
        // Should never be called
        fatalError()
    }
    
    static func getAttemptAccumulationFix(_ data: String) -> Int {
        let value = data.components(separatedBy: "\n")
            .filter({ !$0.isEmpty })
            .compactMap({ generateIntruction(from: $0) })
        return getAttemptAccumulationFix(value)
    }
    
    static func getAttemptAccumulationFix(_ instructions: [(InstructionId, Int)]) -> Int {
        for (index, instruction) in instructions.enumerated() {
            var newInstructions = instructions
            switch instruction.0 {
            case .accumulator:
                // Accumulated instructions are not an issue so do not need to be used
                continue
            case .jump:
                newInstructions[index] = (.noOperation, instruction.1)
            case .noOperation:
                newInstructions[index] = (.jump, instruction.1)
            }
            
            let calculation = getValue(from: newInstructions)
            switch calculation.1 {
            case .infiniteLoopFound:
                // Ignore infinite loops
                break
            case .success:
                return calculation.0
            }
        }
        
        // Should never be called
        fatalError()
    }
    
    static func generateIntruction(from data: String) -> (InstructionId, Int) {
        let items = data.components(separatedBy: " ")
        let instructionId = InstructionId(rawValue: items[0])!
        let value = Int(items[1])!
        return (instructionId, value)
    }
}
