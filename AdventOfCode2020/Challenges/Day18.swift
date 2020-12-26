//
//  Day18.swift
//  AdventOfCode2020
//
//  Created by Apple  on 26/12/2020.
//

import Foundation

struct Day18 {
    
    // MARK: - Enums
    
    enum MathItem: Equatable {
        enum OperatorItem: String, Equatable {
            case add = "+"
            case multiply = "*"
        }
        
        case number(Int)
        case operatorItem(OperatorItem)
        case group([MathItem])
    }
    
    enum MathType {
        case leftToRight
        case advanceType
    }
    
    // MARK: Static Functions
    
    static func generateWithBrackets(from data: String, mathType: MathType) -> Int {
        var data = data
        
        while data.contains("(") {
            
            var lastOpenBracketIndex = 0
            for (index, char) in data.enumerated() {
                if char == "(" {
                    lastOpenBracketIndex = index
                } else if char == ")" {
                    let newStringCalc = data[data.index(data.startIndex, offsetBy: lastOpenBracketIndex + 1)..<data.index(data.startIndex, offsetBy: index)]
                    let asMaths = generate(from: String(newStringCalc))
                    let calculated = calculate(from: asMaths, mathType: mathType)
                    let replacingRange = data.index(data.startIndex, offsetBy: lastOpenBracketIndex)...data.index(data.startIndex, offsetBy: index)
                    data = data.replacingCharacters(in: replacingRange, with: "\(calculated)")
                    break
                }
            }
        }
        
        let asMaths = generate(from: data)
        let calculated = calculate(from: asMaths, mathType: mathType)
        return calculated
    }
    
    static func generate(from data: String) -> [MathItem] {
        return data.components(separatedBy: " ").compactMap({ str in
            if str == "+" || str == "*" {
                return .operatorItem(MathItem.OperatorItem.init(rawValue: str)!)
            } else if let number = Int(String(str)) {
                return .number(number)
            } else {
                fatalError()
            }
        })
    }

    static func calculate(from maths: [MathItem], mathType: MathType) ->Int {
        var currentValue = 0
        var currentOperator = MathItem.OperatorItem.add
        
        
        // Advance type orders the operator differently
        var maths = maths
        switch mathType {
        case .leftToRight:
            break
        case .advanceType:
            while maths.contains(.operatorItem(.add)) {
                let index = maths.firstIndex(of: .operatorItem(.add))!
                let range = maths.startIndex.advanced(by: index - 1)...maths.startIndex.advanced(by: index + 1)
                let newMaths = Array(maths[range])
                let newValue = calculate(from: newMaths, mathType: .leftToRight)
                
                maths.replaceSubrange(range, with: [.number(newValue)])
            }
        }

        for mathItem in maths {
            switch mathItem {
            case .number(let number):
                switch currentOperator {
                case .add:
                    currentValue += number
                case .multiply:
                    currentValue *= number
                }
            case .operatorItem(let newOperator):
                currentOperator = newOperator
            case .group(let newMaths):
                switch currentOperator {
                case .add:
                    currentValue += calculate(from: newMaths, mathType: mathType)
                case .multiply:
                    currentValue *= calculate(from: newMaths, mathType: mathType)
                }
            }
        }
        return currentValue
    }
    
    static func generateFromFullData(_ data: String, mathType: MathType) -> Int {
        return data
            .components(separatedBy: "\n")
            .filter({ !$0.isEmpty })
            .compactMap({ Day18.generateWithBrackets(from: $0, mathType: mathType) })
            .reduce(0, +)
    }
    
    static func generatePart1Value() -> Int {
        let data = DataHandler.getFileContents(for: .day18p1)
        return generateFromFullData(data, mathType: .leftToRight)
    }
    
    static func generatePart2Value() -> Int {
        let data = DataHandler.getFileContents(for: .day18p1)
        return generateFromFullData(data, mathType: .advanceType)
    }
}
