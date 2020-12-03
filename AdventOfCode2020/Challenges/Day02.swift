//
//  Day02.swift
//  AdventOfCode2020
//
//  Created by Apple  on 02/12/2020.
//

import Foundation

struct Day02 {
    struct PasswordVerification {
        enum ValidationType {
            case sledRental
            case officialToboggan
        }
        
        let instruction1: Int
        let instruction2: Int
        let characterValue: Character
        let password: String
        
        static func generate(from stringValue: String) -> PasswordVerification {
            let cleanStr = stringValue.replacingOccurrences(of: "-", with: " ").replacingOccurrences(of: ":", with: "")
            let splitStr = cleanStr.split(separator: " ")
            return PasswordVerification(instruction1: Int(splitStr[0])!, instruction2: Int(splitStr[1])!, characterValue: splitStr[2].characterRep, password: String(splitStr[3]))
        }
        
        func isValid(for validation: ValidationType) -> Bool {
            switch validation {
            case .sledRental:
                let characterCount = password.filter({ $0 == characterValue }).count
                return characterCount >= instruction1 && characterCount <= instruction2
            case .officialToboggan:
                let check1 = password.character(at: instruction1 - 1) == characterValue
                let check2 = password.character(at: instruction2 - 1) == characterValue
                return check1 != check2
            }
        }
    }
    
    static func generatePart1Value() -> Int {
        let data = DataHandler.getFileContents(for: .day02p1)
        let strValues = data.split(separator: "\n").compactMap({ String($0) })
        return strValues.compactMap({ PasswordVerification.generate(from: $0) }).filter({ $0.isValid(for: .sledRental) }).count
    }
    
    static func generatePart2Value() -> Int {
        let data = DataHandler.getFileContents(for: .day02p1)
        let strValues = data.split(separator: "\n").compactMap({ String($0) })
        return strValues.compactMap({ PasswordVerification.generate(from: $0) }).filter({ $0.isValid(for: .officialToboggan) }).count
    }
}
